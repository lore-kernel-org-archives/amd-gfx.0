Return-Path: <SRS0=9dkd=HU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,PDS_BAD_THREAD_QP_64,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ACB9C433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Feb 2021 14:52:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A29D64E85
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Feb 2021 14:52:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A29D64E85
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0E456E841;
	Thu, 18 Feb 2021 14:52:25 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D31046E841
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Feb 2021 14:52:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kCCjWEQk+L12p3hfL9T5KprXvDUuWLv5Ge/Gzmlw+GeZWGGrfT0k24n/hNHFJ2uoci4EJP/WB+tD5TjUtRX7r6NyE/znXEClczSNbLddJqoMjEKz1CXzhqTvLatB12RXhtdWABTJtWu0rq5BxKRrWi33V7SeCnxqz1vnXURg7cn5ClCMyFBBb04xXZy7IO4YVI8GR87vKD20iJPSJSMxKO50ITLxqQ5WnKacIkYcbBuxAW8WjGSBLnoRzCnL5VQ3mnmwfeQhv8b19jMwzUzt8XQ+QAeg7A7oleOVVxHx/W4nwMGzqhO0yA1ldS2yYpQ4qHQIUUwLBYkwVje3/gbFtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=soYqLdQYudhq9bO2bEuanWjon4Ihct0P3cOxyIMvt6M=;
 b=PwG8ijydZeosXqICIPTdcQtnxSrNKkkDJQoG4Tz6rZ5WYJ2Vq5yCzT3CWucHhNqIR1qtgX5cOZfoIF0rTaikNG52du/HasdE3uWsuAB387dGE16g7Tn4BLT3xPJO5AzGeylSUzD2V0xuDQfpuJyHiZR+RPiesgpeJ/djN0P8x+JkH7o8vChNPvgEERkoxU2JIesOG/q5bSb7iRpay/zoquH1173Tp1RsPiedHNqRDvfRl1bqqPA4fJPVK0PmDIKsAx23UAlHLVqpOhFmWH2HiQveYDnxRYlr2EZQN5IML1E2s4+4KCEGC11KHa0IXDK2YiYzYO35msyMNhD2TgEmOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=soYqLdQYudhq9bO2bEuanWjon4Ihct0P3cOxyIMvt6M=;
 b=1pKvDzPub8eQ1kiamvPoimMTG3zcnC2G7135ezer/nLgdk8oBFPuHsqpe5+PQk6dOttRfM3bDOpllEXN80xnZCYVO71vzzlza6s+mE+HQmhs5zmhI7y30Jn5a8YYam4DEx+rt+TQ6MiwaiZ6QxeTbwviZbMzCOM0WM0hB5C8CAE=
