Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4C86085554
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2026 14:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=yuwQd7hw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6F3B10E643;
	Mon,  2 Nov 2026 14:47:08 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012012.outbound.protection.outlook.com [40.107.209.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74DFF10EF66
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Nov 2026 14:47:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D+yVybf88ASkOtiSN6swO1ckAIMlIOkxkX7qhLfcwL+GwXoVYWLxViKPtpGP0l0wWvZ0TJ0J+UpcQjs27ymYkB8DSB3cu0+RkXHL9ck2QzbyUv/RlCgNyAqojsXjOlM503Pj32sNn6u8+3Fz7s/BzTrOJFaisu0sAmCVcUQjpHd305MCMnOucTZVBo7nkfQEAVtWzVB+uxhFywRH4QAphYwF/+oipozCA9dbVyQJHaiHm7kqAY4ALUEAnHIpybJSq4y2cMRqzwpQA/+3+GKipP3ao0DuvLv3ywEjd5L1ySITHfNz1tT3VgPvxSoQ1nTGJNH1yZvMwwMXwiD79z0oxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=um898+SD0wtyHob7/5IaIco/gO+ORZHr9KlATXJy3h8=;
 b=V07P3RGKoZoTbi/IfC9MOFU65etP4rz8Rpml3V5zVynAJE+0C6+89atkW7BHAi4C4rxhFqQ+YvCgRgJdJRtd5YHkSRDgCNDJReVGSa7hnR90yplR8ZiYsIFQa30b26+V7gCq1gGxQB2K5UhdSM93xtKjzZVqXe5H9WJodYG7clAmQGOlw9bKdEaIjMNOoBgViPEhAz6y3iup0aBbFqOXHCanbTa8FS4JJBK5DyOci+dQh3+/LjzRRheEId8jakQjmGTM5p6II8tzwrEqqNvCwGG0n5jQ95WYU05WG6GqWStvQx0UVPiLJVl0CQS8ZxhQ1ExZAxPchsOuCWe/yUAYMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=um898+SD0wtyHob7/5IaIco/gO+ORZHr9KlATXJy3h8=;
 b=yuwQd7hwD5OHM3seLZkqxn9uTnSghfaLL0VytJXziDBaeABBK/VAWT05FxUnhZ+EZiNGgx2JpDn1EIslDPTTke3f5bzSqCGEmWMbpKqxehlb6GsalnpMtDr3iB/fLkufRcKUR+9yZGnxSHzq1yShUSX4WpgTavTB18yMtBc1ABM=
Received: from CY3PR12MB9631.namprd12.prod.outlook.com (2603:10b6:930:ff::6)
 by MW6PR12MB8898.namprd12.prod.outlook.com (2603:10b6:303:246::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.21; Mon, 2 Nov
 2026 14:46:58 +0000
Received: from CY3PR12MB9631.namprd12.prod.outlook.com
 ([fe80::3595:9a8c:8f99:4e55]) by CY3PR12MB9631.namprd12.prod.outlook.com
 ([fe80::3595:9a8c:8f99:4e55%4]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 14:46:58 +0000
From: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>
To: "Sun, Yongqiang" <Yongqiang.Sun@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/4] drm/amdgpu: wire mes_dbgext on mes12.1
Thread-Topic: [PATCH 1/4] drm/amdgpu: wire mes_dbgext on mes12.1
Thread-Index: AQHdZv5yuxx7iq8TdUGQfHsZhjvDo7cW89BQ
Date: Mon, 2 Nov 2026 14:46:58 +0000
Message-ID: <CY3PR12MB963112FBC2A118AC4AAD1445F46A2@CY3PR12MB9631.namprd12.prod.outlook.com>
References: <20261028170433.462855-1-Yongqiang.Sun@amd.com>
In-Reply-To: <20261028170433.462855-1-Yongqiang.Sun@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-10-31T02:38:24.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY3PR12MB9631:EE_|MW6PR12MB8898:EE_
x-ms-office365-filtering-correlation-id: 7b4caacc-e763-4d35-896c-08df38f025be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|261028144727099003|38070700021|260925021311599003|261026140227099003|260925022911599003|260925021911599003|56012099006|10067099003|261021121427099003|261022075727099003|261022105027099003|11063799006|261021123027099003|261009223027099003|22082099003|261102123227099002|18002099003|261026121527099003|3023799007;
x-microsoft-antispam-message-info: XlwN/8UuNm9ADq8oGuBxooCvjvPwQ0oycCh3ldqtbFe0hMIBL64J1sUvCF8raulrf+VlxD9uqGPgCKajxjGSK2k76AuGgA4E1fiClWnAzxQaqLt5LTTfm2kdyHtn2jlxmipDhPqwZ8YU2hTVRq/D0XThtZ/iOT3wDNJcClzVOnORR+SqhEJTjmhreE9oqw0d8ePRhha/jIYRByDxvi0r0tqGiBi4NTXZvGOzx4QrVk3DHjZ9v5ml1eOW+wXomUsWtcDCnXmemQqd1B93SdZ/i2g/GoNzhDOw2dapHODTy1YQKgxl2DGPQXo5R9zBXkRI4R7BSCiRrq6IKyeAkeqQwAd0lExo8o0NCbatl4hyc6OqkIgt7228+ozsGTGfnkhuJ0f2tYhcgjSDGnNjsMre0dZcpvqYo+jVCEpAMjB1JzT6jXbVsEKF/4RusgtR8rTy+q+tdEditiM/eRIpO01fg5WeUik/zzeaFcAKkX2ZPZ3XF+qKDzz3qFHvbsyNnHkshpJ+BAPmw0eIegnXYSq/7GPnHeS7DEhzxbsr2Z6isb9Bc7o618msWFLzE4u/7vmOh/k831nlmfU3gthbwBPWtUWgh0SiIMjRdcMh/ebLpB8Ufsn026UQrX6wZzgvDBVvpuXUXmP9Bg9d4OjEGLswh2eGVpWVgOjhUuGzYjdxCDbK3Tql4D3vMw+Nfqif9qKEAE1ePzIwa54nrrk3avAD25Bw8bCctWrFNHqYTMqkBak=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY3PR12MB9631.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(261028144727099003)(38070700021)(260925021311599003)(261026140227099003)(260925022911599003)(260925021911599003)(56012099006)(10067099003)(261021121427099003)(261022075727099003)(261022105027099003)(11063799006)(261021123027099003)(261009223027099003)(22082099003)(261102123227099002)(18002099003)(261026121527099003)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aSEoKHZEuWVG4/Q7CbzrNmAldtqrlILWqcfTgoz6soaCIReu2SrlfRbtmNAe?=
 =?us-ascii?Q?ZZ79cf6KYkswrg6t/pMbvd9meVyIQAwStD7qeFq/homIQo/MGrPwfe1qDGQT?=
 =?us-ascii?Q?D9RljOdggatKj1ZLT6N948Gct10Uf5ovg3fmqjWjGOKJdCo1/yUJT/RjzVUL?=
 =?us-ascii?Q?8W2i6wqcKxiXf9JEnaMMpByjEuDVQMwWa/oAiEJRf7NcpPHImNVMqWjwvLp1?=
 =?us-ascii?Q?Wz7HBu9J/1Okjc+h7/A8Y/61eLicvMLjl6ethsJaoVId36vu22pIXkdpLDmR?=
 =?us-ascii?Q?R9ifPzUe/yMhUJRkYGfMSQCfls3PZw9RXHSU7kMestYOhBrzT2fNcFKT68bP?=
 =?us-ascii?Q?1RFDdumNAkLAuYeb5U8fLfF76J5ljr9+xkV4//D/PwezxJcWXP6dYmMy9Ef2?=
 =?us-ascii?Q?TJTkUgy+nj4rOdtseSnU2s0CF47iV2kUx91e6xsvEuJKy3jEYJzdMcj3hrPx?=
 =?us-ascii?Q?ycQaz4/VHEcrAdS3cSVYblxajgysayzO2N/aSYb11cCMt/855d/1a64HlBDG?=
 =?us-ascii?Q?p0Fh1GwQ+rdqGG6Rz6vWQGb2XJoiQklVSaOUXFTlW9b35LxHiGl0PMgJr1Hj?=
 =?us-ascii?Q?9U+fYp/Pvl+RoI81QI1TPNS7unsdywsREiXrgd13PIcB93tPQiJvxbJY0Kb2?=
 =?us-ascii?Q?ECRKx2Gni29BA7EWSKqZ4fHW5r4VQdaUk54TbubXls7Dvuvn7SnRkHNac4gS?=
 =?us-ascii?Q?Vtnyf2y/Iv/DCevyhofj7sIjkGyo1Z1j1VKEuebv8l1YRRoWVWa1aOt55LhK?=
 =?us-ascii?Q?E9s7SQ9gR7XmpUZ0q6d4/2dUizsKYDBGSqdivtvHMzgSfdnNSVHg4agnfW25?=
 =?us-ascii?Q?5i1KobnW7vlAOB+K7Ye6z+lE/3S3N2JEYINw/1wKgY6GXGUEsp/3fkRgEeZy?=
 =?us-ascii?Q?khxsm8nfwLidoNTxOjonfqsZx+JWTQoy7cmtlSll/LKss9GtheLEiHIC6QOI?=
 =?us-ascii?Q?V5Ov+jRkpPbZkwEUYSBtmK9M+Gs9IJ4IJlHPX7oJ+aiAhMGHfJyVLxnd0kzF?=
 =?us-ascii?Q?9QPJfONhrNMbznlcHRH/XdsgpsjtrTDxgz7E8reOFDGGjZw/DeWTUKDvAHLb?=
 =?us-ascii?Q?rlD4mmOG3MKOs25L2sTIog1Lg2nsep5NPaqs1tpDySXRV7+vYk2CpL6Q/S18?=
 =?us-ascii?Q?UlWRMmedrfPlc7xCEnv49OqanE00Bk1+DSMninjk5tN4bepOfsJ+m/eHxAIq?=
 =?us-ascii?Q?4Gnvcomz17UJPX1khqvib+fE4CCh8nNI1SNn8zUDNRNGNIIFj75RC3ahzoX3?=
 =?us-ascii?Q?fB+Uz6sPN2N6OXHP1/Ps2tmwcaBXy5heipcWVD6C9nKrRjmOUUVtlXrjRiBH?=
 =?us-ascii?Q?2lBiwTuksHWYFt4k3Vlh9j2XYMIqgPqja7EHcJD3sRjNSWvKXYLhhDimD/nt?=
 =?us-ascii?Q?M2kcscZGmbnURwBWqEAzMH3RUWayFV+SQA1T2enAUqsdm8FmWyRMoaXlP+V5?=
 =?us-ascii?Q?UHVMWYidRJVOdXcOqv4yJgGbkrQnEkSMLHGZ5HeQfDRpwzahJ7ge2qRax9C4?=
 =?us-ascii?Q?FZdzX+h9nPoQEUWab5b9dbDUWMWh0qfcNTlEIr95U5BeWzBrAdFgzrymqW3I?=
 =?us-ascii?Q?DvCGUabRf8uItBdlDKsxP8EW3jEP/NHe4VjFheOVtP/DM4kCHegtRRnIa7bU?=
 =?us-ascii?Q?o/Z4IFO6T1NVFenGRgRTEzK1uC/MTDVO01Auv0Zh8wIN/1GYYN93Ct/JS0aw?=
 =?us-ascii?Q?MRHfr9kfiJ4TUtQ1zlSi4puU3MnyGZqrFZHp36iHShUT0RpZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY3PR12MB9631.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b4caacc-e763-4d35-896c-08df38f025be
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2026 14:46:58.5873 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k4ks1gVrH2GieTno4aMaoW+HTRn/6PsSUxSgD1wie7+soR9SRe2ZzOWtFccNcNpDO49mCJTmF1KoL9LESggkNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8898
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

AMD General

This serail looks ok to me . You can add me as RB .

Regards
Shaoyun.liu

-----Original Message-----
From: Sun, Yongqiang <Yongqiang.Sun@amd.com>
Sent: Wednesday, October 28, 2026 1:05 PM
To: amd-gfx@lists.freedesktop.org
Cc: Liu, Shaoyun <Shaoyun.Liu@amd.com>; Sun, Yongqiang <Yongqiang.Sun@amd.c=
om>
Subject: [PATCH 1/4] drm/amdgpu: wire mes_dbgext on mes12.1

Add the per-IP hardware wiring that drives the mes_dbgext core on
mes12.1 (mes_v12_1 / gfx_v12_1): handle MES_MISC_OP_SETUP_MES_DBGEXT in the=
 misc-op path, unmask the MES host (TIME_STAMP) interrupt across both
me3 pipes via the XCC-aware GRBM select, select the zoned buffer format in =
sw_init(), start/stop the feature from hw_init()/hw_fini(), and drain the l=
og from the me3 EOP interrupt handler while the feature is active.

Signed-off-by: Yongqiang Sun <Yongqiang.Sun@amd.com>
Reviewed-by: Shaoyun Liu <Shaoyun.Liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 19 +++++++  drivers/gpu/drm/amd/a=
mdgpu/mes_v12_1.c | 68 ++++++++++++++++++++++++++
 2 files changed, 87 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/a=
mdgpu/gfx_v12_1.c
index 1589fc6413af5..4449691744a96 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -3515,6 +3515,25 @@ static int gfx_v12_1_eop_irq(struct amdgpu_device *a=
dev,

        DRM_DEBUG("IH: CP EOP\n");

+       if (((entry->ring_id & 0x0c) >> 2) =3D=3D 3) {
+               u32 type =3D amdgpu_mes_ih_int_type(doorbell_offset);
+
+               switch (type) {
+               case AMDGPU_MES_IH_INT_TYPE_DBGMSG:
+                       /*
+                        * MES firmware debug-extension ("mes_dbgext") mess=
ages are
+                        * delivered as an EOP interrupt from the MES sched=
uler pipe
+                        * (me 3).  Type is in context dword bits 31:26 (ME=
S_DBGMSG =3D 7).
+                        */
+                       if (adev->mes.dbgext_active)
+                               amdgpu_mes_dbgext_notify(adev, doorbell_off=
set);
+                       break;
+               default:
+                       break;
+               }
+               return 0;
+       }
+
        if (adev->enable_mes && doorbell_offset) {
                amdgpu_userq_process_fence_irq(adev, doorbell_offset);
        } else {
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/a=
mdgpu/mes_v12_1.c
index 5573fe981a220..5e4f929ba6b5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
@@ -42,6 +42,7 @@ static int mes_v12_1_hw_fini(struct amdgpu_ip_block *ip_b=
lock);  static int mes_v12_1_kiq_hw_init(struct amdgpu_device *adev, uint32=
_t xcc_id);  static int mes_v12_1_kiq_hw_fini(struct amdgpu_device *adev, u=
int32_t xcc_id);  static int mes_v12_1_setup_coop_mode(struct amdgpu_device=
 *adev, int xcc_id);
+static int mes_v12_1_enable_dbgext_irq(struct amdgpu_mes *mes, bool
+enable);

 #define MES_EOP_SIZE   2048
 #define MES12_HUNG_DB_OFFSET_ARRAY_SIZE 8 /* [0:3] =3D db offset [4:7] hqd=
 info */ @@ -639,6 +640,13 @@ static int mes_v12_1_misc_op(struct amdgpu_me=
s *mes,
                misc_pkt.change_config.option.bits.limit_single_process =3D
                        input->change_config.option.limit_single_process;
                break;
+       case MES_MISC_OP_SETUP_MES_DBGEXT:
+               misc_pkt.opcode =3D MESAPI_MISC__SETUP_MES_DBGEXT;
+               misc_pkt.dbgext_init_data.dbg_ext_mc_addr =3D
+                               input->setup_mes_dbgext.log_buffer_mc_addr;
+               misc_pkt.dbgext_init_data.u64_all =3D
+                               input->setup_mes_dbgext.log_options;
+               break;
        default:
                DRM_ERROR("unsupported misc op (%d) \n", input->op);
                return -EINVAL;
@@ -962,6 +970,52 @@ static int mes_v12_1_inv_tlbs_pasid(struct amdgpu_mes =
*mes,

 }

+/*
+ * Enable/disable delivery of the MES firmware host interrupts at the
+CP.  The
+ * MES firmware debug-message ("mes_dbgext") interrupt is delivered to
+the IH
+ * as a CP EOP (src_id 181) on the MES scheduler pipe (me 3) and
+handled in
+ * gfx_v12_1_eop_irq(); it is gated by CPC_INT_CNTL in the me3/MES pipe
+context,
+ * selected via GRBM_GFX_CNTL.  Must run in process context (takes srbm_mu=
tex).
+ *
+ * Although the firmware C code passes Rs64HostIntrGeneric1IntEnable,
+the RS64
+ * library routine that actually raises the interrupt
+(AsmRs64SetHostIntr)
+ * hardcodes the TIME_STAMP assertion bit (CP_INT_STAT_DEBUG bit 26).
+So
+ * TIME_STAMP_INT_ENABLE - not GENERIC1_INT_ENABLE - is the
+CPC_INT_CNTL bit
+ * that lets the CP forward the assertion to the host IH.  CPC_INT_CNTL
+is
+ * per-(me,pipe); the enable must be set on both me3 pipes (0 and 1),
+matching
+ * the Windows/SR-IOV KMD path - setting it only on the scheduler pipe
+is not
+ * sufficient.  Armed on every XCC, since each runs its own MES and
+logs into
+ * its own per-XCC buffer region.
+ */
+static int mes_v12_1_enable_dbgext_irq(struct amdgpu_mes *mes, bool
+enable) {
+       struct amdgpu_device *adev =3D mes->adev;
+       int num_xcc =3D NUM_XCC(adev->gfx.xcc_mask);
+       u32 cp_int_cntl;
+       int pipe, xcc_id, inst;
+
+       mutex_lock(&adev->srbm_mutex);
+
+       for (xcc_id =3D 0; xcc_id < num_xcc; xcc_id++) {
+               inst =3D GET_INST(GC, xcc_id);
+
+               for (pipe =3D 0; pipe < 2; pipe++) {
+                       soc_v1_0_grbm_select(adev, 3, pipe, 0, 0, inst);
+
+                       cp_int_cntl =3D RREG32_SOC15(GC, inst, regCPC_INT_C=
NTL);
+                       cp_int_cntl =3D REG_SET_FIELD(cp_int_cntl, CPC_INT_=
CNTL,
+                                                   TIME_STAMP_INT_ENABLE, =
enable ? 1 : 0);
+                       WREG32_SOC15(GC, inst, regCPC_INT_CNTL, cp_int_cntl=
);
+               }
+
+               soc_v1_0_grbm_select(adev, 0, 0, 0, 0, inst);
+       }
+
+       mutex_unlock(&adev->srbm_mutex);
+
+       return 0;
+}
+
 static const struct amdgpu_mes_funcs mes_v12_1_funcs =3D {
        .add_hw_queue =3D mes_v12_1_add_hw_queue,
        .remove_hw_queue =3D mes_v12_1_remove_hw_queue, @@ -973,6 +1027,7 @=
@ static const struct amdgpu_mes_funcs mes_v12_1_funcs =3D {
        .reset_hw_queue =3D mes_v12_1_reset_hw_queue,
        .detect_and_reset_hung_queues =3D mes_v12_1_detect_and_reset_hung_q=
ueues,
        .invalidate_tlbs_pasid =3D mes_v12_1_inv_tlbs_pasid,
+       .enable_dbgext_irq =3D mes_v12_1_enable_dbgext_irq,
 };

 static int mes_v12_1_allocate_ucode_buffer(struct amdgpu_device *adev, @@ =
-1532,6 +1587,15 @@ static int mes_v12_1_sw_init(struct amdgpu_ip_block *ip=
_block)
        adev->mes.kiq_hw_fini =3D &mes_v12_1_kiq_hw_fini;
        adev->mes.enable_legacy_queue_map =3D true;

+       /*
+        * Enable mes_dbgext by default on mes12.1: seed an 8 KB runtime
+        * request so hw_init() -> amdgpu_mes_dbgext_start() brings the log=
 up at
+        * boot with no mes_dbgext_buffer_size module param needed.  The
+        * collection mode still follows mes_dbgext_options (default bit0 =
=3D 1,
+        * interrupt-driven).  Both module params continue to override this=
.
+        */
+       adev->mes.dbgext_runtime_kb =3D 8;
+
        adev->mes.event_log_size =3D AMDGPU_MAX_MES_PIPES *
                                   AMDGPU_MES_LOG_BUFFER_SIZE * num_xcc;

@@ -1826,11 +1890,15 @@ static int mes_v12_1_hw_init(struct amdgpu_ip_block=
 *ip_block)
                        return r;
        }

+       amdgpu_mes_dbgext_start(adev);
+
        return 0;
 }

 static int mes_v12_1_hw_fini(struct amdgpu_ip_block *ip_block)  {
+       amdgpu_mes_dbgext_stop(ip_block->adev);
+
        return 0;
 }

--
2.43.0

