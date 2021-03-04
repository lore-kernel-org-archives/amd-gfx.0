Return-Path: <SRS0=anlk=IC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E894C433E0
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 09:32:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A40164EE6
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Mar 2021 09:32:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A40164EE6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1FE56E4A1;
	Thu,  4 Mar 2021 09:32:07 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E0CF6E1F5
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Mar 2021 09:32:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OIN+qyZigvdD3Vgf0EpqCi65AbIG2ydu0VxzMPUwGCzU3WkovH9I647xYA+YAgEjgBdZAeIYNQSgsiI3mdFxIUOJpkkKNR4WqZjmMydrQT6AOU6haEKxmxgNEQj8I/GI+j8D8RdHsBfKMVmDl2HzHuwci4JNDSkJtzPO2Kcme9qY+6eHaDdtcqh0ORpf5ZLbmuCmzcTFAlMSlX0HlGvqC7Du7zuIsPQdiIgRxoKuyybA2NGXELSkrTdZyL7ST/M/RJsXEoMi5KHSUUIA+x6xw+sVmuxBQlo4uGoozVPwogbqMcRwYVO85A9WD20Mcmf63YXpEBn/8sd30kcG/PXRug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ap/ZFda751Tzm8R/qG+9Tac7la4+TXPnTaPp3nlJCaY=;
 b=libKh1uI9ud45D8Q62+QknRWePOe8JFebYsksBCCTcPjkQ0Wc68k3Fq9Rt0cmoeUH8zZhb9yEzzESh+dle3/JXKU6SpaQC05l+dNdFmjwA2hSY+kBa6j1jiyYWtoYSVMpw8xftWAuF3KUcldIY5fCKFPLlJEYYuxxq6UUL9viGGod9Ew8FJWT3DKGHw5GM6PGiTpCeqaspJs7rcBmEbeQ0KAY6J4hE+O0OvsAeLb8hFGjWErQhm9VCWbwcpfDia4PTYKTNHUsGeZtPTYCdPwfRjNOA1TSKqzws4Bg2BEhf7lGI5ES6ie/9p6A7AjHRs9uuVRKlZ4f35Kxoy37ZvkJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ap/ZFda751Tzm8R/qG+9Tac7la4+TXPnTaPp3nlJCaY=;
 b=aXPUDhOPJbNBXbgFboB79uIwz80P5jnQ2h3exWlIg3dcMmz5Ng3jNO47bu86nEGQCuDnZse2UbOaH6v9ITEkGAUIWjpfsxNkgSgUWNfR8pDBICPcJwMVJ1ydmFGNef1PlRi0YtAQd3DfRm5SVyU6yUZfc6J1N8F42AtvTDN1V/U=