Received: from DM5PR12MB1787.namprd12.prod.outlook.com (2603:10b6:3:113::12)
 by DM6PR12MB2921.namprd12.prod.outlook.com (2603:10b6:5:182::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27; Thu, 18 Feb
 2021 14:52:23 +0000
Received: from DM5PR12MB1787.namprd12.prod.outlook.com
 ([fe80::d7f:f19c:7565:99b6]) by DM5PR12MB1787.namprd12.prod.outlook.com
 ([fe80::d7f:f19c:7565:99b6%3]) with mapi id 15.20.3846.041; Thu, 18 Feb 2021
 14:52:22 +0000
From: "Liu, Leo" <Leo.Liu@amd.com>
To: "Jiang, Sonny" <Sonny.Jiang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu/vcn3.0: add wptr/rptr reset/update for share
 memory
Thread-Topic: [PATCH] drm/amdgpu/vcn3.0: add wptr/rptr reset/update for share
 memory
Thread-Index: AQHXABW08FOrBln7jEqzo5T4UBa5bKpeBfoAgAAE/mA=
Date: Thu, 18 Feb 2021 14:52:22 +0000
Message-ID: <DM5PR12MB178741FC0E282F3C55ED90F5E5859@DM5PR12MB1787.namprd12.prod.outlook.com>
References: <20210211013109.16781-1-sonny.jiang@amd.com>
 <DM6PR12MB3433F0538D298A0069DE0D97FD859@DM6PR12MB3433.namprd12.prod.outlook.com>
In-Reply-To: <DM6PR12MB3433F0538D298A0069DE0D97FD859@DM6PR12MB3433.namprd12.prod.outlook.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-02-18T14:33:48.497Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [2607:9880:2088:19:7101:5c38:8381:4a8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4260c5c0-e874-48d6-0b73-08d8d41ccc95
x-ms-traffictypediagnostic: DM6PR12MB2921:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB2921211F54FB0655D4865F13E5859@DM6PR12MB2921.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UPx4nOEQjb/fNDD1l4UCjRcOkE7dZAoxaDi81TNn7EY8EW8mDH903TxcitmBie5iea03K9ogsyYX25al6PLBi7Z6DduJULdRDQaOAQHO1JEHXx59QWfsIBbl0YKm90A8acIYmMhg0dKJbcXYE2KXXGhuvgZs2nhGmHxfhFxMDR24tpeJVKnbNpcNqMFDmEI8jlzCLbyf55Zm5vQEIAtMDK+NTSd90NGnjBWGPqC6jyNZQYghF9EmnsYCPG5xHonBLYKECwGAMzZehRqQvE4RgAotjv8rG8zZYVXlCJDonywpYpZRXtcr3cJinLuAAbgKbGMBeoaIKqcLi6SJGnBzQmj7hMznrnFDo/J8qXdNej33l2GbtrN+7RkuA7cTtlIV4Pa5/xa84Lcg+NCEI91M6AejtUfvSeqGGOOujFQXl+07V5/DVCzSyzQ0Oa4y8ZtJxXK3tGLmZcZrWYtqtvUpFNkFLg6AB4zN99IBlDbUKYigviFM1qZG+5rxXgQ4n7uG77Xfdoi7C7JCb8oaqa351A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1787.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(376002)(39860400002)(366004)(346002)(33656002)(53546011)(15650500001)(8936002)(6506007)(71200400001)(86362001)(83380400001)(2906002)(8676002)(52536014)(76116006)(186003)(7696005)(110136005)(66446008)(478600001)(5660300002)(9686003)(316002)(55016002)(66946007)(64756008)(66556008)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?GUCHN/rE5FI1bNfQvMdiz5vNKrgCAtKqwC8NDD/SvwG7BhE1dWbZP3AV5pdV?=
 =?us-ascii?Q?qNeE2ZjvYlFpHjCDyZN+6Uc21xG+HoDyopfZ1aAYZKmlJbocVpUnHGYSLMqw?=
 =?us-ascii?Q?BrwiInAfQnZmrP7slqG7VMwNLfz2DUxln6rD5leQbs0Y6pdVWcAPMbwBG5Qe?=
 =?us-ascii?Q?QcM5mvqSWyWO2fxczSBDrqRBYmRosedsXq3qrbt+PXPEBZYcQB4JhXiHbE89?=
 =?us-ascii?Q?exYZvHZ5Ne3wXNMiXJhIk/44O0ITgKDd0QVlzC7Gx2PY0so0vvrrhJ/UKlWd?=
 =?us-ascii?Q?rKnYdduGnVHfssUIIlbtMQsDH0kw7WIbhIEUfc3z0LHxcZgGxQY2zgZZ7abE?=
 =?us-ascii?Q?1jF3eNMRmJUNI6P5vTVhgpCAkcsYvC5Zhl1CBQQiUZj6uLZOBT8ToYb7hwTB?=
 =?us-ascii?Q?ebAUuMjMZfuDv61P0eo/0n1/Z8GXWs0qgyIHyjvT5Ey/+Sb+cpymSAqHyu/G?=
 =?us-ascii?Q?oKITNov2mYAfh309X+0e+KMQWNO+RbIpTp1bMO0ld501ERvQynK75bF9Xl38?=
 =?us-ascii?Q?6B8DmvSHZ4cdUmoskbDOB/0T4TWvoBzSJApIbd+Yc0Z00ZIQ4dB9mob/28Yb?=
 =?us-ascii?Q?2XBMCqSU4MvhO3U8ROABweSUcsIeDqG+3xU+TWq/kpPjWWg+0vPG1pu7383x?=
 =?us-ascii?Q?Badzrani6Q7Ta2LT37zw0mjAzcSwS27WgTiR6pyM4eXVVetW4NFeeKQvW7Lb?=
 =?us-ascii?Q?RlSkPmHfhppU1j4fFCvX7qA++71hQuHOosQQM6SIVTl1ct0TvYiArIyjpDTx?=
 =?us-ascii?Q?2ckXBcmdi0elr9icmF1bg68r/nOt5hPLQxDnbmOgP9ycM06i1d4ccwIa/d3s?=
 =?us-ascii?Q?AQdXnl9ow/PyScWdbYdB9OLWY6eMg6qujdqH4xZRxIEVv26TYLJbC2pDAQY3?=
 =?us-ascii?Q?kjba2vn5sBM9QRKVgMVFrCKkntm6cYGl50zgJ2/SAW586Bi38cIlYz7lDlpJ?=
 =?us-ascii?Q?XjBef7OhQ6YJAiA5egQ7/J590XIZnJIWAp22AGrAraqB8AtHjgdCySCWy9yz?=
 =?us-ascii?Q?Ze9HGeNkEvHY2uAdl+oN1H5rX8kw0GwH+deWCA+oMDBlz4fNP6lE5Z2/LRbB?=
 =?us-ascii?Q?cVUSJyTEsXZTbSGAM765fmIjea+Bvymg9k8VC4dYwNhyJjE7tbIjfmj2eRQ/?=
 =?us-ascii?Q?LGm5KQp+0hTMiXuXPfodTE+DyX5TWlCmvnbv2DkxlH9ddiG7F/GhsINC+Gpb?=
 =?us-ascii?Q?zI7KsQCmsV07JRgNcXDBjPIzbG59WuDeQMblGKjrtwZJysrjjvRg+dQyBsGZ?=
 =?us-ascii?Q?RXZLw5vgWI+d1SM48vK3aQkTeFFp+Iud1/aSvwJ+pv6QJzzLzbDDOQdloWyt?=
 =?us-ascii?Q?6c6T7JefxF8lpfOanwFVrdcY8g2uLKKjFa+FD1LB4tXiXhp2nLLV0SZZDTON?=
 =?us-ascii?Q?pHYC+z4=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1787.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4260c5c0-e874-48d6-0b73-08d8d41ccc95
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2021 14:52:22.7848 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TlaMCR4yp8SUdjVZdHk8dLtm1dq4huY5B/p8n2O2nCqKHUMnWOHfLHq1MnIL1xB3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2921
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
Content-Type: multipart/mixed; boundary="===============1786958064=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1786958064==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB178741FC0E282F3C55ED90F5E5859DM5PR12MB1787namp_"

--_000_DM5PR12MB178741FC0E282F3C55ED90F5E5859DM5PR12MB1787namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Leo Liu <leo.liu@amd.com>

From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Jiang, S=
onny
Sent: February 18, 2021 9:34 AM
To: amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/amdgpu/vcn3.0: add wptr/rptr reset/update for shar=
e memory


[AMD Official Use Only - Internal Distribution Only]


[AMD Official Use Only - Internal Distribution Only]

Ping.
________________________________
From: Jiang, Sonny <Sonny.Jiang@amd.com<mailto:Sonny.Jiang@amd.com>>
Sent: Wednesday, February 10, 2021 8:31 PM
To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Jiang, Sonny <Sonny.Jiang@amd.com<mailto:Sonny.Jiang@amd.com>>
Subject: [PATCH] drm/amdgpu/vcn3.0: add wptr/rptr reset/update for share me=
mory

Because of dpg, the rptr/wptr need to be saved on fw shared memory,
and restore them back in RBC_RB_RPTR/WPTR in kernel at power up.

Signed-off-by: Sonny Jiang <sonny.jiang@amd.com<mailto:sonny.jiang@amd.com>=
>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h | 12 +++++++++++-
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 24 +++++++++++++++++++++++-
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vcn.h
index 13aa417f6be7..a19c0c35e2d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -155,6 +155,7 @@
                 }                                                         =
                      \
         } while (0)

