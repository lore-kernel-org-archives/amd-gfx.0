Return-Path: <SRS0=chDG=IV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8DAC433C1
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Mar 2021 08:54:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8969461993
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Mar 2021 08:54:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8969461993
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F5BC6E1AA;
	Tue, 23 Mar 2021 08:54:17 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85C186E1AA
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Mar 2021 08:54:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LeW5Si6PFRoKMUH4yUHchjpRGuSwwBguH1hyd6qbRVDcM6BQ2M4S0ueXlCozDMjpDZDpjbGlaH0oPLljp4pLexv1oZPvQWijaG71h5AX42WUBWJQqtmOm9udCkK7oz3dz87PASOd6u2yn0k1Abj7hCT99o2ymsR9j7cd3IwoCvDWHHvM69jyBKrJGHJ/SsEevyEj0uPWq/TBy6P59oXYzK3Wfji5puafAuASn3R6YL/dbU1bM0WWMsWmcrHSrUhWQWqTzTOBdXkOJMB/02KkdB0g7FwlYP9AhuUeOWBKVpYxIysIoIYTn2bRi1cXykyMTtnjBQebvjIDu0caY3AtEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=suTT2xprhxPFufSfBv5RsR0mmn9zyoSvpzbrlUh0uCw=;
 b=KipMtZ1BOqy3cYvi68I39d2rAtWyjW3syObfhMF1JtLAtGocq1jZBqM/8kZExMRJiRZfI4jKROud/IECB6m9b8DNd2CRW2VeyFHLbiYC07kI0urhdCQtDyeq3wnOyLR9uTQQnRDZqoUlVU3ricbR4scgF2vWIIwEl6Vk4e7u2CNH/YZwqDTW1za48hxneQMYibQHiKebyD+vlUZamja8Vi1Mzpqdx4NI20JYjBFAnPkPrQzCwsXIpfEA69jP5YTYarKWNCyocLFK1W3NHxLXQrrJCieqFpWjYVF/8Hk5OAkPbwPAIuCu6c3keIolIUSoEOFWyGILDtl2ecPkrE99xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=suTT2xprhxPFufSfBv5RsR0mmn9zyoSvpzbrlUh0uCw=;
 b=cZ3xeaWA62v02YG4FQGMU0HfgcJvyuaNom6tOaMQV/4M/AfiMBI6qDyma+JgD68uQaK3ziaxNiNlNjkIMiRhw3xZQGL1lRlrLJ35Pzgoq1QxA5tEawU3bgeZxvqdUdYIUuKPnTglTXpXQFxniLeo0HnmwsUhN7umRX5B/tsiH8Q=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB2780.namprd12.prod.outlook.com (2603:10b6:5:4e::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.24; Tue, 23 Mar 2021 08:54:13 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c05d:8592:f72:bfc8]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c05d:8592:f72:bfc8%7]) with mapi id 15.20.3955.027; Tue, 23 Mar 2021
 08:54:13 +0000
From: "Quan, Evan" <Evan.Quan@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Chen,
 Jiansong (Simon)" <Jiansong.Chen@amd.com>
