Return-Path: <SRS0=YIqZ=K6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D2CC07E94
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 09:12:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7141A6023F
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Jun 2021 09:12:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7141A6023F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AB456F5E8;
	Fri,  4 Jun 2021 09:12:31 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA3956F5E8
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Jun 2021 09:12:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BLPTkvmefmT+FSm5R/8ODNQTZ33/th7W9/PgYaP3FXRp5yLCwuysoz4xNhTDoH6Q9HpD2c5cewPHWS24prNjmnOR20ekoePPgj6ILHUXmkqctAICg7aw/ues7SQCJk9yQJflk/9ugFpjHH1UrqoVSMGcRP2plQlBFZxun+ZHvgRqPdmtIMX/tKvpc3oUjvtdA28RcKX3GnF0AuKDUTpOpSmOZFp0NGr4WWRYl8EJFGNjgDMG85N5IlRdD5fnoT+u4zcDLN26H+4bW+YJw06V7lc0pDUyJFSUm+mhDAiNLoTAJROKi3S5TXGGt67FyjOzTGSj2bsYPZJBrLKlvnkbxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UW9pQbVSL5Z9V4EntTqvDm7fV0Jkxg7yRzdWCVDnacI=;
 b=P4g0foWP3+CENPZBaorI/SPMbOWALGBfgeTUr5LR564oVwSaChFW8Bl4ljrYsSD9kynI6gUkFPUkSmEY8NMFxM3YQ1dQY6hvRw3pdsd/8BzrBFaFUZrx8zMrzoGcwblnsvwrsRc9SfnOzNTG/IxKTa85KObt2TE9tHXRDmWiFVIkYbM5cizYk1AsE6GTJyA+PhMAN0n/KMdX6pUicyb//MrhYel3QKCeL+RRuJ2otiaBX0MHXGrTs/fM3GOvsmLCAWvVOLwvhr8+oqCaaWbHjpqsJO/dYbDIufpmyvg0TLtaBXSNJqKBLU35X9KhLUPER2GQ7paAOPw7sCYb+RfHdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UW9pQbVSL5Z9V4EntTqvDm7fV0Jkxg7yRzdWCVDnacI=;
 b=k1qO0Omw4n1oO+Jp4/MQ/fq/JK8FSTVUBKpbefS2fMHv37XyfOpnFZS/eFzAbP0/DSeaGcyOZjvMi1+9+fd7F8kEwFfbE8jW5yDJNalPVy5jvR3QA3JWCTBb9T8oI2vsrvPoB3oxBrRo/n/kCkZtvx7BxlMiJBSz7LT4lkb30lE=
Received: from CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9)
 by CH0PR12MB5188.namprd12.prod.outlook.com (2603:10b6:610:bb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Fri, 4 Jun
 2021 09:12:27 +0000
Received: from CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::80e7:eb2e:843d:91e9]) by CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::80e7:eb2e:843d:91e9%3]) with mapi id 15.20.4195.024; Fri, 4 Jun 2021
 09:12:27 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/3] drm/amd/pm: Use generic BACO function for smu11 ASICs
