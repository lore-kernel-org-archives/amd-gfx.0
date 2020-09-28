Return-Path: <SRS0=mGSI=DF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3C1EC2D0A8
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2020 10:48:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 791282080A
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2020 10:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="xHSNaZov"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 791282080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02A9D6E11C;
	Mon, 28 Sep 2020 10:48:10 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAA236E11C
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2020 10:48:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XhqJPny9bul9wn5xK3sT26d1K1mBBJH1nHoXf7ItKkghHB3TVTic59AfRIs8jm47dk4RQPYHLQzZwRQDCi4KrbdCEALf1g/UdwfBpIubYZIkj6mdAdUOKfo0+rfVWMtfjDXBECnBeL94tOl/USC5KTqWVAtUZZrxyMfrAkf0wIcw7thccJsEBBjPDz6Yvn3HwyDGDhYCFZ9JsmD6UxNSxEvWWKlao66xSkWouSenWmdJfkPxqObzfIl/WE4KEMrAAJJWSbFFuEJMYGtxcFFxO1GPEmUstRDSDVgpfQP6Egpb+7a8Sc9ysWpIWuQFno4h4Fsys013R4AHkclN8wKwFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QYblMulkPRY/iIOZTkUWlVpga9FXjPr1arPONRW13Wo=;
 b=HfeJLsK+Kp+0OkbPIGOu64gd7hKWcN6Xqdp8VeRGCg9NVpw5kIEVN+D4QEGYVi0InfD7UXcpmjy/E+5HpgsocvpciS/vqDNviP8i24321PgZGO7YaKD0pZz/YVsWcOstYSmdELdBUSvBIRtG2MWKBqI5kye7GiJOfoZMXzQgDQehQb41rG19QZ8iKsD31bq+O4oDr+aQjEtgQOAVYRGaCyXuTFpCisO5QAkoyNJCePLLndqZszrz1Khg+hjs8B9bBIYTqatah+QCiPi8Q/t2tWY4PsP4aUVfOwWCgWBFxHBKHLTTG84y4c8Di480SXXaKxgJbKYs78QPsd3DpXp3tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QYblMulkPRY/iIOZTkUWlVpga9FXjPr1arPONRW13Wo=;
 b=xHSNaZovBXCM+jea/etGyzugjHju1m5VUAQxPElw/WV1rw59wBFbWqxzEhH2yx7TedQRN7jU77YmIDW30ugGwyrj0Q0MNjyjIDUIhy/9hKMu3X076H+8qIm0nq1BfdurPvirl8/FpaSw5l3J/x6XhybYIl8W+S/L9evYALVfcyM=
Received: from DM6PR12MB3721.namprd12.prod.outlook.com (2603:10b6:5:1c2::18)
 by DM6PR12MB4233.namprd12.prod.outlook.com (2603:10b6:5:210::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Mon, 28 Sep
 2020 10:48:04 +0000
Received: from DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::a15f:ea36:aa06:2ae1]) by DM6PR12MB3721.namprd12.prod.outlook.com
 ([fe80::a15f:ea36:aa06:2ae1%4]) with mapi id 15.20.3412.029; Mon, 28 Sep 2020
 10:48:04 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Errabolu, Ramesh" <Ramesh.Errabolu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/3] drm/amd/amdgpu: Define and implement a function that
 collects number of waves that are in flight.
Thread-Topic: [PATCH 2/3] drm/amd/amdgpu: Define and implement a function that
 collects number of waves that are in flight.