Subject: RE: [PATCH] drm/amd/pm: fix gpu reset failure by MP1 state setting
Thread-Topic: [PATCH] drm/amd/pm: fix gpu reset failure by MP1 state setting
Thread-Index: AQHXH6hjOSPXLZPDrkG80UKcpYxX6KqRRL6g
Date: Tue, 23 Mar 2021 08:54:13 +0000
Message-ID: <DM6PR12MB261965287529B063D89BA11AE4649@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <20210323054939.26101-1-guchun.chen@amd.com>
In-Reply-To: <20210323054939.26101-1-guchun.chen@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-23T08:54:11Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=b4746820-4911-4111-894c-cae43c7004f1;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0a5caf62-448d-4ab0-dbcb-08d8edd93b90
x-ms-traffictypediagnostic: DM6PR12MB2780:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB2780E9529205B6A6D52A6677E4649@DM6PR12MB2780.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 71s/fRYfC9N+OjtC4rJuLh3+uQW7SbhuPyLK3oDr0tpyTY/E1sr1lHqiM9nf4W3OAudCRug6CKCHDJTQW4O9yHyTT3vsVIG85yCSDz49RYnr7d6x+3evEaKiHbnyrlGDgSyTnG95c+c/Ko5QiopeJUl+RSIO2k+PMsKgoHrzxntz2iUVLKCWl0tkgguPj3WGKRFfvtjnSFc18dehIdnhfUrPEkpyxXuBGda7heAHjD1rfrA87nXHG10iRodFzrDYGJF4DrwfTAJ/9PZlPUf1hqI+4T43oMnO9ZwhEqOAvJsFFjn3tlr3wguQ2rSgWMS14mUDj+NFhgNPqt5qwj8CjXzWFJ/fuG7QsVsyHywPn8ozOayi9ohXNvE0kc5eXnfBGxsmjKMU+Y7KCPWCJoANRue5p7laDf1ChUGHsbET0thT2yKFjB7HvjMZWlmGVpzchER4YhmtwNQiBs1XnC4BsqP5orMl7pEERkC2L/HlN8tzvKoCPjeXVnRz9+chMbEKQTUAAwvBFL43RdGFnD6FoNEpEHch9HxtVZU980YMxhU5gE1JrzrB3L4C0EQUXtP1QwDEffp3rn6MF+zRACJdfEQ/OyUyvaBeTkZhDpbeUOcVZrKtxtlVuDEvSrHUBPvW71hKVEkB8SN02ip2yP8hF0sLJL7fv1PJx1+ydfqdj7k=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(136003)(39860400002)(396003)(366004)(6506007)(83380400001)(8676002)(8936002)(33656002)(71200400001)(5660300002)(66946007)(53546011)(66476007)(186003)(66446008)(478600001)(9686003)(86362001)(38100700001)(316002)(64756008)(55016002)(110136005)(66556008)(76116006)(7696005)(6636002)(2906002)(26005)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ZY8uq+swdlQuwa+DUXvEhB/7DHFqETMevri3f+lFUyEF4bh8NEINpp2e+7c4?=
 =?us-ascii?Q?eAMbEU7q8A3wqr+osbmq7CuFsoQtznBLviHS2CZxV3Y3mlPXWyEMVvPtlSg0?=
 =?us-ascii?Q?+jlzDsMkmyYoDK+Zlo1Im2GSFwAa3qiURuBhUd1CpvDLSvjZH2C7f1eE8Vu5?=
 =?us-ascii?Q?4n8FuWyiZ8NLgXp5sqLoOBd3A3Y4BhMxGwCdnT2e7CE+6kWbHvFJEzGvcxsG?=
 =?us-ascii?Q?b0eRjSffRZT3oU2XXUNC+unlbK8utsC7WMPFmnPZgt3juooFAQmKHUE05Dv1?=
 =?us-ascii?Q?HA6ancysswH30NDY0ucdSXDnBuMdjlU1x/66vhd0Y1N+5WD7XwkBVmWD6YCj?=
 =?us-ascii?Q?NVuPVBUTOw4eY0+QKoFezwrhN0o5YwKKagGm8b+VaGRdllRf1geGyQvhHhZ9?=
 =?us-ascii?Q?a8OTmSHVV9AiM6hwumvndGQQ+EHYzbyhXaUs+oJnCcbHGH06sQLw2r8zrPvE?=
 =?us-ascii?Q?+4cBLak0AhCf3GD7fzggFPvdkjFfGINXfTj4UlOa1d3a/Qy5lL26ciCNjGWT?=
 =?us-ascii?Q?CHBVnGs7RwikLQNb4ihpxLDP8ABtLTrgfEVvyG/53mZY+/yMWCh6Ls5QHTGg?=
 =?us-ascii?Q?OUPO7iTly3ScC92mXOmjNCAZ4HSdLlQoQ7lLFMi+cLqxWFQhx8N4tL6Q1ey9?=
 =?us-ascii?Q?eyg0xewcV1d/aBh6ykAoEMi2JcPAnKHrWLPgy1q+ymPBeN4kWZU3L9eagrwX?=
 =?us-ascii?Q?dy+qcDQ7CNP6H0mJ52JkmtcEPqDqQIc9xWQ4lCSI3f0/0dHWt/RtJXMcGOcv?=
 =?us-ascii?Q?g/yWeXAVJSROyD37llB6ESySscW6xjEYS2kEwoBmB4ZJxvhjscs1aNcW1wP6?=
 =?us-ascii?Q?7EMfv+T2JeAVJAxZNM+ZgLeXCcCQ9bwUV2U5boxfiVHBlNWkTti7toW9hqS1?=
 =?us-ascii?Q?QlZlrgo9Y5X2o/lfcaOeZ0rZhvYFpIwC94Cl6LN+0dN6GU+KZazHaJPGvxOH?=
 =?us-ascii?Q?z4TSCyac99zN4ixHZ47Ct4PyhTT3+3bR2UWKCN59qhmzf1J9u8mjDHYhCr/B?=
 =?us-ascii?Q?imGqysUUWAteLGc9S+Fu6KZ0A5nfAVZ8QMDWbvauBV51fAGtpALIC6whtEYX?=
 =?us-ascii?Q?hw20GyV/hyE00VhIYHkqCQG9oz5BNCxiEgRgPo8vIokxcpYEzyTvzZ0yS9CL?=
 =?us-ascii?Q?8JTYvBfzdpupPFskBimrDnrS8Mk+7Z4DwWGVEX769uk83YMrgQ9nRFbYR9Lt?=
 =?us-ascii?Q?c3fvh4DbdiFC2Eib9D5/O2577TaPIO4qw5bHWfsIccJHN3GWWyYyFciUW/27?=
 =?us-ascii?Q?BA3992iAbG+adE5kJm5cNXh1fugQoB/avHHStX8janJG0PmLvLFQte/A04K1?=
 =?us-ascii?Q?sk1rbFf9xiOv+OVzBFWQQb3W?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a5caf62-448d-4ab0-dbcb-08d8edd93b90
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2021 08:54:13.4581 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t0z758GFhHgtYPs2QOEYeNlmIry/E+MC4ZPCk+H13h4v71xD4Ur7wDWY16LGTkZL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2780
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Thanks! Reviewed-by: Evan Quan <evan.quan@amd.com>

