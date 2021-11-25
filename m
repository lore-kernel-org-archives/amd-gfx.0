Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF275C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Nov 2021 13:22:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 723A66EDD6;
	Thu, 25 Nov 2021 13:22:26 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD7836EDD6
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Nov 2021 13:22:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nmdFPPnsuXD/lWQMGvdEhFdfyKwQHdKt7bNTeUxUd7/aQuZYrffJOTvfle/yN4AAKKpA76oywRr7iVo9NtkpYsq06bOP2CISkdJzd0gVBOCVcd/FoZoamhVgHRLwQhusFTGr3adqaz8QA8KstL9Tp0zKSak+dgLyloi9WDG/jHkFkBp+jZ6ZharLGcnsuLPJxfB298sHFYPz34RO/gqLr/TElfN3suQkP22wyeCDADmDxACflqikCJJ7FafRX+i2lGqRuwFARA4jmEPMZLn9Jjh2RPvMEjZeSqXJAEE1oMCx++F4+WqDfYVRkI/eNMmhzYoULBLDi+q/UK0kY9JuIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oob9DXnNNHitHUowXjC8iHCVVkNQQne7fXf4j6XQguk=;
 b=BYsJfgEM5YXfHpqDB0quKww1wMuRnJ0g08ZzEq6UTTaeNIoSp2ZLQluHklkKQm5eHKlIByqAloTRh52ztxTH13C1vfeA31Upj+Txtf6l5JMNuCfs8ZBVUxrttzCbbmBnnPRwTxNL+oLLrjS7lg0YGcRTZfwudI/AssCa/VvRwMvTxkYiNEZjfiGWTQabrgcn3IxNk8NnSIdTqetNaGBJtOXOybaSmQOu3n/Pk5wxEkvysBZUfFxknosidQQPeW5Aa50quYL0PrKAaqwhnSHkHwF3oUEy3D96p3zoGG7fWcFA5Ksp1qEOiGILCK6v7rPaTohzoyoeXda+MtQzLIR8OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oob9DXnNNHitHUowXjC8iHCVVkNQQne7fXf4j6XQguk=;
 b=HwBUvRjyz6v1Yjw+FY5Psz/xV3Fb0C6pMyTgE5NVqyw6ekKyC4qpZGbTs4i8NX5VP1kSPnQg0ONAb+V4LrEwkCmmjBBr6nbf2S5lEKsMmU+rJYSp+6GPK866hDQ2Fxi/mAmbjD2xeJWMBgGFcQonZPwm1yzSiEKZnpKXWgKWGkU=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM6PR12MB3177.namprd12.prod.outlook.com (2603:10b6:5:187::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.21; Thu, 25 Nov 2021 13:22:22 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3142:d7d2:56a7:7c45]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3142:d7d2:56a7:7c45%3]) with mapi id 15.20.4713.027; Thu, 25 Nov 2021
 13:22:22 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: Add warning for unexpected PG requests
