Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8D5CC6FA82
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Sep 2022 15:38:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 131A310E420;
	Fri, 23 Sep 2022 15:38:38 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE13510E420
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Sep 2022 15:38:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hqhg2GkCFSpprfMhNzn1X7GgeQDAJtEvNXLhcUrWleCsNz/A6PYUVTOqqsPSvHy/6HFXr85MgKqbAoTCRgKSmAvnbFyDZuJhdzMW7CyoKBcNYBhc+e8Ds5ry8ZAiZdclyFBKXsVeIAmmPhwz5Bnyum7eK5gvxR4wzjZnO/E3r5Ch9uzulAT2gsRWL1fTjPVhYcHoIIyozlUecAjmjq+ZW5pJ1uQF7/6NLtk/0uFchOLR3R34x3iljew4QLUUm0FCnvGDPULuKtenN+NMEL56QFBeVp1wijndVjTq/KuyvvvbJ8tTWO0/4FPUQGikeJQdcvsuoFKkKeMUWqGH0szjcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tPnX5eM5FY5FMgV47bmktNoYk2idOhXdigPdfZyV63k=;
 b=k9FiWpxl/pdux7yHbyTQ+4m375D1cy2KAI+cFvQzsDfJt+Gm/P1oT5/2fCsbo6pQD+9VNtSNKI4nhPBWnQcueghJtRleebf5kIhXn3+l20pgttNLAo31WS/Oa6qV4draSv+0xNFxUi0qM+NX/xY4pZsUEg8diVlc0wrcMarlJIYFYzAWEOE4V7Z4ajFJDM7xANE50Uqk6sFCXj1QB6RxBeEg07fphC8P11zBG1Yr2VF4RqpxmH6uf4s4U2GSEqB3sfkxTo9xTBzW0ymOmcyqOH0HgaECiWH3tZVynAAA3NeDhdDviEy/LrJPRq21JYHlFeoFvvYuoiGdehTJcTvyOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tPnX5eM5FY5FMgV47bmktNoYk2idOhXdigPdfZyV63k=;
 b=XxdcjViqHhV0Innkzq/vK6Jvq2GPEOqBzuOMVXVjhUy8GWotnDN0hd+B41YNWRgo4iCi4XefJ2VTyfP3SKBjlNIaeYGtVXkilsoTNQVWipkHLA5WahpKqFKtmD+5hfhZ8DyWPGpnri3KI/IWpwo4++T+lqOH1mzLiEIcaCZTMWI=
