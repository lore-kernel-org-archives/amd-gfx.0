Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72785CDB47C
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2026 03:08:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF22110E143;
	Thu, 25 Jun 2026 03:08:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rbXC5/de";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010045.outbound.protection.outlook.com [52.101.85.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21FD710E143
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2026 03:08:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RrOLSBKDXGdmktfnOElJsChVGeJTOSK9IBKzcqRHP3YwPSYtrSkyszQ7FEAA+Durr5wbjtWGboQOQPbA3FdRUTVY2wCK6JP0hv/MNi0DuNUYbhfHGiWcLQHf5XGmkTW2Envpwp+RwKgXkaZ+3ICwzAVfZt8/DJQWrFVIVowcF80xaqWA/rMRXyGfLd4euoRkuTIpY0RV10DJH4xs9i/+DrKCQ+lZXgfMLypnUI5ZnRwN+yZa0Hv9VCA/HJsvuFOKglUIkEvMOuNs587W3wRHcwp+35XJMKv9zfMnHBfe18Uf/Fmanfww7Dn5eWBm3zxzMtPivvsZGS4SsTsFYCJzFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sr5guB+oidVwLW8iJrji9saDoBGWdMRVD4hSUWWMIXk=;
 b=S6mU9thGo/hjrpt50ws85A01uwRUQ8UoChnSQfFuOCVklNYdAqwDXrzUnSoE034JBNu2eMm8Zf0EnAf9xzS9zgyVcibq/Dq/LMlgk5wO6WIjPAoko8ZwTY6Lo5dPtwyOMNxT21fAyaivX+Q7NKLYLw9bz9yJV+nQRriCnupAH2uoV9VIXX0Lc5QX6z4yQOWwMyMBPBB2WyJrpffW0w4aUXvVjl65gtVHb7VUPzkozOTvFcfkTLiVSNxWzRY4gDc1kOeHTztiYbWqxkONoZPVaMAsqVBJxMEwVKKPqe3mOvdozngXUmauQbtIy/w0+t4+YmG3QB37UINX9819iT8jlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sr5guB+oidVwLW8iJrji9saDoBGWdMRVD4hSUWWMIXk=;
 b=rbXC5/deINnaB+6sBm0r5/ITiOlwXWBEx3VcTb8wd2Ey/RuZTn13bq1P7uyiD55uib8IHf1xvNw9d4h1ueAiACMRj+jaSI58c7zJU93jUCD07oKAVMFw8KdaboiRDOE6+YA3ZXN0snyN2vfrQ4vJmpAUxk2ONRAkK+kcChhC2mo=