+#define AMDGPU_VCN_FW_SHARED_FLAG_0_RB (1 << 6)
 #define AMDGPU_VCN_MULTI_QUEUE_FLAG     (1 << 8)
 #define AMDGPU_VCN_SW_RING_FLAG         (1 << 9)

@@ -243,6 +244,12 @@ struct amdgpu_vcn {
                 int inst_idx, struct dpg_pause_state *new_state);
 };

+struct amdgpu_fw_shared_rb_ptrs_struct {
+       /* to WA DPG R/W ptr issues.*/
+       uint32_t  rptr;
+       uint32_t  wptr;
+};
+
 struct amdgpu_fw_shared_multi_queue {
         uint8_t decode_queue_mode;
         uint8_t encode_generalpurpose_queue_mode;
@@ -258,9 +265,12 @@ struct amdgpu_fw_shared_sw_ring {

 struct amdgpu_fw_shared {
         uint32_t present_flag_0;
-       uint8_t pad[53];
+       uint8_t pad[44];
+       struct amdgpu_fw_shared_rb_ptrs_struct rb;
+       uint8_t power;
         struct amdgpu_fw_shared_multi_queue multi_queue;
         struct amdgpu_fw_shared_sw_ring sw_ring;
+       uint8_t padding[13];
 } __attribute__((__packed__));

 struct amdgpu_vcn_decode_buffer {
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/am=
dgpu/vcn_v3_0.c
index def583916294..b61d1ba1aa9d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -238,7 +238,8 @@ static int vcn_v3_0_sw_init(void *handle)

                 fw_shared =3D adev->vcn.inst[i].fw_shared_cpu_addr;
                 fw_shared->present_flag_0 |=3D cpu_to_le32(AMDGPU_VCN_SW_R=
ING_FLAG) |
-                                            cpu_to_le32(AMDGPU_VCN_MULTI_Q=
UEUE_FLAG);
+                                            cpu_to_le32(AMDGPU_VCN_MULTI_Q=
UEUE_FLAG) |
+                                            cpu_to_le32(AMDGPU_VCN_FW_SHAR=
ED_FLAG_0_RB);
                 fw_shared->sw_ring.is_enabled =3D cpu_to_le32(DEC_SW_RING_=
ENABLED);
         }

@@ -1074,7 +1075,13 @@ static int vcn_v3_0_start_dpg_mode(struct amdgpu_dev=
ice *adev, int inst_idx, boo
         WREG32_SOC15(VCN, inst_idx, mmUVD_RBC_RB_WPTR,
                 lower_32_bits(ring->wptr));

+       /* Reset FW shared memory RBC WPTR/RPTR */
+       fw_shared->rb.rptr =3D 0;
+       fw_shared->rb.wptr =3D lower_32_bits(ring->wptr);
+
+       /*resetting done, fw can check RB ring */
         fw_shared->multi_queue.decode_queue_mode &=3D cpu_to_le32(~FW_QUEU=
E_RING_RESET);
+
         /* Unstall DPG */
         WREG32_P(SOC15_REG_OFFSET(VCN, inst_idx, mmUVD_POWER_STATUS),
                 0, ~UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK);
@@ -1239,9 +1246,11 @@ static int vcn_v3_0_start(struct amdgpu_device *adev=
)
                 /* Initialize the ring buffer's read and write pointers */
                 WREG32_SOC15(VCN, i, mmUVD_RBC_RB_RPTR, 0);

+               WREG32_SOC15(VCN, i, mmUVD_SCRATCH2, 0);
                 ring->wptr =3D RREG32_SOC15(VCN, i, mmUVD_RBC_RB_RPTR);
                 WREG32_SOC15(VCN, i, mmUVD_RBC_RB_WPTR,
                         lower_32_bits(ring->wptr));
+               fw_shared->rb.wptr =3D lower_32_bits(ring->wptr);
                 fw_shared->multi_queue.decode_queue_mode &=3D cpu_to_le32(=
~FW_QUEUE_RING_RESET);

                 fw_shared->multi_queue.encode_generalpurpose_queue_mode |=
=3D cpu_to_le32(FW_QUEUE_RING_RESET);
@@ -1662,6 +1671,10 @@ static int vcn_v3_0_pause_dpg_mode(struct amdgpu_dev=
ice *adev,
                                 WREG32_SOC15(VCN, inst_idx, mmUVD_RB_WPTR2=
, lower_32_bits(ring->wptr));
                                 fw_shared->multi_queue.encode_lowlatency_q=
ueue_mode &=3D cpu_to_le32(~FW_QUEUE_RING_RESET);

+                               /* restore wptr/rptr with pointers saved in=
 FW shared memory*/
+                               WREG32_SOC15(VCN, inst_idx, mmUVD_RBC_RB_RP=
TR, fw_shared->rb.rptr);
+                               WREG32_SOC15(VCN, inst_idx, mmUVD_RBC_RB_WP=
TR, fw_shared->rb.wptr);
+
                                 /* Unstall DPG */
                                 WREG32_P(SOC15_REG_OFFSET(VCN, inst_idx, m=
mUVD_POWER_STATUS),
                                         0, ~UVD_POWER_STATUS__STALL_DPG_PO=
WER_UP_MASK);
@@ -1721,6 +1734,15 @@ static uint64_t vcn_v3_0_dec_ring_get_wptr(struct am=
dgpu_ring *ring)
 static void vcn_v3_0_dec_ring_set_wptr(struct amdgpu_ring *ring)
 {
         struct amdgpu_device *adev =3D ring->adev;
+       volatile struct amdgpu_fw_shared *fw_shared;
+
+       if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
+               /*whenever update RBC_RB_WPTR, we save the wptr in shared r=
b.wptr and scratch2 */
+               fw_shared =3D adev->vcn.inst[ring->me].fw_shared_cpu_addr;
+               fw_shared->rb.wptr =3D lower_32_bits(ring->wptr);
+               WREG32_SOC15(VCN, ring->me, mmUVD_SCRATCH2,
+                       lower_32_bits(ring->wptr));
+       }

         if (ring->use_doorbell) {
                 adev->wb.wb[ring->wptr_offs] =3D lower_32_bits(ring->wptr)=
;
--
2.25.1

--_000_DM5PR12MB178741FC0E282F3C55ED90F5E5859DM5PR12MB1787namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-CA" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Reviewed-=
by: Leo Liu &lt;leo.liu@amd.com&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal"><b><span lang=3D"EN-US">From:</span></b><span lang=
=3D"EN-US"> amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt;
<b>On Behalf Of </b>Jiang, Sonny<br>
<b>Sent:</b> February 18, 2021 9:34 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu/vcn3.0: add wptr/rptr reset/update f=
or share memory<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:5.0pt"><span style=3D"font-family:&quot;Arial&quot;,sans=
-serif;color:#0078D7">[AMD Official Use Only - Internal Distribution Only]<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p style=3D"margin:5.0pt"><span style=3D"font-family:&quot;Arial&quot;,sans=
-serif;color:#0078D7">[AMD Official Use Only - Internal Distribution Only]<=
o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Ping. <=
o:p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Jiang, Sonny &lt;<a href=3D"mailto:Sonny.Jiang@amd.=
com">Sonny.Jiang@amd.com</a>&gt;<br>
<b>Sent:</b> Wednesday, February 10, 2021 8:31 PM<br>
<b>To:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;<br>
<b>Cc:</b> Jiang, Sonny &lt;<a href=3D"mailto:Sonny.Jiang@amd.com">Sonny.Ji=
ang@amd.com</a>&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu/vcn3.0: add wptr/rptr reset/update for s=
hare memory</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">Because of dpg, the r=
ptr/wptr need to be saved on fw shared memory,<br>
and restore them back in RBC_RB_RPTR/WPTR in kernel at power up.<br>
<br>
Signed-off-by: Sonny Jiang &lt;<a href=3D"mailto:sonny.jiang@amd.com">sonny=
.jiang@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h | 12 +++++++++++-<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c&nbsp;&nbsp; | 24 ++++++++++++++=
+++++++++-<br>
&nbsp;2 files changed, 34 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_vcn.h<br>
index 13aa417f6be7..a19c0c35e2d8 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h<br>
@@ -155,6 +155,7 @@<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; }&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } while (0)<br>
&nbsp;<br>
+#define AMDGPU_VCN_FW_SHARED_FLAG_0_RB (1 &lt;&lt; 6)<br>
&nbsp;#define AMDGPU_VCN_MULTI_QUEUE_FLAG&nbsp;&nbsp;&nbsp;&nbsp; (1 &lt;&l=
t; 8)<br>
&nbsp;#define AMDGPU_VCN_SW_RING_FLAG&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; (1 &lt;&lt; 9)<br>
&nbsp;<br>
@@ -243,6 +244,12 @@ struct amdgpu_vcn {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; int inst_idx, struct dpg_pause_state *new_state);<br>
&nbsp;};<br>
&nbsp;<br>
+struct amdgpu_fw_shared_rb_ptrs_struct {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* to WA DPG R/W ptr issues.*/<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp; rptr;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp; wptr;<br>
+};<br>
+<br>
&nbsp;struct amdgpu_fw_shared_multi_queue {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t decode_queue_mode;=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t encode_generalpurp=
ose_queue_mode;<br>
@@ -258,9 +265,12 @@ struct amdgpu_fw_shared_sw_ring {<br>
&nbsp;<br>
&nbsp;struct amdgpu_fw_shared {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t present_flag_0;<b=
r>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t pad[53];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t pad[44];<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_fw_shared_rb_ptrs_struc=
t rb;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t power;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_fw_shared_mu=
lti_queue multi_queue;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_fw_shared_sw=
_ring sw_ring;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint8_t padding[13];<br>
&nbsp;} __attribute__((__packed__));<br>
&nbsp;<br>
&nbsp;struct amdgpu_vcn_decode_buffer {<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/am=
dgpu/vcn_v3_0.c<br>
index def583916294..b61d1ba1aa9d 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c<br>
@@ -238,7 +238,8 @@ static int vcn_v3_0_sw_init(void *handle)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; fw_shared =3D adev-&gt;vcn.inst[i].fw_shared_cpu_addr=
;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; fw_shared-&gt;present_flag_0 |=3D cpu_to_le32(AMDGPU_=
VCN_SW_RING_FLAG) |<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cpu_to_le32(AMDGPU_VCN_MULTI_QUEUE_FLAG)=
;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cpu_to_le32(AMDGPU_VCN_MULTI_QUEUE_FLAG)=
 |<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cpu_to_le32(AMDGPU_VCN_FW_SHARED_FLAG_0_=
RB);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; fw_shared-&gt;sw_ring.is_enabled =3D cpu_to_le32(DEC_=
SW_RING_ENABLED);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
@@ -1074,7 +1075,13 @@ static int vcn_v3_0_start_dpg_mode(struct amdgpu_dev=
ice *adev, int inst_idx, boo<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(VCN, inst_idx=
, mmUVD_RBC_RB_WPTR,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; lower_32_bits(ring-&gt;wptr));<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Reset FW shared memory RBC WPTR/RP=
TR */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fw_shared-&gt;rb.rptr =3D 0;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fw_shared-&gt;rb.wptr =3D lower_32_bi=
ts(ring-&gt;wptr);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*resetting done, fw can check RB rin=
g */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fw_shared-&gt;multi_queue.=
decode_queue_mode &amp;=3D cpu_to_le32(~FW_QUEUE_RING_RESET);<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Unstall DPG */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_P(SOC15_REG_OFFSET(=
VCN, inst_idx, mmUVD_POWER_STATUS),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; 0, ~UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK);<br>
@@ -1239,9 +1246,11 @@ static int vcn_v3_0_start(struct amdgpu_device *adev=
)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; /* Initialize the ring buffer's read and write pointe=
rs */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(VCN, i, mmUVD_RBC_RB_RPTR, 0);<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32_SOC15(VCN, i, mmUVD_SCRATCH2, 0);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ring-&gt;wptr =3D RREG32_SOC15(VCN, i, mmUVD_RBC_RB_R=
PTR);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(VCN, i, mmUVD_RBC_RB_WPTR,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lower=
_32_bits(ring-&gt;wptr));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; fw_shared-&gt;rb.wptr =3D lower_32_bits(ring-&gt;wptr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; fw_shared-&gt;multi_queue.decode_queue_mode &amp;=3D =
cpu_to_le32(~FW_QUEUE_RING_RESET);<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; fw_shared-&gt;multi_queue.encode_generalpurpose_queue=
_mode |=3D cpu_to_le32(FW_QUEUE_RING_RESET);<br>
@@ -1662,6 +1671,10 @@ static int vcn_v3_0_pause_dpg_mode(struct amdgpu_dev=
ice *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(VCN, inst_idx, mmUV=
D_RB_WPTR2, lower_32_bits(ring-&gt;wptr));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; fw_shared-&gt;multi_queue.encode=
_lowlatency_queue_mode &amp;=3D cpu_to_le32(~FW_QUEUE_RING_RESET);<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* restore wptr/rptr with pointers saved in=
 FW shared memory*/<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(VCN, inst_idx, mmUVD_RBC_RB_RP=
TR, fw_shared-&gt;rb.rptr);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(VCN, inst_idx, mmUVD_RBC_RB_WP=
TR, fw_shared-&gt;rb.wptr);<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Unstall DPG */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_P(SOC15_REG_OFFSET(VCN, i=
nst_idx, mmUVD_POWER_STATUS),<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; 0, ~UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK);<br>
@@ -1721,6 +1734,15 @@ static uint64_t vcn_v3_0_dec_ring_get_wptr(struct am=
dgpu_ring *ring)<br>
&nbsp;static void vcn_v3_0_dec_ring_set_wptr(struct amdgpu_ring *ring)<br>
&nbsp;{<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev=
 =3D ring-&gt;adev;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; volatile struct amdgpu_fw_shared *fw_=
shared;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;pg_flags &amp; AMD_PG_SU=
PPORT_VCN_DPG) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /*whenever update RBC_RB_WPTR, we save the wptr in shared rb.wpt=
r and scratch2 */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; fw_shared =3D adev-&gt;vcn.inst[ring-&gt;me].fw_shared_cpu_addr;=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; fw_shared-&gt;rb.wptr =3D lower_32_bits(ring-&gt;wptr);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; WREG32_SOC15(VCN, ring-&gt;me, mmUVD_SCRATCH2,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lower_32_bits(ri=
ng-&gt;wptr));<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ring-&gt;use_doorbell)=
 {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;wb.wb[ring-&gt;wptr_offs] =3D lower_32_bits(=
ring-&gt;wptr);<br>
-- <br>
2.25.1<o:p></o:p></p>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM5PR12MB178741FC0E282F3C55ED90F5E5859DM5PR12MB1787namp_--

--===============1786958064==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1786958064==--