Received: from DM6PR12MB4603.namprd12.prod.outlook.com (2603:10b6:5:166::11)
 by DM6PR12MB4941.namprd12.prod.outlook.com (2603:10b6:5:1b8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Thu, 4 Mar
 2021 09:32:04 +0000
Received: from DM6PR12MB4603.namprd12.prod.outlook.com
 ([fe80::69b7:e163:347a:ba70]) by DM6PR12MB4603.namprd12.prod.outlook.com
 ([fe80::69b7:e163:347a:ba70%6]) with mapi id 15.20.3890.028; Thu, 4 Mar 2021
 09:32:04 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: remove duplicate XGMI feature mask
Thread-Topic: [PATCH] drm/amd/pm: remove duplicate XGMI feature mask
Thread-Index: AQHXEMkBdIuIUWqL0U2rp7ek+azODapzkNvw
Date: Thu, 4 Mar 2021 09:32:04 +0000
Message-ID: <DM6PR12MB4603C64E1459BED1031A019BFE979@DM6PR12MB4603.namprd12.prod.outlook.com>
References: <20210304073445.15143-1-kevin1.wang@amd.com>
In-Reply-To: <20210304073445.15143-1-kevin1.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=051fc2c3-1dd5-4086-ae6e-9c49adc98ca2;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-04T09:31:54Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fdcc1d69-1639-4507-7587-08d8def05f75
x-ms-traffictypediagnostic: DM6PR12MB4941:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB49413CD4DF5C4FBC44B3E0C7FE979@DM6PR12MB4941.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: azvyMQlkhleQqTNebXZkB3Nj6jnO/iLpyeEKJYxVk28WZpGAvNo+Ji65oLi8MsUcLMyGv97lkr/kg01WyK1xceetiMX16DQsXk6tEEJPpQwIK8HwFjrXVUV6vv3oN7tmgoBcgfpRFzJAbs/q6mOjnVfxx6UjVO6MXFcVY90NcH4arhgV4hrMt3IEASnBz0l34WXomk0XMYt68WZHLQlY22XS1FQ9bvuWC6N39EEINFarjaqNUvwlgIJ0zMsqT0hMYHr3DMCxBZh+ubv7PcAtNdDWnIyCKRIQkMZBa5lTsfGyW27Ia9SkNTZ8XymqZrxe2TS0pr7ZZQjuVxb3XMYYzlI8Yhr6RbtTHSnQxDdWlFi3lD0mQBAk8K2UDTpn1MekejKuBMThZrC6mxJVcMCuIGiKNOj1wb7JJ3Xju9aYsdr5UvoOXsGIhWY2UHsYUjNSv84fErSEYfaLmZnSxdUbIpBICDO6+mkQ9V19a2MTE74QLkyO9UlAiP+7ROQm6LRskC8WAdzEXUakV96FVoqNBuvxUdefJZa82IdhdtYkufeEgYOBliBQupecPqKtJP2t
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4603.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(136003)(376002)(366004)(396003)(33656002)(2906002)(966005)(9686003)(71200400001)(76116006)(55016002)(8936002)(478600001)(86362001)(45080400002)(5660300002)(66476007)(64756008)(316002)(110136005)(6506007)(186003)(8676002)(26005)(7696005)(83380400001)(53546011)(66446008)(66556008)(4326008)(52536014)(66946007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?WMRCuGFBsoeclDGHE7o7oisnoSyCM+MsJbzllfE1u5ZWElD8VRKhye6UHRe0?=
 =?us-ascii?Q?Ta0UGJhVTj3GvYjzI3PGfbVUBCK4MReZayZ/1dajj9s5C3hwKuX4Gqg95Prs?=
 =?us-ascii?Q?0n5rhFWivVSeQsX15w3sXdgOo6Wbw40RfKquAtRohRBl42zJFcC87UG81tOd?=
 =?us-ascii?Q?T1LIVgcNw2JSWCgZuGXnj73xO+YK1XRMLh7etyn5N/CHdbAopWLuQTMkLNZS?=
 =?us-ascii?Q?vQ6Wa0J+EnBZbSX+JBlxWFRsfB2ptICDRUhfCLOmsw2Dd0O9HKSr8tLeEt/6?=
 =?us-ascii?Q?hQK+LIS3bi8hLv7eSKxe5pNt0Swl1bgnWB7PwS0XTc+3koBvcF6JIKf7QeDS?=
 =?us-ascii?Q?YqEBRyBo2V5b8P/hNo8eS6iTA6bYCwciROngPQvI+Ht1wYI0XmCs3RHN4Q0P?=
 =?us-ascii?Q?lE+YCEgpimTlYANxEIisVn9p0+xVaOu40gmBHk4qnI3ZGG4Am2XSWilJkodb?=
 =?us-ascii?Q?7G/zmEWH7NEMS0902pv4uXByV54yUaD7WE4e6RtFz4DAVpP0s52xl8+pzk44?=
 =?us-ascii?Q?VNhybNydeCSg3IgwLRjOxRWfL7Wgkuqikh2Lm7mtNdBE+b2geq0zOA04CAbP?=
 =?us-ascii?Q?V1HM6ZjujKg5g6nnStGR8bM07j6XnmXw5ivhkcACxgG8zWNO61jWZQXJH1Ir?=
 =?us-ascii?Q?ib6/40H71pmfgg5cncMEGFJEIQpZctcYuuyWwbaaZoGTZAFMnbNzJ+qiuXix?=
 =?us-ascii?Q?wU4wWgoMYBC8akeZtFZfumIVicpvnpUTr2aTtY9q1+3tn/RSp6YQKD+9+EhE?=
 =?us-ascii?Q?vK63tAiAxcQ0aJv9OU42SuVWg5kavBerq+DSAMuxDieHDK9VtrvCjE6GaUxb?=
 =?us-ascii?Q?/ZuzAh4nAXJAXeLYkRu5zBa/gQl1rexAAsysRt4e4UbK4nUtmnYR5nDtxnIM?=
 =?us-ascii?Q?hcHzgTJmJmeXejDmzfyxrsvdqLCvegTOjShfci1kfEWVYRxCKWzj22VuXPeB?=
 =?us-ascii?Q?l2Ky9w3C/an8jw5vl4gf38HZybQqIshcudHhDPUHpDOuKXCbW6ihYBkJnTr8?=
 =?us-ascii?Q?zpZQDrPJ3lrta0R53JYbFMmn2kyXzEXNsuNPJsMr5MCPUx6x0AGaNRI2kReY?=
 =?us-ascii?Q?KTx4+VLoHbe/L/LBGB2H+ZDNHv90o6FTDiVZ3DQK5fyo8zWJs0Xfti+OvZxU?=
 =?us-ascii?Q?ujMMlye7QYgW4fguYPPH4Y68kfnsuc9UqFsg/yEzOgBnIYGuOD67lC3HzQhI?=
 =?us-ascii?Q?0iFpSzkrLy5TmicF30M/569mm//3DqI195NLoH7AKi7J7OxR+l9uV7Gemnwi?=
 =?us-ascii?Q?WChBMzV7XDZu1Z8lyc4iDd0sB7Gie/wF9T9RkcsCSI+Lhl6UzXtNcivvz8iT?=
 =?us-ascii?Q?uWkBBVeC6eWBfT4aMp5nd/sm?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4603.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdcc1d69-1639-4507-7587-08d8def05f75
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2021 09:32:04.7166 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nQGraykGn/Gol+2DSwjHU+mPvCVwtTbbrwOh7usCRbL26lYX4rEykb5QZsxkbNqO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4941
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
Cc: "Wang, Kevin\(Yang\)" <Kevin1.Wang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Series is Acked-by: Feifei Xu <Feifei Xu@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Kevin Wang
Sent: Thursday, March 4, 2021 3:35 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wang, Kevin(Yang) <Kevin1.Wang@amd.com>
Subject: [PATCH] drm/amd/pm: remove duplicate XGMI feature mask

replace SMU feature XGMI with XGMI_DPM.
it will cause show to be incorrect in pp_features node.

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/inc/smu_types.h            | 1 -
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_types.h b/drivers/gpu/drm/amd/pm/inc/smu_types.h
index aa4822202587..f9f45b6764fa 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_types.h
@@ -282,7 +282,6 @@ enum smu_clk_type {
        __SMU_DUMMY_MAP(DS_FCLK),                       \
        __SMU_DUMMY_MAP(DS_MP1CLK),                     \
        __SMU_DUMMY_MAP(DS_MP0CLK),                     \
-       __SMU_DUMMY_MAP(XGMI),                          \
        __SMU_DUMMY_MAP(DPM_GFX_PACE),                  \
        __SMU_DUMMY_MAP(MEM_VDDCI_SCALING),             \
        __SMU_DUMMY_MAP(MEM_MVDD_SCALING),              \
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index f76d1b8aeecc..8189457a3ae6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -162,7 +162,7 @@ static const struct cmn2asic_mapping arcturus_feature_mask_map[SMU_FEATURE_COUNT
 FEA_MAP(DPM_SOCCLK),
 FEA_MAP(DPM_FCLK),
 FEA_MAP(DPM_MP0CLK),
-ARCTURUS_FEA_MAP(SMU_FEATURE_XGMI_BIT, FEATURE_DPM_XGMI_BIT),
+FEA_MAP(DPM_XGMI),
 FEA_MAP(DS_GFXCLK),
 FEA_MAP(DS_SOCCLK),
 FEA_MAP(DS_LCLK),
--
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CFeifei.Xu%40amd.com%7Cda4d4b204a46456f7fec08d8dee02282%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637504401527391042%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=aWb9nQWgyQXwiNOPBMZhEsUu8XJvzpa%2FVHP7JVdzPe4%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