Thread-Topic: [PATCH 3/3] drm/amd/pm: Use generic BACO function for smu11 ASICs
Thread-Index: AddZIZITXtvardYzSESB7W2Ox/weRg==
Date: Fri, 4 Jun 2021 09:12:27 +0000
Message-ID: <CH0PR12MB53484F15A9B0F7394ACA531F973B9@CH0PR12MB5348.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-06-04T09:12:23Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=56e2711a-7606-4ceb-ab13-6d92a6e346e0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
x-originating-ip: [2401:4900:2352:158d:ec71:65c6:5505:11d2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6ff4eeef-5960-4374-feb0-08d92738dfd1
x-ms-traffictypediagnostic: CH0PR12MB5188:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH0PR12MB5188B02B37BDB62D68566D45973B9@CH0PR12MB5188.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y5LrXPfoYTGyNn/musXEOIgEpBQZ/HeEm9Nn7LsBZj3XMB0J6Cllum2JjKvUforzC+DCu1vRDwNK+2kGRaJgOPIoROWt/LnWAwVFcekvwBDM0yJ/UWSO7+WLd6xgF0lkfpkfwZ0fXNUjf/Jmfz4Vxkc8jsv1N2/5HoqWgN1akT4U5BZlZflWodQw0T+1ZW9pHa8htivcu+ybAXaI6EoawrOkKQ6loSzQea2+XKwpFtyZPu5x/Ndk1mKkE+T7oXAsor844vzxnOfi1Ugv9XsmN9sQ6czzOQekiDSUDaAnxpJ8Mb3lMM9dT1cKsccxuBTnIj3upi75pCXr2+mXzs6U1Lf+U2MeUgKugNQMvdypRQkNiOQV2SX6w4JNEQACLE91MmStV18eQ22Vpt8wH3LsNYtDbXduQ4Nu1natcHweFc6ZIyCG5T+++o02FEMqZ/MKh7mzoF4uMYkwLY3aEylX4emyTfbETyjVkMzKiFTq+gzQG/TnSeGd+JUNhLemsbqrMcDOkEJNdHRUozeMbTFHtcFh3sisysg0Xk0Kxep2vnhXBS36lSjsrwpmNcCvbAsSs4NRrv+6ol7zuMthBu29uDgmhNqpCUce0tdBXs3UaaZOVLDxXOVEdcXPO+zNBWQszZ9v+XKZ+QPtsVKZ+FSjhw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(366004)(396003)(136003)(346002)(52536014)(316002)(76116006)(122000001)(71200400001)(186003)(8936002)(8676002)(478600001)(83380400001)(66446008)(66574015)(66946007)(64756008)(66556008)(66476007)(4326008)(54906003)(2906002)(33656002)(55016002)(9686003)(6916009)(6506007)(38100700002)(86362001)(5660300002)(7696005)(41533002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?yQTdX2TTjBSIczexVLalMQe3akxu7SohJ1PiHd/UHCIaGNtUyYkiPCp6WvBn?=
 =?us-ascii?Q?cUIrJOqFFGDPaQ3vV01E2vBJ6QCOqbfwojOBdrY/83weuJ/x95c5HlUpzUWA?=
 =?us-ascii?Q?JNB7XK3ZoO7sxljiR02Q1STOXvF7Nw3p/zHavis6BwFDvoOE7yeR0D940QnV?=
 =?us-ascii?Q?MYAOFmsJPbpK5NQrlJxOxvv0IHZkGQeSPP/tVVrQqjRm8jj8Ns5ajwrzFc/3?=
 =?us-ascii?Q?wQDrPqsrG41YF3O+mZuaTm1GxgUq/Hs7h7DmilCIf+JaBieSEOeakz7ZqigE?=
 =?us-ascii?Q?g7dXQP+xAvM7Lr4Aju7x5obxMpdmL+P9v9MeMNC/opQnagXgqMEMqWaj60Vu?=
 =?us-ascii?Q?APTJwH0WM719IWUD0nvr0zXNj5zaoqOyHw7H/dhSuCLt4g2KY/2bkAKK40xg?=
 =?us-ascii?Q?0mPa3LmZ2Xug975ySHyOmJrRoK/wsLCyn7GSNlTGc0EBilqG0vrbGgMkMFGp?=
 =?us-ascii?Q?XTROnw8DaiBsV+yd9PtWv0PpGC89ofgFdGab4Ewks9JlZObVdDBhJ+ejl7Ot?=
 =?us-ascii?Q?ule54ZuIcoI4nteDi4qVJxlAbTmCkbnMB2ZsNAbsfQsy2GHPNY/e9thngX7f?=
 =?us-ascii?Q?6w/uBvW93otdz35GIReNq5/bAEweUq6+RkATCSOTTrpWmCEJT2aGFhYGZ51O?=
 =?us-ascii?Q?NqJJakdaoYGYj0lmRPzUYh857We3myfPcNnL8nnbYZT6ypZbPrm+QcNNPfCA?=
 =?us-ascii?Q?yz1kWKqWE5IYA2j4lBO8NKioUFdgbM4patlIFpRuu3zBmVB3OsIfFpWBK6HF?=
 =?us-ascii?Q?R3ohZCvALn3WYZc/8BncCkvNhYAjAoMl1hln7R+omTrPrKf8Lux4Iow4A1Z2?=
 =?us-ascii?Q?f912S8x5VJZlTM8ZyN8rdpwfvsu/jPx3Xvan3FnQ/cS59vjXBo7TFererhiD?=
 =?us-ascii?Q?DqlAnfd3SvjJ/kweuTScAzgiWaMd9JQ0REdHYeL7HK5pZr6rDy7+SZBCcRJa?=
 =?us-ascii?Q?MiE+KZ4Obj4ERE6ncGHUd83HbghzGiMAJLp5BYZkMXfJW0Vg/MB4nLaAhKF2?=
 =?us-ascii?Q?zN8llCXDDqVYmBBDG5i18w+jphFxgAgf3Cfnt92gC+eJtOCCqrmk8E/mQ+Ym?=
 =?us-ascii?Q?iYDQYIriW2jsULkU+y2tR7Yk/3et6HZ0OH/VUxLeOTDsxq26tlstZkhZRMSG?=
 =?us-ascii?Q?53czo50ppfvtqbmC7ueQ6fp29BVEgFF6DoJCG5pnhAa86T/zMM+bwA66bDbp?=
 =?us-ascii?Q?dks2tsQD7rjfbxxAfXoom1aEW4+o/Q2MIEOvHlKKPfF/8QvdCBjejkDwAeFm?=
 =?us-ascii?Q?4B1rJaxXZd2MYtX/9Sc4Mp2whBNoTtLJEIGQIHdSvILoqcHcSutSuIOT+Wxn?=
 =?us-ascii?Q?X8LJp1tVraxZUo1r7nk0R4SO5kKyL4ua9usnxz+6XbdjvvVYxcM0+gzQYodM?=
 =?us-ascii?Q?HjTxA3pjXxyae8QZd8cC3haXf+So?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ff4eeef-5960-4374-feb0-08d92738dfd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2021 09:12:27.5323 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jlLkw44SoGEbjFbXiuylQsEGZtHppfDjqDH9CzUz4lPmtwEq0H1nFVPBmxdAcjnI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5188
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
Cc: "Quan, Evan" <Evan.Quan@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
Content-Type: multipart/mixed; boundary="===============1110175603=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1110175603==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CH0PR12MB53484F15A9B0F7394ACA531F973B9CH0PR12MB5348namp_"

--_000_CH0PR12MB53484F15A9B0F7394ACA531F973B9CH0PR12MB5348namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Remove ASIC specific functions for BACO support check. Use generic smu11
function instead.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c    | 12 +-----------
drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c      | 12 +-----------
.../gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c  | 12 +-----------
3 files changed, 3 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gp=
u/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 5c248accc4a6..5959019f51ad 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -2162,16 +2162,6 @@ static void arcturus_get_unique_id(struct smu_contex=
t *smu)
               sprintf(adev->serial, "%llx", id);
}
-static bool arcturus_is_baco_supported(struct smu_context *smu)
-{
-              struct amdgpu_device *adev =3D smu->adev;
-
-              if (!smu_v11_0_baco_is_support(smu) || amdgpu_sriov_vf(adev)=
)
-                              return false;
-
-              return true;
-}
-
static int arcturus_set_df_cstate(struct smu_context *smu,
                                                                 enum pp_df=
_cstate state)
{
@@ -2406,7 +2396,7 @@ static const struct pptable_funcs arcturus_ppt_funcs =
=3D {
               .register_irq_handler =3D smu_v11_0_register_irq_handler,
               .set_azalia_d3_pme =3D smu_v11_0_set_azalia_d3_pme,
               .get_max_sustainable_clocks_by_dc =3D smu_v11_0_get_max_sust=
ainable_clocks_by_dc,
-              .baco_is_support=3D arcturus_is_baco_supported,
+             .baco_is_support =3D smu_v11_0_baco_is_support,
               .baco_get_state =3D smu_v11_0_baco_get_state,
               .baco_set_state =3D smu_v11_0_baco_set_state,
               .baco_enter =3D smu_v11_0_baco_enter,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/=
drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 31e9cc3f3ea0..74a8c676e22c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2257,16 +2257,6 @@ static int navi10_overdrive_get_gfx_clk_base_voltage=
(struct smu_context *smu,
               return 0;
}
-static bool navi10_is_baco_supported(struct smu_context *smu)
-{
-              struct amdgpu_device *adev =3D smu->adev;
-
-              if (amdgpu_sriov_vf(adev) || (!smu_v11_0_baco_is_support(smu=
)))
-                              return false;
-
-              return true;
-}
-
static int navi10_set_default_od_settings(struct smu_context *smu)
{
               OverDriveTable_t *od_table =3D
@@ -3102,7 +3092,7 @@ static const struct pptable_funcs navi10_ppt_funcs =
=3D {
               .register_irq_handler =3D smu_v11_0_register_irq_handler,
               .set_azalia_d3_pme =3D smu_v11_0_set_azalia_d3_pme,
               .get_max_sustainable_clocks_by_dc =3D smu_v11_0_get_max_sust=
ainable_clocks_by_dc,
-              .baco_is_support=3D navi10_is_baco_supported,
+             .baco_is_support =3D smu_v11_0_baco_is_support,
               .baco_get_state =3D smu_v11_0_baco_get_state,
               .baco_set_state =3D smu_v11_0_baco_set_state,
               .baco_enter =3D smu_v11_0_baco_enter,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/driv=
ers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 6614dbb723be..f01e919e1f89 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -2100,16 +2100,6 @@ static int sienna_cichlid_run_btc(struct smu_context=
 *smu)
               return smu_cmn_send_smc_msg(smu, SMU_MSG_RunDcBtc, NULL);
}
-static bool sienna_cichlid_is_baco_supported(struct smu_context *smu)
-{
-              struct amdgpu_device *adev =3D smu->adev;
-
-              if (amdgpu_sriov_vf(adev) || (!smu_v11_0_baco_is_support(smu=
)))
-                              return false;
-
-              return true;
-}
-
static bool sienna_cichlid_is_mode1_reset_supported(struct smu_context *smu=
)
{
               struct amdgpu_device *adev =3D smu->adev;
@@ -3882,7 +3872,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_=
funcs =3D {
               .register_irq_handler =3D smu_v11_0_register_irq_handler,
               .set_azalia_d3_pme =3D smu_v11_0_set_azalia_d3_pme,
               .get_max_sustainable_clocks_by_dc =3D smu_v11_0_get_max_sust=
ainable_clocks_by_dc,
-              .baco_is_support=3D sienna_cichlid_is_baco_supported,
+             .baco_is_support =3D smu_v11_0_baco_is_support,
               .baco_get_state =3D smu_v11_0_baco_get_state,
               .baco_set_state =3D smu_v11_0_baco_set_state,
               .baco_enter =3D smu_v11_0_baco_enter,
--
2.17.1


--_000_CH0PR12MB53484F15A9B0F7394ACA531F973B9CH0PR12MB5348namp_
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
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<p class=3D"msipheaderc10f11a2" align=3D"Left" style=3D"margin:0"><span sty=
le=3D"font-size:10.0pt;font-family:Arial;color:#008000">[Public]</span></p>
<br>
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Remove ASIC specific functions for BACO support chec=
k. Use generic smu11<o:p></o:p></p>
<p class=3D"MsoNormal">function instead.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Signed-off-by: Lijo Lazar &lt;lijo.lazar@amd.com&gt;=
<o:p></o:p></p>
<p class=3D"MsoNormal">---<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c&nb=
sp;&nbsp;&nbsp; | 12 +-----------<o:p></o:p></p>
<p class=3D"MsoNormal">drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; | 12 +-----------<o:p></o:p></p>
<p class=3D"MsoNormal">.../gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c&=
nbsp; | 12 +-----------<o:p></o:p></p>
<p class=3D"MsoNormal">3 files changed, 3 insertions(+), 33 deletions(-)<o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arct=
urus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c<o:p></o:p></=
p>
<p class=3D"MsoNormal">index 5c248accc4a6..5959019f51ad 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_pp=
t.c<o:p></o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_pp=
t.c<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -2162,16 +2162,6 @@ static void arcturus_get_uniq=
ue_id(struct smu_context *smu)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sprintf(adev-&gt;serial, &quot;%llx&quot;,=
 id);<o:p></o:p></p>
<p class=3D"MsoNormal">}<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">-static bool arcturus_is_baco_supported(struct smu_c=
ontext *smu)<o:p></o:p></p>
<p class=3D"MsoNormal">-{<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&gt;adev;<o:=
p></o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; if (!smu_v11_0_baco_is_support(smu) || amdgpu_s=
riov_vf(adev))<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<o:p></o:p></=
p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; return true;<o:p></o:p></p>
<p class=3D"MsoNormal">-}<o:p></o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">static int arcturus_set_df_cstate(struct smu_context=
 *smu,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;enum pp_df_cstate state)<o:p></o:p></p>
<p class=3D"MsoNormal">{<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -2406,7 +2396,7 @@ static const struct pptable_fu=
ncs arcturus_ppt_funcs =3D {<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .register_irq_handler =3D smu_v11_0_regist=
er_irq_handler,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_azalia_d3_pme =3D smu_v11_0_set_azali=
a_d3_pme,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_max_sustainable_clocks_by_dc =3D smu_=
v11_0_get_max_sustainable_clocks_by_dc,<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; .baco_is_support=3D arcturus_is_baco_supported,=
<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; .baco_is_support =3D smu_v11_0_baco_is_support,<o:p><=
/o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .baco_get_state =3D smu_v11_0_baco_get_sta=
te,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .baco_set_state =3D smu_v11_0_baco_set_sta=
te,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .baco_enter =3D smu_v11_0_baco_enter,<o:p>=
</o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi=
10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c<o:p></o:p></p>
<p class=3D"MsoNormal">index 31e9cc3f3ea0..74a8c676e22c 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.=
c<o:p></o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.=
c<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -2257,16 +2257,6 @@ static int navi10_overdrive_g=
et_gfx_clk_base_voltage(struct smu_context *smu,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<o:p></o:p></p>
<p class=3D"MsoNormal">}<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">-static bool navi10_is_baco_supported(struct smu_con=
text *smu)<o:p></o:p></p>
<p class=3D"MsoNormal">-{<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&gt;adev;<o:=
p></o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev) || (!smu_v11_0_baco_i=
s_support(smu)))<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<o:p></o:p></=
p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; return true;<o:p></o:p></p>
<p class=3D"MsoNormal">-}<o:p></o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">static int navi10_set_default_od_settings(struct smu=
_context *smu)<o:p></o:p></p>
<p class=3D"MsoNormal">{<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OverDriveTable_t *od_table =3D<o:p></o:p><=
/p>
<p class=3D"MsoNormal">@@ -3102,7 +3092,7 @@ static const struct pptable_fu=
ncs navi10_ppt_funcs =3D {<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .register_irq_handler =3D smu_v11_0_regist=
er_irq_handler,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_azalia_d3_pme =3D smu_v11_0_set_azali=
a_d3_pme,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_max_sustainable_clocks_by_dc =3D smu_=
v11_0_get_max_sustainable_clocks_by_dc,<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; .baco_is_support=3D navi10_is_baco_supported,<o=
:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; .baco_is_support =3D smu_v11_0_baco_is_support,<o:p><=
/o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .baco_get_state =3D smu_v11_0_baco_get_sta=
te,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .baco_set_state =3D smu_v11_0_baco_set_sta=
te,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .baco_enter =3D smu_v11_0_baco_enter,<o:p>=
</o:p></p>
<p class=3D"MsoNormal">diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sien=
na_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c<=
o:p></o:p></p>
<p class=3D"MsoNormal">index 6614dbb723be..f01e919e1f89 100644<o:p></o:p></=
p>
<p class=3D"MsoNormal">--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cich=
lid_ppt.c<o:p></o:p></p>
<p class=3D"MsoNormal">+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cich=
lid_ppt.c<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -2100,16 +2100,6 @@ static int sienna_cichlid_run=
_btc(struct smu_context *smu)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return smu_cmn_send_smc_msg(smu, SMU_MSG_R=
unDcBtc, NULL);<o:p></o:p></p>
<p class=3D"MsoNormal">}<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p></o:p></p>
<p class=3D"MsoNormal">-static bool sienna_cichlid_is_baco_supported(struct=
 smu_context *smu)<o:p></o:p></p>
<p class=3D"MsoNormal">-{<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&gt;adev;<o:=
p></o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_sriov_vf(adev) || (!smu_v11_0_baco_i=
s_support(smu)))<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<o:p></o:p></=
p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; return true;<o:p></o:p></p>
<p class=3D"MsoNormal">-}<o:p></o:p></p>
<p class=3D"MsoNormal">-<o:p></o:p></p>
<p class=3D"MsoNormal">static bool sienna_cichlid_is_mode1_reset_supported(=
struct smu_context *smu)<o:p></o:p></p>
<p class=3D"MsoNormal">{<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D smu-&gt;ade=
v;<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -3882,7 +3872,7 @@ static const struct pptable_fu=
ncs sienna_cichlid_ppt_funcs =3D {<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .register_irq_handler =3D smu_v11_0_regist=
er_irq_handler,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_azalia_d3_pme =3D smu_v11_0_set_azali=
a_d3_pme,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .get_max_sustainable_clocks_by_dc =3D smu_=
v11_0_get_max_sustainable_clocks_by_dc,<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; .baco_is_support=3D sienna_cichlid_is_baco_supp=
orted,<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; .baco_is_support =3D smu_v11_0_baco_is_support,<o:p><=
/o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .baco_get_state =3D smu_v11_0_baco_get_sta=
te,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .baco_set_state =3D smu_v11_0_baco_set_sta=
te,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .baco_enter =3D smu_v11_0_baco_enter,<o:p>=
</o:p></p>
<p class=3D"MsoNormal">-- <o:p></o:p></p>
<p class=3D"MsoNormal">2.17.1<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_CH0PR12MB53484F15A9B0F7394ACA531F973B9CH0PR12MB5348namp_--

--===============1110175603==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1110175603==--