-----Original Message-----
From: Chen, Guchun <Guchun.Chen@amd.com> 
Sent: Tuesday, March 23, 2021 1:50 PM
To: amd-gfx@lists.freedesktop.org; Lazar, Lijo <Lijo.Lazar@amd.com>; Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Cc: Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amd/pm: fix gpu reset failure by MP1 state setting

Instead of blocking varied unsupported MP1 state in upper level,
defer and skip such MP1 state handling in specific ASIC.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c                    |  3 ---
 .../gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    | 10 +++++++---
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 15e239582a97..0a6bb3311f0f 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -1027,9 +1027,6 @@ int amdgpu_dpm_set_mp1_state(struct amdgpu_device *adev,
 	int ret = 0;
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 
-	if (mp1_state == PP_MP1_STATE_NONE)
-		return 0;
-
 	if (pp_funcs && pp_funcs->set_mp1_state) {
 		ret = pp_funcs->set_mp1_state(
 				adev->powerplay.pp_handle,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 722fe067ac2c..72d9c1be1835 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -3113,14 +3113,18 @@ static int sienna_cichlid_system_features_control(struct smu_context *smu,
 static int sienna_cichlid_set_mp1_state(struct smu_context *smu,
 					enum pp_mp1_state mp1_state)
 {
+	int ret;
+
 	switch (mp1_state) {
 	case PP_MP1_STATE_UNLOAD:
-		return smu_cmn_set_mp1_state(smu, mp1_state);
+		ret = smu_cmn_set_mp1_state(smu, mp1_state);
+		break;
 	default:
-		return -EINVAL;
+		/* Ignore others */
+		ret = 0;
 	}
 
-	return 0;
+	return ret;
 }
 
 static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
-- 
2.17.1
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