Received: from MW4PR12MB6803.namprd12.prod.outlook.com (2603:10b6:303:20e::10)
 by CH3PR12MB7570.namprd12.prod.outlook.com (2603:10b6:610:149::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Thu, 25 Jun
 2026 03:08:29 +0000
Received: from MW4PR12MB6803.namprd12.prod.outlook.com
 ([fe80::c193:ef2e:260f:dcfd]) by MW4PR12MB6803.namprd12.prod.outlook.com
 ([fe80::c193:ef2e:260f:dcfd%7]) with mapi id 15.21.0159.007; Thu, 25 Jun 2026
 03:08:28 +0000
From: "Feng, Kenneth" <Kenneth.Feng@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Fix SMU v13.0.0 current power limit reporting
Thread-Topic: [PATCH] drm/amd/pm: Fix SMU v13.0.0 current power limit reporting
Thread-Index: AQHdBE6xZr1MWOQbPkyHeZ8tUvSGIbZOlwPg
Date: Thu, 25 Jun 2026 03:08:28 +0000
Message-ID: <MW4PR12MB68039BFA4F03B4196FCF68098EEC2@MW4PR12MB6803.namprd12.prod.outlook.com>
References: <20260625025933.1558864-1-kevinyang.wang@amd.com>
In-Reply-To: <20260625025933.1558864-1-kevinyang.wang@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-25T03:07:53.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR12MB6803:EE_|CH3PR12MB7570:EE_
x-ms-office365-filtering-correlation-id: 9e263fe4-ba03-414e-1083-08ded26707b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|38070700021|18002099003|22082099003|11063799006|56012099006;
x-microsoft-antispam-message-info: TEjWjL98uyBzrL4NDpRcHYuczBgK3eryAHOeJNrrDOaJoNNAd6ujthJfIHYRI15gzzoOgOY2ty06SWjdseXaVN9tUkRnC4no+EMU2GONgnl1Y1Y73CFJQyH5Q+4qwu0XPQFcNeg+nG1DEbbb8LcNu+t5yzr896z86PWkep29OfM3qDQYslov97F7NHvccjomaixKOVNY0dsCS41D92ahvkKe/63igclWPHVbRXb+ezNVLCs5punLRtznZfkCWYVlDaC5P06esdJXnYzRnDCCrg+7LmBMxw73OWXc1NPErDxGjJrguchOd5Kl9OdMj67i8FY0EJkWAuCV9xvCaYG+Qjl+MWeeUNUcsAjd3ucpQ3nJUaFbT3KoYX7rmwxY6WGy+mHqDlP4tKtE8r6Nc12HlGNNkxvZs2e4O6o7d923ryLztkDasNtBU1auxDxypFbLn8JkkOnybM28asm/Vk/xcKFjGGX5VgFohCFxWoUDycigRPbf2AMMpC3HwDQHwkcMXcxrNddNR7y1tHqW2/btSh88n7mzrlu5CfLo2WFnstZaNV4AdMOUjMPXuVPpPZLH56gF9d+ObgtMfnTDPY4DjUX+7ocO48DiWjmorsdTDRrFnxNAB9p0dONKKHQtX+Fqq+Im98zMVmMhHwFVgQk3FQhNwjg/kr+o49m0YviC99rUpHUd6KU2mvUV6RtV6jdaQHhYRQ2EEDQB3DpbF3gREw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6803.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(38070700021)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fs1CSzpY8PmeMn+nIVEWW7ch8NolzREIMa3V+tPCy0Na0s454YLTcO/0dO6v?=
 =?us-ascii?Q?vhXnixTZ3KPZi/gp1oO47Rz4aHB6UqUADxbcl0cUUc5OevX217WNyx6Gyj3r?=
 =?us-ascii?Q?FXRMA0XJmOEqPKGUXVtFmm/+Z9ReNJUi3uqNIU1uXAfsLHZ6T35rCTCloo0a?=
 =?us-ascii?Q?L0sEU5TfsBiWuzhZrLDosOrZ/2WMB9UBq/Rb3pfx0VJZshciFb/BcuH+3hKH?=
 =?us-ascii?Q?0hL41VXyZqW0hM+Rut7NqB5XqQoP45+NjjwjV3yTrHEqPSAc4EoWsOgBWxyY?=
 =?us-ascii?Q?WMEHeiDEnO7HemxaIH6d8qgWUGSJoa2Sb5+C5WT8W0ukhjQSsRholWQdC+Qk?=
 =?us-ascii?Q?PByonCZZyTlrwp5wKJH1fzzu97ctd5VMrXPAnlgcqWdUKyyJrL3DihKqQiuT?=
 =?us-ascii?Q?L6NWHpM93ZHhcXZCL+xm4weSNkxMToCAIRSm1GlJyxAupS4KZGMVyqxTqSFc?=
 =?us-ascii?Q?VKUpRZ+ozUJc7tqTCXvokmQIumaAjWOp14pwT6v8P/MzZLysw9aeKUhEOqLF?=
 =?us-ascii?Q?RnMBNiF4fUH3OtJ/4a2ChI/B/JOosg1SrOv7LtwCsesRmB7qIsezkOJj4yub?=
 =?us-ascii?Q?mQ4IPLgZeNQseYs9QSRi88KVI1RrP3ogmKolzv/ns7NPtkOWKTSKtQ0mkw0L?=
 =?us-ascii?Q?nuluoBSg3xvkpt4NrwCe3LffWt3nBZnM/OBm6cK9foMCWNBcQhzz55kphefa?=
 =?us-ascii?Q?KWO5lEAziLmZsgbdgkxqRT+0Dsv0SzgSqBKD/w7iyy1dfH/6BzGbB0NN9NRS?=
 =?us-ascii?Q?WVmv+8ssSboRHmveyQ2Ya1wTzcfgHItrelw3QB8ITHRnbwshLGKseziMTkCp?=
 =?us-ascii?Q?wLtQzFaij8UhRXZkE20jgFjFBEMaxKAB6cpKsPP4wX4H9z+cvBMWE1HY1qw7?=
 =?us-ascii?Q?1/tM8UwEvBR77TtjogLbK6Ooa0oAh/iWIHt4ikNV1Nj496oeY8zAZAjUJv56?=
 =?us-ascii?Q?CC4P0r5Pvb6mPOtBPA39i2CEXopCzgL5ys38iUXjZoe/WAuA8jEUYspTbUrg?=
 =?us-ascii?Q?aBoo2Ql44u3tuP4Z+KPQxMU91JRFlBaQ8hkzZ1nfKFCFlm/SfTe5M97ShFJQ?=
 =?us-ascii?Q?KQDBWNrhEBCaSKswRBzwhlHrHQxKSJ1VlYIK3xP8x2nSdLLyAgi0n2/mjYag?=
 =?us-ascii?Q?V+uNHlJhpsF6n3rsscVVC0A+5rSh1ldxRqjwapUtrsz73ezMW466L8mu5X8t?=
 =?us-ascii?Q?G5VWzO9Ohok5i+y90+yoHDQcxTey+01SWhogUFE+1ulWLySOY0uAHHiEzpLs?=
 =?us-ascii?Q?Q3uTock2vC/XBPgPspXpBNUpa4SP/9WJo9Mxx4kxPVdkIadhcQxprk+1ljrB?=
 =?us-ascii?Q?w0da7ZexqGL8jmdbKJzfXAFEunFWH940JQq9LC6qyc84Mhx0tiTE6RDywQBP?=
 =?us-ascii?Q?Oy6KybsrM5hkI1BEpxSb9IIQaM4RvxKoO71LWlxOeO0c3R0ThRgJHyibTVhJ?=
 =?us-ascii?Q?Ovndp1+IN1BopRd8avA6+gPSW4rzlXZd6oo7BVKv29gxjQfRkGArPaG4c9sh?=
 =?us-ascii?Q?P/f579B4koYXhzVwHWapNMZiC6oY8ySqh6aGS4427gAQOiEuX16tNsUJbcKE?=
 =?us-ascii?Q?vmLME1v7lz+Y//vBMN/y+mY/vH9iNOH9uK2htwXJtjH9ceybdF1KtLikNYTD?=
 =?us-ascii?Q?PRnhrH8FiaoTSMcP4uYR0/w/s18S52gKKoKy5i/OilCAWDqas3iHJMBHiY7H?=
 =?us-ascii?Q?perJXT+wzfmzmQIutZ07a6wJoNNvx48QbTm8lMQdWVm5LWKs?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6803.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e263fe4-ba03-414e-1083-08ded26707b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2026 03:08:28.5191 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: unTnPEvrFJ89nSZg5ny3yHLljnlniBH4iJxUDpLSpe+KJDHwQBG45hpXJQ5M6O+p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7570
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

AMD General

Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>


-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Thursday, June 25, 2026 11:00 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking=
.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH] drm/amd/pm: Fix SMU v13.0.0 current power limit reporting

