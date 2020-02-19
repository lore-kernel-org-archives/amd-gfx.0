Return-Path: <SRS0=wRAp=4H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A09C34047
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 10:43:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74CDC24677
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 10:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uWB3Jtu0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74CDC24677
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57E086E5B4;
	Wed, 19 Feb 2020 10:43:11 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4A7B6E5B4
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2020 10:43:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G/8W/QVTI5UuTv1CL8gi4JRUCrZR3LJyJ7VR8eEHm6qKY+kzpDRM/HXw+f3lAcv1iYUNQgxiZXFEVV+8wKPKzStBJFlEKjql/VJrx1elKGgtqR2rTo9NEEYjR9iaU/vn/ovcRBdobEmDq0DuY+1w2Z0CI7WJTnVuAa6aIBZV/EBSxpJEs9P001llcE4Vg0CpReI8HYMfM90ZOGATYfiMhIBlW8p3PUu6ZwJRN0L8H+PMKvuFIJHnKhMw/lxhtafY4LP7LFmSAkmaOwND5KMGIxS04ZOAZ+reZfX30eTkCE5gipYjK3cyqB9VKTcu9Rp7euEB6LxmHg5Ilka6nvQ/iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7TH8eNy+zX5RylNM5PwRljITfDI0rGkdSpiHOgwW9PU=;
 b=gg+RCQjczjHjDF4k/5gZ/9pNEgV+GnJtSYvAJDITTynX/CEAU9qMyYmjUsLD/JgT9vZbuHzIQllWhTwTXxm6hN0a6bLwPP7xNCZo+T8+QQZRrpNAJ65cmtpfYbQ+j/fl6YTqItbGZUHmifSFMdBk48jcMdqaNt2RL1aWfT8cSa8aUXiYh+8JUapKFwfw9vaAavSSO8H3d12EgOECJyNsnnBz5AaIpdBIQD0PJYzS8ETbCpIR4jWnCwFA5RezyP/gQnM2GLMo/nBlAPNpP9Gur0KEoz6QkFnhO7yem+/7VgCPHL0gLhDNapY47c80xeZ3xbLP0FgukuyyyB9lOkXX3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7TH8eNy+zX5RylNM5PwRljITfDI0rGkdSpiHOgwW9PU=;
 b=uWB3Jtu0Qe51bKm/zg66M1xgodS/5f6J/4SU2W7K0Nks/HI3wKWrf/VYsPnDPTGohC++y+WUp2QsnOwLtqJIEkkGaeC0PK2r6+9ptKEAfI8a/rBkLeypumqZFx90deK7VG4FYdUU2dfvHgUXc7mHMPdW+42B5it75hVUDItVQ5o=
