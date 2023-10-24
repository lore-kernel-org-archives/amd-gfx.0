Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B01BC07545
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Oct 2023 14:28:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AAF410E3C8;
	Tue, 24 Oct 2023 14:28:48 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E040310E3C8
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Oct 2023 14:28:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lElLgAijl+pksI18Fgb36g/j06BCzbcdbyE3/ZntLC0YO/0HGhn2Mr6CoF3ZwQZBiKmBqL+8f+nzFPjWkvSgFHxEg5wyCQqA84Asu+lNAd3GkOmd4M/CPfFvGzo7l413cFnuAydUeLbi8BZCDjuba17xQHPcUzY4AmHEsmU35Jy5i4gQMl3CKMLPlGQuM5V8BcPgJl6gcbmjyKEdSG0XpRALvudTYswp9wR9raEFp1+Hcq4gWTuGLrrpCjLb5sBCcQBbhbOpMqGYIo9Nqd5XPBcS+E9uanGpyGjZwBBCwSpq1tl5lTTWP6KHgSzSr1b9rDXBPlLpd1YA0SrKefK2JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5xn3GEhXXb3Gq8mnDWsC2pWLcvom+fRa0UrldJoWM7c=;
 b=A+wu2vg0BwW6m2AEEaZogmZdP66xgjPOoNDITu5wqcdjY4cdkEpSeOi+EdjvcKnrWfdomgc/bfrxpA7kux3MAyshVb+q5r0dDwSLZU8v8TWxEQLoEHCNwFyObu+tadBy20jH9tBxKNi/wR7osM2Ry4W9v+7buU30byYZoVOx/9x1WNfHtjSeFRFuf0tnHoD0gxoY3j9hQ4p6Hl8HjK9bHkV+5bjjealXAsn6BXhlEihATr0pb740mGXEBLkDn6t+Te3Wxi+M85yFqw4CFYavRnUZT27OWVSXZnBaHWaUwpJXGKAYmeWv9OPSILRJDqCOvpK+gDb0ZGvgEgXUHeSbRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5xn3GEhXXb3Gq8mnDWsC2pWLcvom+fRa0UrldJoWM7c=;
 b=rBzwQSGPQqUvtxN/AhUzXsW0rQnI7VdanqKOA1ruAF47aRgWl5UiItUEIJGpzvAgU8kdwSdL/0B/YgWhH474VOHI4JAiAVIyagz1JOCVvIHb/yjT2A9mIhCNUv6LE4HSjeqw68xqW4iA22D46rVhFS22We97jT+GBq6SSEUs6Z4=
Received: from CY5PR12MB6369.namprd12.prod.outlook.com (2603:10b6:930:21::10)
 by BL0PR12MB4883.namprd12.prod.outlook.com (2603:10b6:208:1c6::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.29; Tue, 24 Oct
 2023 14:28:44 +0000
Received: from CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::9b2f:2ac9:bfd0:589b]) by CY5PR12MB6369.namprd12.prod.outlook.com
 ([fe80::9b2f:2ac9:bfd0:589b%3]) with mapi id 15.20.6907.030; Tue, 24 Oct 2023
 14:28:44 +0000