Thread-Topic: [PATCH] drm/amd/pm: Add warning for unexpected PG requests
Thread-Index: AQHX4fLC0IzgKa/UtkqbnkLhalwitqwUOtRA
Date: Thu, 25 Nov 2021 13:22:22 +0000
Message-ID: <DM5PR12MB2469D8345E74CB6B2299130AF1629@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20211125115049.122591-1-lijo.lazar@amd.com>
In-Reply-To: <20211125115049.122591-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-11-25T13:21:36Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=5a13f787-7fb6-488c-8925-2b24adec001e;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2021-11-25T13:22:19Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: 9f311395-ba9e-466c-b9d4-bd40771427af
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c532685c-f666-4d3f-f112-08d9b0169d5d
x-ms-traffictypediagnostic: DM6PR12MB3177:
x-microsoft-antispam-prvs: <DM6PR12MB3177EAA5EF38C9DB563B7B71F1629@DM6PR12MB3177.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3044;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ybpHqh8ZuzQ0dWPX9XZYnqiDbnXCaxsX0G9nf/zDZ/XzW0EPpTG4jMdiCqk4vaeKD0gc1BcWlffKIFf+v3/U2eNFgkNaZOwWYSaH+JqoA8xQYsXUBC/n4MABnIlLPbnWGmuOAdSSxgzidM461wM4vDCEw+VcQkha4DOQSmrZFYwhIHeWu0b8YNTUD0bdZNrYiQnprvzQba7QG7yUzDCrT4RidhRYYMnxXvWHwUCtV9T77cJlyOnbpPs8uJk1dE0SBsj0wUtJk3/7XTuQxvUkz6A52RuKc3Xvg1qbaJIbaD7GgAbSBisef1A33kluMgARsaW2fHvQeayVpguZMyuw0ZZVaPZlgsfaK7lVbWsTz6jziCFHkB6pdiLti5sI6C/Y597SPBnkw5SvMLcXxK1gJKcEviTKxNdtuUDbAEzghX4MMmlWmVVIf4mbi06ak1SvpOOudXnNblRInhYkr91CAVfqgzqMMOzAPjXHX9oBxlC2mFfsbxYMJ/GH5DevPriB2ZSk3jZ5K1x5LV/UIzkexSTmGnR1l56WeD7wPnG+frIjR2BgmsdnJQ1vJ4uSlJcchTxnBir+QaqHR8Xfzw076e8dFLUezeDgw8iSb/PxfA15yOyPsLBzU2eOxT3CbC+7Q51KeRHrcA+UBLoyOwlk7FEHR2pKfjVo/vtLhRd8hXiXoVWCqX0fg4QH/5MDDtDD4s/9CfoPGU1QMN3UDagJ2g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(64756008)(66556008)(66446008)(66476007)(55016003)(66946007)(9686003)(508600001)(33656002)(4326008)(2906002)(122000001)(6506007)(86362001)(110136005)(71200400001)(5660300002)(8936002)(52536014)(54906003)(8676002)(38100700002)(186003)(83380400001)(38070700005)(26005)(316002)(7696005)(76116006)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wJGqqQzlbrTrldIaJCYSBsmSmYcerXfYIthAIaoXZw64rlDGjaU2Fw02vqFW?=
 =?us-ascii?Q?i1hWdCZ1Wm8/8ekx2EUekk1thnMmA9aL4qimqPyZrwMiQB3S/sxWoPToF6JG?=
 =?us-ascii?Q?mY3wUFf6qsSP1mPts0YMEeTJ7kfJWbFBma30DdBqNUhn32CwmDn2nOJlcLXM?=
 =?us-ascii?Q?sHC3/1atGkhaOGZv3Xc5rLiqwHyufdTF1lB2wsGcoaQW1PJJVhqINjbgp+Ru?=
 =?us-ascii?Q?XWvsyl95TgQroHvc5NGqRBEmkQm1+Bhzoy7gxhDZ1h6DekyAnuS0+s/iUvOr?=
 =?us-ascii?Q?Nnbby+g8gAjjnBJU670KTOkf/CaeyH7uPTq66CxQlu/RaskY1O6KTbwBb7vR?=
 =?us-ascii?Q?zrKGFroWAuXo2HhZiRa6ZVCpDFNtszUa3Mxc9l+5D4DsRbaW9wOaWTeGQOjy?=
 =?us-ascii?Q?oeyDxKSBb/02jH8f8JyNjyo7bUxW+zQVQxD7mWipebsOQf7+u7Iv9LCJohOX?=
 =?us-ascii?Q?bY/HK+9+nB2VzDxAk0HYjSwlObQXA2VVLN8CM6VOVZatDKvhHqR2ejJhuMzt?=
 =?us-ascii?Q?AGlG8LO3w0LjepTuOzJyRjdhxDrQAKLq2Xri4PyrQ2auIa8cnYjufSfntfXE?=
 =?us-ascii?Q?IpuZijEDgs2lh+OAR3HDEsb3Z3eSelCUt1C/2FBlTRNL3gC4pcWQdsyvIdX+?=
 =?us-ascii?Q?cEXaWawL6yMxji//7s8l/FYjiP76wOwsHm5hgPOde562sVc0+yDaQ68D1W5D?=
 =?us-ascii?Q?xkvQnnlkNOyoo3YyTXGQkF4GuSsNqekGQEwpkjo1fnKOe6BU8RwRdOU+ZAjZ?=
 =?us-ascii?Q?LII5YEBiDpw7UVBPd50guTMiiZBt0Y4d0kP1QAQLYGkFqU21Ro+yJpu2JFna?=
 =?us-ascii?Q?HRUiOnlok8fbW1QRcUQ5FlIm8pvZx+BOUekNrO5qsHCQVBGENQhs45Wu4w5j?=
 =?us-ascii?Q?sInDMvfXzHCklIOmG48s8uWIdHEnQxVlYCvtN7Gax3kPDhJ56AQNekNeqgF1?=
 =?us-ascii?Q?EA22nKXWjv1UwvA1aAEQtya6nSJvkpOfBTQnpfiKC0YXHY9oYFpuE7XXuYjE?=
 =?us-ascii?Q?uWbWBR2smAQ1whq0+I26UQfpqdKxSOLkQq4XboL7i82j6+go6gCwWzRNUErR?=
 =?us-ascii?Q?pX1AWB/t957yaKMSoEX/LrgBw1GYGg9j8nTb81iFH95pLGke4Wk4qRlMD52N?=
 =?us-ascii?Q?POiUW1wsouNaW+CERy84gJn/oy44/D050dTcPIaAPcTStmdAiqV6n0fZtWLj?=
 =?us-ascii?Q?dzE08DFVN0OK6KMX+JDAffG65doPEmn0hZAbDOkxLpIoB303QxBSfHT9F2rS?=
 =?us-ascii?Q?3fsHTDCdAnHWcN6lZfn5mk+/2DKsKK0rcUvGUZcYkEG7EpdF2hkLVG2j0tiS?=
 =?us-ascii?Q?vcAODlVYohoE3vTtcX6JeMlRbNuTWn/kU8b5tFBngMNes/nNyws8EVO6vaww?=
 =?us-ascii?Q?1c93n+4C/Ex/w6Rs5oQc1S0nu1EFtgezUKTTrzEhH+GVeBXoWbr7Upu5Xz5V?=
 =?us-ascii?Q?kZ2uXoEso75aDuuyoSnX6MeKBMtWGJztn+zG7Uc5IMhTBD8ldM1HYS4Cth5P?=
 =?us-ascii?Q?lYBoidxjyZIvWrXkFZ8PNXhfdwREOpDjaJrz0aNXgiX+Xp9SK7P5b0nORI0y?=
 =?us-ascii?Q?Q+oTULqIZJVZa6muqyKom35cqRQzF+AIT+cgzpSOetYi+qzg7xc07wIgPNC7?=
 =?us-ascii?Q?9uqei7vEbknd3q3dwvdg1CM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c532685c-f666-4d3f-f112-08d9b0169d5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2021 13:22:22.4564 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UgCjmzfiCrR8CCcwXzz8qUyvGuQdqEka+Pa9v+nun6biUHHUrSJRQCKDcqFuXnaZk6DjHLE3urH1WWAzniShNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3177
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Use dev_warn to be mGPU friendly?

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lijo Laz=
ar
Sent: Thursday, November 25, 2021 7:51 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Limonciello, Mario <Mar=
io.Limonciello@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amd/pm: Add warning for unexpected PG requests

Ideally power gate/ungate requests shouldn't come when smu block is uniniti=
alized. Add a WARN message to check the origins if such a thing ever happen=
s.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/am=
d/pm/swsmu/amdgpu_smu.c
index e156add7b560..e0f8ab8be975 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -277,8 +277,11 @@ static int smu_dpm_set_power_gate(void *handle,
 	struct smu_context *smu =3D handle;
 	int ret =3D 0;
=20
-	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled)
+	if (!smu->pm_enabled || !smu->adev->pm.dpm_enabled) {
+		WARN(true, "SMU uninitialized but power %s requested for %u!\n",
+		     gate ? "gate" : "ungate", block_type);
 		return -EOPNOTSUPP;
+	}
=20
 	switch (block_type) {
 	/*
--
2.25.1