Received: from DM5PR12MB1323.namprd12.prod.outlook.com (2603:10b6:3:75::12) by
 CH0PR12MB5235.namprd12.prod.outlook.com (2603:10b6:610:d2::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5654.20; Fri, 23 Sep 2022 15:38:32 +0000
Received: from DM5PR12MB1323.namprd12.prod.outlook.com
 ([fe80::bd02:538:9e12:8a9a]) by DM5PR12MB1323.namprd12.prod.outlook.com
 ([fe80::bd02:538:9e12:8a9a%4]) with mapi id 15.20.5654.020; Fri, 23 Sep 2022
 15:38:32 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Sider, Graham" <Graham.Sider@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: fix dropped interrupt in kfd_int_process_v11
Thread-Topic: [PATCH] drm/amdkfd: fix dropped interrupt in kfd_int_process_v11
Thread-Index: AQHYz1iPdNal5Znl0EqdagC8QRTfs63tJkaA
Date: Fri, 23 Sep 2022 15:38:32 +0000
Message-ID: <DM5PR12MB1323B3F7CD8CDC8651EF79A18C519@DM5PR12MB1323.namprd12.prod.outlook.com>
References: <20220923142636.1007838-1-Graham.Sider@amd.com>
In-Reply-To: <20220923142636.1007838-1-Graham.Sider@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-09-23T15:38:30Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=d0bdf65e-fcee-4941-b9bd-032d6a83497f;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB1323:EE_|CH0PR12MB5235:EE_
x-ms-office365-filtering-correlation-id: 463b4b59-c22c-42ea-36b7-08da9d79abdd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lQq9S8vuHI03ue38lczuhiG7n4o538sNqb9N7zJtVNB6lNLn3ZsQQye9UvmFE6nlS+7dgS8I1PTEi8yiMkubxN6Jashpo0nAhfT1Sb0p9sezl2OtJIvmtPpj6ugIqqboCrnsu4BVY8juVP9HVTwN3cbov3SpPHm+1COKGuFh6K8N6Pw8lPQ4z6mqrPi02OBPQkkGr/uQa7xeRlPT1qoOvjOYMX702CvNfl54HwrLP6LQhuHDWZFNg7AwhYuPe8Wh8pQxj+EabpQfNrsurhBPogwSy7C/t1Qb6cqQ2u6p22Dj7J6k5h4kXjNqFZrHvsWyxBZ2LRZHnoeuTzglgxoS0M3eNUfgImEwKlgpKl3tFZgChejXNLoyC8VrW5ZMcBa7ZMaiTWhzhY506lTBntzJuwI2tzxN19ZK31zIKVGQHuKmX5A7zRvk4ozb0Q/fi4UL48IZTUzaD3SXCTaWwU4bsP8saKTsO822gIUcXgLqoJ9U6wGT/kkUupak9zZv2tQdw0HJRtyvbQWutmfn99p3zqmEe/zfO9GpDKD96fgnWONRte9+B3EpueOjQUNdxng2QsYGiLpfmTqeIQ1NpzWG/NUnTUDfxjeU82DpoEXoihP8SJx2RTiraHpFPTyjUdTtbO2cMc6wG0fCSxH+POdE3e/UxmRVw5mClnFxd08FfP6+PanuKIZsCzcgNVra6WRr+WPYdyk6UB6pS3YV0MBWIhFddNTG3jsOmofPgg8ySA3HDlXrTJP0toWZIkmxNuviY26TW1KtkkKX34ur2FbepQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1323.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(396003)(39860400002)(136003)(366004)(451199015)(66476007)(110136005)(9686003)(7696005)(6506007)(122000001)(53546011)(5660300002)(66446008)(38100700002)(64756008)(76116006)(33656002)(66556008)(41300700001)(26005)(52536014)(8676002)(4326008)(55016003)(86362001)(8936002)(186003)(66946007)(54906003)(316002)(38070700005)(478600001)(2906002)(83380400001)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Yi1uwTz2XwtiTJnVqbLmu5Vc9m09/0OVMIQojRyFcSq/0BXAd2TiC6s3gfaY?=
 =?us-ascii?Q?tp8AR81D6yvpSwBxdCenClv5RsQ7xLF6V6eoU4HO9nLy46iBBck5elsdCZXI?=
 =?us-ascii?Q?pgjWOkJGWLy8KRNtJdAVzl/B6/jL0oUqvLMHJ89mBbl4dvOhQqzcaawZEI2t?=
 =?us-ascii?Q?xtLj+l9Szj9iP79FUKbpYkjFPr5GjUcqwkUrG/sFsubRGuXCebSH/1k1wGSt?=
 =?us-ascii?Q?Z4Z2jDc8oGFCBYWi6uCdCqaZ7w0jCogfvUL+34VOBHCPMa/43qynSCh44CX9?=
 =?us-ascii?Q?DJm/PaZQLiIr03ZMixCMqRTQu2lbNrB4KfPtXZheq5FHxc2AQICc9jiI4Fdi?=
 =?us-ascii?Q?7ZnCrtE9Vfvn+skvggWfUQSutLK5xFGvSH0rd5BCA4mVzM0a3j0CCQPnJenz?=
 =?us-ascii?Q?Y0v4Ex/EkDgxvuwzzx0A9DL73hmlrEG6AA9gdouBHnW3nPtwP5+ZJshKj2Ep?=
 =?us-ascii?Q?bvWwbif22P70FcjLcf737552q1qbS8JVQWywvspse2hoWNWRhGCCVXAan0iJ?=
 =?us-ascii?Q?o8wnRidvRX6nE7V06+UXSTm16TQbYRd1zriDJGabuBbaEeu2uhHXY+q38+/b?=
 =?us-ascii?Q?2c0YKme6ktHLt1v5xLQ8U48v6VrMfHwVNqe6x8CsP4Rt9bO7Xp1HZodOwnJc?=
 =?us-ascii?Q?4cI+MfNTzYmKLAyhLBg/8S0VqwwX2XKKkiUb0oOHwcf2emwQ6OzLD2Z/juDs?=
 =?us-ascii?Q?Hk3Oh2+6QdqOn02k8BAIXgxTR5O/kwiwBD8X5mlWB0HP+3G1Uf583yYGlFrg?=
 =?us-ascii?Q?q6PGfkZO367QCVA5SX7ZGm4VSRjm8LhQeGrqvIP/ThPeDTpLEcQ0gUHaAc4p?=
 =?us-ascii?Q?ax64YE0CXrvEg9OVxCaTeGd7BfvTwetFtUHG3HF6fVswKOutP92AGxMUCpPO?=
 =?us-ascii?Q?MRJihXMqEP4ag2kPyBA3vdjQkQ/QreQnqmL7v8mMlNn98Msw3bGj2kAMwJ2G?=
 =?us-ascii?Q?iqo5N482RwTp6KB1b1BdcIxE0i2DcmWjuBZvrqZbsuTJGHiWOq5FGTSPxica?=
 =?us-ascii?Q?5e2esAcn/CkYKKRU7tq+ZoClkMflThxKt31stAPDzDorRcsKnTU6kFM4YDOh?=
 =?us-ascii?Q?sAgApcQ4kNuz5s8l5b7l5lOtOx0Y2/PYCKq8d4Go2G9h+JYk7yGgIANcMDnv?=
 =?us-ascii?Q?t6kOfP9KyyDbh9i0A71K+PqW+465MIrYk/53ngvFRfvs7odlaLVB3fEuNrRp?=
 =?us-ascii?Q?/NlzPb0XeALSSOjMPeNR9jAn+7OAK28MNioI8yoSWR/CKKssbeSWUQbQhHVD?=
 =?us-ascii?Q?5alE34Hck8jiYA6ZwTHC/x3xl7mZzruXFRYfYRpf5hwzEtDrsKNuxYQFcpKT?=
 =?us-ascii?Q?MKCwu9jrjFDRj8dAcDJjP8A4H69ifqDPhJ12WcE7gGfG1tvgMvxMbQHdqXdJ?=
 =?us-ascii?Q?mCd8t/eNWlhwOtzR8JvJXIDGv6bSh/IYtQXKwvVBqNeuzhIxBV8zPge+hmJx?=
 =?us-ascii?Q?H2j5f8MJc0ztcdldlBmJCBC+mxuoEkzmLgkB1iBRZJZti1ApWjx98fwJ97yt?=
 =?us-ascii?Q?BGOR93cFzkJwG1pOj1Vjv6/7sjve/2LK4Fp8q4s8IVYEw2NkhvaJbhwPSfKj?=
 =?us-ascii?Q?u/Ctk38R5D3iDMnfjUA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1323.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 463b4b59-c22c-42ea-36b7-08da9d79abdd
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2022 15:38:32.5882 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mru+AU5ZJ/FQy58gAC2PIqsG5WjswBRXRxuSQwD9fG3VO5TXJJhu+diURULydul2HXz0MBIovyhSZUz62Yvjpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5235
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
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Kim,
 Jonathan" <Jonathan.Kim@amd.com>, "Sider, Graham" <Graham.Sider@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Graham S=
ider
Sent: Friday, September 23, 2022 10:27 AM
To: amd-gfx@lists.freedesktop.org
Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Kim, Jonathan <Jonathan.Kim@a=
md.com>; Sider, Graham <Graham.Sider@amd.com>
Subject: [PATCH] drm/amdkfd: fix dropped interrupt in kfd_int_process_v11

Shader wave interrupts were getting dropped in event_interrupt_wq_v11 if th=
e PRIV bit was set to 1. This would often lead to a hang. Until debugger lo=
gic is upstreamed, expand comment to stop early return.

Signed-off-by: Graham Sider <Graham.Sider@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c b/drivers/gpu=
/drm/amd/amdkfd/kfd_int_process_v11.c
index a6fcbeeb7428..0d53f6067422 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
@@ -350,11 +350,11 @@ static void event_interrupt_wq_v11(struct kfd_dev *de=
v,
 				print_sq_intr_info_inst(context_id0, context_id1);
 				sq_int_priv =3D REG_GET_FIELD(context_id0,
 						SQ_INTERRUPT_WORD_WAVE_CTXID0, PRIV);
-				if (sq_int_priv /*&& (kfd_set_dbg_ev_from_interrupt(dev, pasid,
+				/*if (sq_int_priv && (kfd_set_dbg_ev_from_interrupt(dev, pasid,
 						KFD_CTXID0_DOORBELL_ID(context_id0),
 						KFD_CTXID0_TRAP_CODE(context_id0),
-						NULL, 0))*/)
-					return;
+						NULL, 0)))
+					return;*/
 				break;
 			case SQ_INTERRUPT_WORD_ENCODING_ERROR:
 				print_sq_intr_info_error(context_id0, context_id1);
--
2.25.1