From: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
To: "Ma, Li" <Li.Ma@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/amdgpu: fix the GPU power print error in pm info
Thread-Topic: [PATCH] drm/amd/amdgpu: fix the GPU power print error in pm info
Thread-Index: AQHaBmqPzwDCL/V3QE6c9T3UcZK3YbBY+RBw
Date: Tue, 24 Oct 2023 14:28:44 +0000
Message-ID: <CY5PR12MB6369D44F26175EBF65A286EDC1DFA@CY5PR12MB6369.namprd12.prod.outlook.com>
References: <20231024110904.281991-1-li.ma@amd.com>
In-Reply-To: <20231024110904.281991-1-li.ma@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=3ca35747-e9ad-4540-9740-7f0b121d4e66;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-24T14:04:05Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6369:EE_|BL0PR12MB4883:EE_
x-ms-office365-filtering-correlation-id: e19b61a2-05ce-4a28-9e47-08dbd49d8757
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hi8OC/VBUcEGzUUHOL4f/LKIBeBj+9UdojNxBHslanObFPWZSYDZnYXpB4ap+dk3cLQHu3fTaN8NU2aPHCjvfBB9M9MhYtmL0VbAcnhu78YZ8PFBrFXOIhmpaSEkU5Y+xD9N49vB1xnbaivhVLG2bwIJctgMRHmhtqudWuLIIpfxPrJcr4ja8657iU9NGohRHzLiHtxTJJaXtvGNC5J1dkza5Puzqulf+HNwhlcC6zGIiLmXLplpwxdeY9BHvXWDswuU7DX6u6jqGNwZTJSySN78tCBTJ7ZyB7Pf9xaAJrxJE7AV8AA04eLvl4BZgjm3WSen0a0dl1W0xwsum+I5HuRjtlrJ/IHn9L7rzX7KyHt+a95lqi0L+Dr+S4lhGZcE3rl8aSCb8mVjiANi+/WIEQac7qTDtEfP+fxtrpFkDcXVLil2W6H1WWd5hgbkcf6zR2EhP6hzu/zof1NqxpadUwRQvNDMfDzNcblXDoyWv34++bJhe4rkW7OiE2gWXvsZgc3aQ9YS43QN/XuwCs1FsojTDU7QnJxSSbNlM2YFv/vrD46f1WgAXOTxjI/Ldj6FGjquT0DFt3GmzF8DcYszmAk+KlmtW4tG9W3sacl/PFo0xqUWo/ToGKkBIW9KqIKc
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6369.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(346002)(366004)(136003)(376002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(55016003)(2906002)(38100700002)(54906003)(122000001)(66556008)(64756008)(316002)(76116006)(66476007)(66446008)(6506007)(71200400001)(478600001)(66946007)(110136005)(7696005)(9686003)(53546011)(83380400001)(4326008)(86362001)(41300700001)(52536014)(5660300002)(33656002)(8676002)(8936002)(26005)(38070700009);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7HVtgkcmX/h3VGLTxKpmHJSAlwTp3Sv+SKASB4IyQiMiDg/MUBw8wPUuXoDo?=
 =?us-ascii?Q?2itrZZkMrYJejToxDztnK+2Jk7d1WP4NYPGhmpamjCLmprLspfDTWZi/56Ih?=
 =?us-ascii?Q?6bp4UJ51nkd9HKuOMICNIdm2ct1U4LlkFWEWr51M/HAd8gg6FT1RW5zfQo5L?=
 =?us-ascii?Q?1qA2fQRGbrjdxP7XcSxJIxwFiC4Fn5ABJ8LZqeNrG/VT4DAQ/2ZtHY53wJux?=
 =?us-ascii?Q?Ar5If5DczVA+bw20XUDILDnwPYLpS6VSLNW9OO3sCEiCS+GGwgcmMgureK+W?=
 =?us-ascii?Q?uFT00bpK7BJDjkDo6RlO2CqCskGZfDfWU31Qs9+6U2kqtVQPhQABq71aN7i8?=
 =?us-ascii?Q?kft9nSYVpCa+wRCMKYwK5la26So9XqF+SDp0+an0l67aFi42AqAIJuWMCQU9?=
 =?us-ascii?Q?m+wsvj6YtX7KP0w6uAlqMrGi5Ou5y9Fi7J4f56ye6fT8MUm7SVn/yAuK5EfG?=
 =?us-ascii?Q?GBY01GAN3Z6kLZuO4o3UaYnYBH2lozbw+DlxO3sR0sDC7olbPWchFXfrFFFx?=
 =?us-ascii?Q?/q527QQadbjHK+thYX/sBYDonroarSMy6gYYmajLHqz5zr68cQVX6nsx97qP?=
 =?us-ascii?Q?3q0sAy31fWhZ4XoDUKauOtG50vcEEqIn4vcZW7hW92and4i/Fptss+CuiR1b?=
 =?us-ascii?Q?+5Mf9+SJ5wE2I5A+2Cl3UW7FdHlJFC7VqLCSfCNJVe9ZJPmWpHphBMB3M/x1?=
 =?us-ascii?Q?KG4GVCFRhqOKfKeju+WEP08SnLsajtywn/DQPz1EGgMAX5TEAr5aMc4xqX/k?=
 =?us-ascii?Q?A3KRbEDyO4jFQRmarBV9+9AljW0UeCJhjuW29NARbZRqDQOEbIv4VDdG61V3?=
 =?us-ascii?Q?QsSuoj6gqaojlVFCvDOJgTp5UClKaaKNb75TxEKiHGOiXQ1SyEMKQBuC6yRq?=
 =?us-ascii?Q?EcgCoyH5yKs2gLlWFW50v6tjqqcdOuW3+tQPr+a+xNpwKMjX41JEb1eQ1L0E?=
 =?us-ascii?Q?JofMcmJtfppmK7IXz/6MFAcqJsJl6oBt4cKFGE+vZrKIOrCF0JWG67wSFlmt?=
 =?us-ascii?Q?Qhce0/QQOoj19tm4+WbdRmmLJWVZNwVzRExJGdoBzgOwSMrkw0jC7CoVZmVN?=
 =?us-ascii?Q?VIzcuqTAwHXW7r8zSh3OgZS2k8LTP4OAunt1tniUY37/tX9kieM322xYLzrs?=
 =?us-ascii?Q?DGEghxDo5HJbBT2ZBEh/nuqirVpLOzaQ47PnRbG4m2xXXpqaROtebxL0a66Z?=
 =?us-ascii?Q?Y3mNYvBJrWVNkRh7FzgZO6K2Yo20zookuAeHaZKfs4zchoNwmBOirUpUZkxw?=
 =?us-ascii?Q?WSVoTu4KVrPTwNqoo0IeuOuIZ1F4XTr1DOB4sqWoHVUJGViYfItS6x/OxJG9?=
 =?us-ascii?Q?mqO2/7oKRsBfnve9uaKtTm5jl2rGjJL5sqJoDFa7VQl4aME1BB9GO8NMJE+a?=
 =?us-ascii?Q?SnkYSwltZx5T4DFD7XKYh3fIrQ6tduExOlEv+4Z5G57cPPWaeZ5kppOF8g40?=
 =?us-ascii?Q?EYoyOWn58CmuX02rwg2p6Ku9cFREm1QPh1CacoOp10J17lmJi149/mRYUEMW?=
 =?us-ascii?Q?ThDkOQ5iB4Z4+sKbUxD5NlnJ8mMkilBSZG8GmGtPfq1Py/mfyqXPHdF+uwxp?=
 =?us-ascii?Q?wdGkcw35eLR5o0qbEK0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6369.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e19b61a2-05ce-4a28-9e47-08dbd49d8757
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2023 14:28:44.8285 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TEEA2E3OUzYEyw/1X19A8g1Wcmhj6wmfFG60RmLqzT85g4Fm8AEJmSrIfZbI/pV0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4883
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "StDenis,
 Tom" <Tom.StDenis@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

-----Original Message-----
From: Ma, Li <Li.Ma@amd.com>
Sent: Tuesday, October 24, 2023 7:09 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zh=
ang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; StDenis, Tom <Tom.StDen=
is@amd.com>; Ma, Li <Li.Ma@amd.com>
Subject: [PATCH] drm/amd/amdgpu: fix the GPU power print error in pm info

Print the digit of the fractional part individually to avoid carrying durin=
g display.

Signed-off-by: Li Ma <li.ma@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/am=
dgpu_pm.c
index 358bb5e485f2..cc853559cf0f 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -4290,10 +4290,10 @@ static int amdgpu_debugfs_pm_info_pp(struct seq_fil=
e *m, struct amdgpu_device *a
                seq_printf(m, "\t%u mV (VDDNB)\n", value);
        size =3D sizeof(uint32_t);
        if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GPU_AVG_POWER, (=
void *)&query, &size))
-               seq_printf(m, "\t%u.%u W (average GPU)\n", query >> 8, quer=
y & 0xff);
+               seq_printf(m, "\t%u.%u%u W (average GPU)\n", query >> 8, (q=
uery &
+0xff) / 10, (query & 0xff) % 10);

Would you pls elaborate on this with an example ? it looks to me it makes n=
o difference here.

        size =3D sizeof(uint32_t);
        if (!amdgpu_dpm_read_sensor(adev, AMDGPU_PP_SENSOR_GPU_INPUT_POWER,=
 (void *)&query, &size))
-               seq_printf(m, "\t%u.%u W (current GPU)\n", query >> 8, quer=
y & 0xff);
+               seq_printf(m, "\t%u.%u%u W (current GPU)\n", query >> 8, (q=
uery &
+0xff) / 10, (query & 0xff) % 10);

Would you pls elaborate on this with an example? it looks to me it makes no=
 difference here.

        size =3D sizeof(value);
        seq_printf(m, "\n");

--
2.25.1