smu_v13_0_0_get_power_limit() queried the current PPT limit into a local po=
wer_limit variable, but never copied that value back to the caller on the s=
uccessful path. As a result, callers requesting current_power_limit did not=
 receive the value returned by the SMU.

Fixes: 8c658297a4db ("drm/amd/pm: fix smu13 power limit default/cap calcula=
tion")
Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5416

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index c984dce48310..19ff9b14e772 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2404,11 +2404,11 @@ static int smu_v13_0_0_get_power_limit(struct smu_c=
ontext *smu,
        uint32_t pp_limit =3D smu->adev->pm.ac_power ?
                              skutable->SocketPowerLimitAc[PPT_THROTTLER_PP=
T0] :
                              skutable->SocketPowerLimitDc[PPT_THROTTLER_PP=
T0];
-       uint32_t power_limit =3D 0, od_percent_upper =3D 0, od_percent_lowe=
r =3D 0;
+       uint32_t od_percent_upper =3D 0, od_percent_lower =3D 0;
        int ret;

        if (current_power_limit) {
-               ret =3D smu_v13_0_get_current_power_limit(smu, &power_limit=
);
+               ret =3D smu_v13_0_get_current_power_limit(smu, current_powe=
r_limit);
                if (ret)
                        *current_power_limit =3D pp_limit;
        }
--
2.47.3