Thread-Index: AQHWk4ey+IWBKLUu3EOWt5c3yH+gFKl94bZA
Date: Mon, 28 Sep 2020 10:48:04 +0000
Message-ID: <DM6PR12MB3721DBBCD6F9881743DF7BAF85350@DM6PR12MB3721.namprd12.prod.outlook.com>
References: <20200925220306.31013-1-Ramesh.Errabolu@amd.com>
In-Reply-To: <20200925220306.31013-1-Ramesh.Errabolu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-09-28T10:48:02Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=b3631aec-470d-4e69-9391-0000ce8f8c74;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-09-28T10:47:58Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: e6cf4e24-45cb-4a01-ad06-0000e210731b
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-09-28T10:48:02Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 0ce13dc2-b6ff-4b2d-90b3-0000394fb411
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:fea8:1c80:6680:5c68:43d4:fbcf:8988]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a0295099-2267-4d33-a95f-08d8639bfa83
x-ms-traffictypediagnostic: DM6PR12MB4233:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB423346F50FB7FB4F58FBD48685350@DM6PR12MB4233.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dzztNgOa6c8LZMvLQvy3OjvJUi98JkHeMosfHbMax4RcqUlE0GmelR3XOFhwU1I51wZhId43qBVBVmV11zYf1Z4hRxeujCNsvIK7w8MLm517epjmpoyZmyfrGrOUxvr0PHmy6r40Qs5y5YputyqwSrspBRBcvU7Dtp7503MUHpzk80ptNVtZNbneMF/xHne7SuNNUivNhdkGMyJ4FUnjSYnCtK6pXEAcpkl5G3r9vA+noAF1aON2ovN1tLMqpIg8at0yvASphP69KyH6Zfm9SMqA0+h4YYwuLHuxIcOFJ+n8DwmOny2nKEIEN0SIaYxV8xB5XUZFTpayosjMI0kj7yvr5K/rC6SLaCN8Auc0KArguych0rX7jX+Ee7lMTh9s5+uF0mUSUMMT4DNHInwD8ZLlJdkO8gREdRLp/7bnBUOsS2JBdr9ks8wPJ6bSXRamTbNcEsXmFz6elJN5e9IPsw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3721.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(346002)(376002)(366004)(2906002)(53546011)(6506007)(4326008)(8676002)(966005)(186003)(86362001)(83080400001)(83380400001)(71200400001)(66946007)(316002)(33656002)(5660300002)(76116006)(30864003)(52536014)(8936002)(55016002)(9686003)(7696005)(110136005)(66476007)(66556008)(64756008)(66446008)(478600001)(45080400002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: Rb2/Svb2yl2vA6YXsJDcH1np/0lB5ZnxKfnUsP8VRBVqGhD72QxhSjQG+21nb9pxBevDjdyEek2gzTDFGKh21NrXfQi5bIZzmE4Hi4ucWY8rY6q6fu8H+zThGzIPsvk7whT3rU00WT8LIRzYo7uNHxiKhbiefVX7yKTYyvZRd9g5QZJyNE6Q3BJsuTX6JKm2P1lmP0kH6tRXxms6guYqYKFObrl8uTW4AxprBArWB7ccXnkKCyHsv1mmA5ZCu2nIcJmFHyo9S7mJdoYmENNZ3HyXZQiuS1nSK/Z787aiE4bE729u0E5f4AFEC2PGRfsMHBRIr6viXakHu2HdiwNB1PoBRFRqWL8PDwW39EEs0lEkifHRNBnInuG49hbeitbpFrBVmDlHwWQuzDvevTj6QyEPWj5iHSGM/O/ZycsgYXr4gDriYzWMsXHHyO5YcRAvFvi/tVnyo2q1nwF73wmWkk/z7ZmFFW0IwU45+jhoAi3OP4ylRtuXIkScRhrkwSwa422sU5kmINSjeyQIDtnPVPk2M/W7AWduZsDa9VYs+++MIwbWItrta+1OPbLDjfw2VyDgQNmEnO3GIwdu/r/NubsldgWNG6YTP1V2mgAPGvrGb5xL6Ve3+T4pHjmiwKEJnDpZAsya2I2n0D8j9Sg6BYdvDVadg2ktsJUbdOhUNlmHsxdWMKFIZ4nt+lvn9v69ZPze69rKmoWXK/icNpoX0g==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3721.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0295099-2267-4d33-a95f-08d8639bfa83
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2020 10:48:04.5619 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UTnidsmIpHWGC5bwcBj8FORs++sD6S2vCJProjRF1IiJQ6caTIF8OXIQs8r0HLCNrbHqSn574YxrJ+581dk6YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4233
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: "Errabolu, Ramesh" <Ramesh.Errabolu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Some minor typos

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Ramesh Errabolu
> Sent: Friday, September 25, 2020 6:03 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Errabolu, Ramesh <Ramesh.Errabolu@amd.com>
> Subject: [PATCH 2/3] drm/amd/amdgpu: Define and implement a function that collects
> number of waves that are in flight.
> 
> [Why]
> Allow user to know how many compute units (CU) are in use at any given
> moment.
> 
> [How]
> Read registers of SQ that give number of waves that are in flight
> of various queues. Use this information to determine number of CU's
> in use.
> 
> Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 176 +++++++++++++++++-
>  .../gpu/drm/amd/include/kgd_kfd_interface.h   |  12 ++
>  2 files changed, 187 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> index e6aede725197..87d4c8855805 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> @@ -38,7 +38,7 @@
>  #include "soc15d.h"
>  #include "mmhub_v1_0.h"
>  #include "gfxhub_v1_0.h"
> -
> +#include "gfx_v9_0.h"
> 
>  enum hqd_dequeue_request_type {
>  	NO_ACTION = 0,
> @@ -706,6 +706,179 @@ void kgd_gfx_v9_set_vm_context_page_table_base(struct
> kgd_dev *kgd,
>  	gfxhub_v1_0_setup_vm_pt_regs(adev, vmid, page_table_base);
>  }
> 
> +static void lock_spi_csq_mutexes(struct amdgpu_device *adev)
> +{
> +	mutex_lock(&adev->srbm_mutex);
> +	mutex_lock(&adev->grbm_idx_mutex);
> +
> +}
> +
> +static void unlock_spi_csq_mutexes(struct amdgpu_device *adev)
> +{
> +	mutex_unlock(&adev->grbm_idx_mutex);
> +	mutex_unlock(&adev->srbm_mutex);
> +}
> +
> +/**
> + * @get_wave_count: Read device registers to get number of waves in flight for
> + * a particulare queue. The method also returns the VMID associated with the

particular

> + * queue.
> + *
> + * @adev: Handle of device whose registers are to be read
> + * @queue_idx: Index of queue in the queue-map bit-field
> + * @wave_cnt: Output parameter updated with number of waves in flight
> + * @vmid: Output parameter updated with VMID of queue whose wave count
> + * is being collected
> + */
> +static void get_wave_count(struct amdgpu_device *adev, int queue_idx,
> +		int *wave_cnt, int *vmid)
> +{
> +	int pipe_idx;
> +	int queue_slot;
> +	unsigned int reg_val;
> +
> +	/*
> +	 * Program GRBM with appropriate MEID, PIPEID, QUEUEID and VMID
> +	 * parameters to read out waves in flight. Get VMID if there are
> +	 * non-zero waves in flight.
> +	 */
> +	*vmid = 0xFF;
> +	*wave_cnt = 0;
> +	pipe_idx = queue_idx / adev->gfx.mec.num_queue_per_pipe;
> +	queue_slot = queue_idx % adev->gfx.mec.num_queue_per_pipe;
> +	soc15_grbm_select(adev, 1, pipe_idx, queue_slot, 0);
> +	reg_val = RREG32(SOC15_REG_OFFSET(GC, 0, mmSPI_CSQ_WF_ACTIVE_COUNT_0) +
> +			 queue_slot);
> +	*wave_cnt = reg_val & SPI_CSQ_WF_ACTIVE_COUNT_0__COUNT_MASK;
> +	if (*wave_cnt != 0)
> +		*vmid = (RREG32_SOC15(GC, 0, mmCP_HQD_VMID) &
> +			 CP_HQD_VMID__VMID_MASK) >> CP_HQD_VMID__VMID__SHIFT;
> +}
> +
> +/**
> + * @kgd_gfx_v9_get_cu_occupancy: Reads relevant registers associated with each
> + * shader engine and aggregates the number of waves that are in fight for the
in flight

> + * process whose pasid is provided as a parameter. The process could have ZERO
> + * or more queues running and submitting waves to compute units.
> + *
> + * @kgd: Handle of device from which to get number of waves in flight
> + * @pasid: Identifies the process for which this query call is invoked
> + * @wave_cnt: Output parameter updated with number of waves in flight that
> + * belong to process with given pasid
> + * @max_waves_per_cu: Output parameter updated with maximum number of waves
> + * possible per Compute Unit
> + *
> + * @note: It's possible that the device has too many queues (oversubscription)
> + * in which case a VMID could be remapped to a different PASID. This could lead
> + * to in accurate wave count. Following is a high-level sequence:
to an inaccurate

> + *    Time T1: vmid = getVmid(); vmid is associated with Pasid P1
> + *    Time T2: passId = getPasId(vmid); vmid is associated with Pasid P2
> + * In the sequence above wave count obtained from time T1 will be incorrectly
> + * lost or added to total wave count.
> + *
> + * The registers that provide the waves in flight are:
> + *
> + *  SPI_CSQ_WF_ACTIVE_STATUS - bit-map of queues per pipe. The bit is ON if a
> + *  queue is slotted, OFF if there is no queue. A process could have ZERO or
> + *  more queues slotted and submitting waves to be run on compute units. Even
> + *  when there is a queue it is possible there could be zero wave fronts, this
> + *  can happen when queue is waiting on top-of-pipe events - e.g. waitRegMem
> + *  command
> + *
> + *  For each bit that is ON from above:
> + *
> + *    Read (SPI_CSQ_WF_ACTIVE_COUNT_0 + queue_idx) register. It provides the
> + *    number of waves that are in flight for the queue at specified index. The
> + *    index ranges from 0 to 7.
> + *
> + *    If non-zero waves are in fligth, read CP_HQD_VMID register to obtain VMID
flight

> + *    of the wave(s).
> + *
> + *    Determine if VMID from above step maps to pasid provided as parameter. If
> + *    it matches agrregate the wave count. That the VMID will not match pasid is
> + *    a normal condition i.e. a device is expected to support multiple queues
> + *    from multiple proceses.
> + *
> + *  Reading registers referenced above involves programming GRBM appropriately
> + */
> +static void kgd_gfx_v9_get_cu_occupancy(struct kgd_dev *kgd, int pasid,
> +		int *pasid_wave_cnt, int *max_waves_per_cu)
> +{
> +	int qidx;
> +	int vmid;
> +	int se_idx;
> +	int sh_idx;
> +	int se_cnt;
> +	int sh_cnt;
> +	int wave_cnt;
> +	int queue_map;
> +	int pasid_tmp;
> +	int max_queue_cnt;
> +	int vmid_wave_cnt = 0;
> +	struct amdgpu_device *adev;
> +	DECLARE_BITMAP(cp_queue_bitmap, KGD_MAX_QUEUES);
> +
> +	adev = get_amdgpu_device(kgd);
> +	lock_spi_csq_mutexes(adev);
> +	soc15_grbm_select(adev, 1, 0, 0, 0);
> +
> +	/*
> +	 * Iterate through the shader engines and arrays of the device
> +	 * to get number of waves in flight
> +	 */
> +	bitmap_complement(cp_queue_bitmap, adev->gfx.mec.queue_bitmap,
> +			  KGD_MAX_QUEUES);
> +	max_queue_cnt = adev->gfx.mec.num_pipe_per_mec *
> +			adev->gfx.mec.num_queue_per_pipe;
> +	sh_cnt = adev->gfx.config.max_sh_per_se;
> +	se_cnt = adev->gfx.config.max_shader_engines;
> +	for (se_idx = 0; se_idx < se_cnt; se_idx++) {
> +		for (sh_idx = 0; sh_idx < sh_cnt; sh_idx++) {
> +
> +			gfx_v9_0_select_se_sh(adev, se_idx, sh_idx, 0xffffffff);
> +			queue_map = RREG32(SOC15_REG_OFFSET(GC, 0,
> +					   mmSPI_CSQ_WF_ACTIVE_STATUS));
> +
> +			/*
> +			 * Assumption: queue map encodes following schema: four
> +			 * pipes per each micro-engine, with each pipe mapping
> +			 * eight queues. This schema is true for GFX9 devices
> +			 * and must be verified for newer device families
> +			 */
> +			for (qidx = 0; qidx < max_queue_cnt; qidx++) {
> +
> +				/* Skip qeueus that are not associated with
> +				 * compute functions
> +				 */
> +				if (!test_bit(qidx, cp_queue_bitmap))
> +					continue;
> +
> +				if (!(queue_map & (1 << qidx)))
> +					continue;
> +
> +				/* Get number of waves in flight and aggregate them */
> +				get_wave_count(adev, qidx, &wave_cnt, &vmid);
> +				if (wave_cnt != 0) {
> +					pasid_tmp =
> +					  RREG32(SOC15_REG_OFFSET(OSSSYS, 0,
> +						 mmIH_VMID_0_LUT) + vmid);
> +					if (pasid_tmp == pasid)
> +						vmid_wave_cnt += wave_cnt;
> +				}
> +			}
> +		}
> +	}
> +
> +	gfx_v9_0_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
> +	soc15_grbm_select(adev, 0, 0, 0, 0);
> +	unlock_spi_csq_mutexes(adev);
> +
> +	/* Update the output parameters and return */
> +	*pasid_wave_cnt = vmid_wave_cnt;
> +	*max_waves_per_cu = adev->gfx.cu_info.simd_per_cu *
> +				adev->gfx.cu_info.max_waves_per_simd;
> +}
> +
>  const struct kfd2kgd_calls gfx_v9_kfd2kgd = {
>  	.program_sh_mem_settings = kgd_gfx_v9_program_sh_mem_settings,
>  	.set_pasid_vmid_mapping = kgd_gfx_v9_set_pasid_vmid_mapping,
> @@ -726,4 +899,5 @@ const struct kfd2kgd_calls gfx_v9_kfd2kgd = {
>  	.get_atc_vmid_pasid_mapping_info =
>  			kgd_gfx_v9_get_atc_vmid_pasid_mapping_info,
>  	.set_vm_context_page_table_base =
> kgd_gfx_v9_set_vm_context_page_table_base,
> +	.get_cu_occupancy = kgd_gfx_v9_get_cu_occupancy,
>  };
> diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> index fc592f60e6a0..e37b4b9f626d 100644
> --- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> @@ -212,6 +212,15 @@ struct tile_config {
>   * IH ring entry. This function allows the KFD ISR to get the VMID
>   * from the fault status register as early as possible.
>   *
> + * @get_cu_occupancy: Function pointer that returns to caller the number
> + * of wave fronts that are in flight for all of the queues of a process
> + * as identified by its pasid. It is important to note that the value
> + * returned by this function is a snapshot of current moment and cannot
> + * guarantee any minimum for the number of waves in-flight. This function
> + * is defined for devices that belong to GFX9 and later GFX families. Care
> + * must be taken in calling this function as it is not defined for devices
> + * that belong to GFX8 and below GFX families.
> + *
>   * This structure contains function pointers to services that the kgd driver
>   * provides to amdkfd driver.
>   *
> @@ -286,6 +295,9 @@ struct kfd2kgd_calls {
>  	void (*set_vm_context_page_table_base)(struct kgd_dev *kgd,
>  			uint32_t vmid, uint64_t page_table_base);
>  	uint32_t (*read_vmid_from_vmfault_reg)(struct kgd_dev *kgd);
> +
> +	void (*get_cu_occupancy)(struct kgd_dev *kgd, int pasid, int *wave_cnt,
> +			int *max_waves_per_cu);
>  };
> 
>  #endif	/* KGD_KFD_INTERFACE_H_INCLUDED */
> --
> 2.27.0
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.or
> g%2Fmailman%2Flistinfo%2Famd-
> gfx&amp;data=02%7C01%7Ckent.russell%40amd.com%7C36b3f4cda50a47ed3b5608d8619e
> d37a%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637366682081748390&amp;
> sdata=ZXD4eVB8TWow6sHB6Mf2OUV%2BSsb4EP%2BB5VMokKEp7W0%3D&amp;reserved=
> 0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