Received: from MN2PR12MB3344.namprd12.prod.outlook.com (20.178.241.74) by
 MN2PR12MB3488.namprd12.prod.outlook.com (20.178.242.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.23; Wed, 19 Feb 2020 10:43:08 +0000
Received: from MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173]) by MN2PR12MB3344.namprd12.prod.outlook.com
 ([fe80::69c7:b493:690:2173%3]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 10:43:08 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amdgpu/smu: add an update table lock
Thread-Topic: [PATCH] drm/amdgpu/smu: add an update table lock
Thread-Index: AQHV5dqPc/7ASnyGs0u43w4hTPiJDaggQ4kAgADB7QCAAU5cYA==
Date: Wed, 19 Feb 2020 10:43:08 +0000
Message-ID: <MN2PR12MB334462BFDEE4F58E541DA88BE4100@MN2PR12MB3344.namprd12.prod.outlook.com>
References: <20200217213730.1413533-1-alexander.deucher@amd.com>
 <MN2PR12MB33444C333C7032B4F78BD581E4110@MN2PR12MB3344.namprd12.prod.outlook.com>
 <CADnq5_N4DorOzy4m_SaxYM4wFMp0J-exKpq85gf6ooz-D67drg@mail.gmail.com>
In-Reply-To: <CADnq5_N4DorOzy4m_SaxYM4wFMp0J-exKpq85gf6ooz-D67drg@mail.gmail.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=09acec78-2888-4393-85e2-0000fc59e1fe;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-02-19T10:31:38Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Evan.Quan@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a70cbe26-fbf4-4bdf-3e6a-08d7b5288254
x-ms-traffictypediagnostic: MN2PR12MB3488:|MN2PR12MB3488:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB348857175209253B843E3BFBE4100@MN2PR12MB3488.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0318501FAE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10001)(10009020)(4636009)(366004)(199004)(189003)(966005)(6506007)(53546011)(33656002)(7696005)(81166006)(81156014)(26005)(76116006)(8676002)(6916009)(54906003)(4326008)(8936002)(52536014)(5660300002)(498600001)(71200400001)(86362001)(9686003)(66476007)(66556008)(2906002)(15650500001)(66446008)(186003)(55016002)(64756008)(45080400002)(66946007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3488;
 H:MN2PR12MB3344.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SZ1Kds7dizzeM1lZkq7WlXnuT4zfhRDlsrlM7zFLGLCrdT7KyAO5O/avJS1SmZO+VnZsYYkFpuHZAiI0KiMlhfmbDMVdvkhLRTDi1SbGSZkKPar9S4jspx7+B6MhVmeIwba8U/ODG5MnG5tjumV2uH+nHbs+O9MUArQdL+GPgol5xZpVMvuKN7dGexlV8dIxfUOwfk6Aki1ozsEpbvkNFtFerfVaCII2FbJ2noZB72DBrE5ucly9WsqEPrE8CQe8z9mc/AY4OqnYg1XbXzj2goCzSQAd6UfYOu8/jnvidDGwXfz1dXzHRRZQofVtwxFspYuVbud1j7oLNA0KfgOaPFmR5dQddCP/43j60QCb8tzXm4YRtcxaES1DuevtQVkNWLLivlwnIhm7UuGW965XwcrubfR8bV68/+q0APCitJsuaoEl7Zv6BEvJY+xtOuo0sBg4G4bIQVmiUIvsBnnubDlpMUlFvdGT2Phq1HN+4w8O6gLIBTcZZUohROq63axt5Efaar+TW60NCw1weh/dPt042jvfjZrZa/upmvYTGyrhuuWhLDBqeQVSkOp5uQBbCFTbIpdaH7WsdNA/7q9rPxyhpOPXQntthoqpaJ2f/bQChWVtgJ4dof5BkadSJj1u
x-ms-exchange-antispam-messagedata: s+H4ABr5FM/Wcov2rhwzz+jV8hYPOCwhfSqEDyqKtC8jZoB3Li4X157t1F9s1OJE+Y89uD13dIwRPgAxf2exEbY3NlbmbL4Ezkfqb93BnWKhtaaI0b36XvxNRT+BvNuZ5ah5cxsGihvbtZXZuGGsvQ==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a70cbe26-fbf4-4bdf-3e6a-08d7b5288254
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2020 10:43:08.5043 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fp1CwWxd4URJ4wNbRqFApa59oWBdLZxjJjlV2bWQ3noMwR7zCYuU0DMqnIT6PNcU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3488
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Thanks. I went through that bug report. And it seems weird the table lock works but msg lock does not considering if it was really caused by some race conditions.
Considering the issue was found on multi monitors setup. Maybe mclk dpm is related.
Is it possible to try with single monitor only? Or trying disabling mclk dpm?

-----Original Message-----
From: Alex Deucher <alexdeucher@gmail.com> 
Sent: Tuesday, February 18, 2020 10:35 PM
To: Quan, Evan <Evan.Quan@amd.com>
Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: Re: [PATCH] drm/amdgpu/smu: add an update table lock

On Mon, Feb 17, 2020 at 10:01 PM Quan, Evan <Evan.Quan@amd.com> wrote:
>
> Hi Alex,
>
> Did you seen any issue caused by this?

Seems to help on:
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%2Famd%2Fissues%2F1047&amp;data=02%7C01%7CEvan.Quan%40amd.com%7C1266ea24bc2f4fff2cfb08d7b47fc095%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637176333114972316&amp;sdata=Lpts%2FYe%2Bq64ppyuzNIGWFYiGEXqzQVdAO2CiP6mSfFc%3D&amp;reserved=0
I haven't been able to prove to myself that the existing high level locking covers every case.

Alex

>
> Regards,
> Evan
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of 
> Alex Deucher
> Sent: Tuesday, February 18, 2020 5:38 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amdgpu/smu: add an update table lock
>
> The driver uses a staging buffer to update tables in the SMU.
> Add a lock to make sure we don't try and do this concurrently by 
> accident.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/powerplay/amdgpu_smu.c     | 7 ++++++-
>  drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h | 1 +
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c 
> b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> index 9f2428fd98f6..437a3e7b36b4 100644
> --- a/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> +++ b/drivers/gpu/drm/amd/powerplay/amdgpu_smu.c
> @@ -530,6 +530,7 @@ int smu_update_table(struct smu_context *smu, enum 
> smu_table_id table_index, int
>
>         table_size = smu_table->tables[table_index].size;
>
> +       mutex_lock(&smu->update_table_lock);
>         if (drv2smu) {
>                 memcpy(table->cpu_addr, table_data, table_size);
>                 /*
> @@ -544,13 +545,16 @@ int smu_update_table(struct smu_context *smu, enum smu_table_id table_index, int
>                                           SMU_MSG_TransferTableSmu2Dram,
>                                           table_id | ((argument & 0xFFFF) << 16));
>         if (ret)
> -               return ret;
> +               goto unlock;
>
>         if (!drv2smu) {
>                 amdgpu_asic_flush_hdp(adev, NULL);
>                 memcpy(table_data, table->cpu_addr, table_size);
>         }
>
> +unlock:
> +       mutex_unlock(&smu->update_table_lock);
> +
>         return ret;
>  }
>
> @@ -900,6 +904,7 @@ static int smu_sw_init(void *handle)
>
>         mutex_init(&smu->sensor_lock);
>         mutex_init(&smu->metrics_lock);
> +       mutex_init(&smu->update_table_lock);
>
>         smu->watermarks_bitmap = 0;
>         smu->power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
> diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h 
> b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> index 97b6714e83e6..506288072e8e 100644
> --- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> +++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
> @@ -362,6 +362,7 @@ struct smu_context
>         struct mutex                    mutex;
>         struct mutex                    sensor_lock;
>         struct mutex                    metrics_lock;
> +       struct mutex                    update_table_lock;
>         uint64_t pool_size;
>
>         struct smu_table_context        smu_table;
> --
> 2.24.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flist
> s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7CEv
> an.Quan%40amd.com%7C1266ea24bc2f4fff2cfb08d7b47fc095%7C3dd8961fe4884e6
> 08e11a82d994e183d%7C0%7C0%7C637176333114972316&amp;sdata=JiABwHLa0eLLp
> yiwKXU4nSU28OXBuxTnRbisgoC4uK0%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
