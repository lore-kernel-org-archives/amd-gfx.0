Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13F50CDB479
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2026 03:10:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91A6D10E155;
	Thu, 25 Jun 2026 03:10:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cGBbRf7w";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011021.outbound.protection.outlook.com [52.101.62.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B79E810E155
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2026 03:10:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p4B9yFywvttrH9yJ4gfnAIe8RONhdRHSpLqPpCohbpJccAJg1+vpXtTBaTtg5SXfiPX/RS78A9CDuuNuH/P6t34/2h6cDaIfmwJfW/xZQvu5gGrtORI1za0dMpgkdTUHYFJkdV6fgevDDhPQ/7S7GsBvZiMiB8fGf0bY5cmJpl21AQaujQpd3S4uWumJoBHAIbCtHeopvQh+vHQuAYPpbyoFk5dnJiAGYhOdrPo2xEDwM6BIlU7vWZqnYI4ri9GDK0jfo8meBq2VqsvDNLenhDF63PQw2JSzQeBnT3Q69A2NymFMtOaDIZchEbqOCXuDpRkVrmRkiGXpxHRVSWAxWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=umuet11Ss8+/qXxc0INJgFa4LgS5NuFaUQg+qf6drZE=;
 b=q1RYrvusOmGxsGkGbPEnqxBkf/P4xG3tQqkR5MmK0tiLd8KH1cNjZNQltaHrPoYYL+kB56xGxV5pt8Iz6++zDS96/CQYaJ0N5jqNjKXASglpdxTqbUr7nap+paadSMT++Y1731sKyTp1UHLsc3HXY+g61rPIcN5QmVGkg0FtHNcYW/vDayP/LDXzC6lwoYWExWyu2weRBFA0Z4bhN5WarIGGW9YcIwF9BOTuqz07xuinTUyfJfqFwuKC3Gz6hcfz7IqXWWLLvQvBE8J7tGV68RIYrGonD5bGAltjHKQvYywAi3QdAVnw+jtfXG0NrYc3MPBvLPvpX+uJO0CoIv/4TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=umuet11Ss8+/qXxc0INJgFa4LgS5NuFaUQg+qf6drZE=;
 b=cGBbRf7wjcMRerowRRT1/UBrbQqihF4bvdCu3IDLocm6biGl01VroYcLU7wOFd0Pnzc0xqCUUk92v8/2RX1q4yI7ITCDOzZsagrnB/pmTo9FE8xZ65/B+GsJw7A4L4OmsTFmfSfGsBm50fyof23m/KO3m1iIAkdPAb0q+4nVkNA=
Received: from DM4PR12MB5038.namprd12.prod.outlook.com (2603:10b6:5:389::18)
 by SJ0PR12MB6968.namprd12.prod.outlook.com (2603:10b6:a03:47b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.15; Thu, 25 Jun
 2026 03:10:50 +0000
Received: from DM4PR12MB5038.namprd12.prod.outlook.com
 ([fe80::3c29:3d93:2028:85c4]) by DM4PR12MB5038.namprd12.prod.outlook.com
 ([fe80::3c29:3d93:2028:85c4%6]) with mapi id 15.21.0139.018; Thu, 25 Jun 2026
 03:10:50 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Fix SMU v13.0.0 current power limit reporting
Thread-Topic: [PATCH] drm/amd/pm: Fix SMU v13.0.0 current power limit reporting
Thread-Index: AQHdBE63lPX3aNvcW0yGcZEU53hx+7ZOl83g
Date: Thu, 25 Jun 2026 03:10:50 +0000
Message-ID: <DM4PR12MB5038D88A7A6FF43DEE63A5BC8EEC2@DM4PR12MB5038.namprd12.prod.outlook.com>
References: <20260625025933.1558864-1-kevinyang.wang@amd.com>
In-Reply-To: <20260625025933.1558864-1-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-25T03:10:43.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5038:EE_|SJ0PR12MB6968:EE_
x-ms-office365-filtering-correlation-id: 1d76470d-b328-43a9-ea89-08ded2675c18
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|18002099003|22082099003|38070700021|11063799006|56012099006;
x-microsoft-antispam-message-info: DFWB7Qdw9Y2eUAmWDmn4B3zfRrN6zWfw/8g8npFU3BAu0AxsHcmgkI5+xAnS1vOFVUZggUzG/QEtm3+uqnaMvtSV8txWgpYF/ZN+ETlRJ6JQ6u8uCOwIXbplqYYWnaVYZDWgqfQ5JZ0QzncB8rMEHTwe0qzkGZVqpKeUNI6SG1Bn/eaggevKkWs0FnAAadYiWY2ZqQc0I6HvAcN1qY5lth8aBtu9QTjZkrnn+ocs/mQc+/yOwPqJilFTGz2DSYZOdKIWq3Y1ZmlFUgYilQABpN0Ll8VlekKt0sQP99aUTaHCPSXavEkgGjcuDNT/pXJQqO7B9OV9T3V+9ykkGmvElUqGTFex+7FpSqFLpMPiZknyRsr/osoBef2rP3fg0d9HSejBVb/xRexSviXx8tyyyMk6E1H3YeqREiQ/mCrXS6tb1uQ4RtAlXBNMzHpBU07AgoBH5vS3icT/+/0yCc2jHBZi+yRH6Sz1Wh1kfPZrOxItfS+pz79xI853V74ZJurYjNgCZE+17O73RHHtXnb0o6bk8wkoScV0LN4SbPYrOyX8eRaDCi7htGaOo+BdOj2CCjvVp9eZRrwu9l3XWqniplvtUfMHHZBGX/KwudUW2OMvr5hbeFEa8r13Dj7uE+H+hd9BJ0L+qo37wZVTpkcGyZlRgUIiTfdiEV7fKiASWf8hwIKq6xQ/fq2od3jSgydNQpLv+e5yOqegiLt/b6FySw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5038.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(18002099003)(22082099003)(38070700021)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PKggmJlUA05h6ICrGTC8LxllVjYpWCBpAYhHn8lJ38qjFzyx8cIpgxSkAy1o?=
 =?us-ascii?Q?/yVa4d8HFwV0joRw+9WXKfnIyldVKW2vKxbzsnsBRCsOLpxB/8JtKIFVCe3H?=
 =?us-ascii?Q?HtUYLniTB5em5DYScoPnJiMOJfUZfU77cWMjVGa8HlN6zTc852JOo6urUcgw?=
 =?us-ascii?Q?CfLnvsk2gehoXu2F3yuqSFtRR6uXyB4Nfo3oTeN5ZSm/P3+fXyv6HFGEh7Tr?=
 =?us-ascii?Q?/+Kk5/TTgu95haIJmBnVi48QrwozapeXmsY7nkIMvjdfWjnxl6R5MyQd4JoV?=
 =?us-ascii?Q?DFDIyuABCUSiN3U7JmfBugtt9QiUh5G6XCs+UiiWaExQ1uso1b6qy0lsF1sk?=
 =?us-ascii?Q?J5ZefzzA68uTp1QRWvzDfcls1nINQeyXQRZHWV/CQzuTEAcpSHQw96otF9L0?=
 =?us-ascii?Q?IQ1Kabit9JGkoYIcUyiblVi4oBbq4TSue4ii99PlSI4mAkDWF4EhzqTeqQRd?=
 =?us-ascii?Q?lwVPU2d96k6PZxPa72dLw7VWCi9RqBG6YM5iamwgoX8lKiCsIxFm+p3o/5gm?=
 =?us-ascii?Q?msWV4s3U3WkdHtKhbsPyrNcL76Z1Z6D+gcB13tkEUDDrCe/EFbA5AV8UM9cI?=
 =?us-ascii?Q?0JW7BKOVl9QHXx6bVw1XmPq8IRWzkCCBR1HpLwfwA/tbxAD6C/p8pcSWgCKV?=
 =?us-ascii?Q?qe026/f1SIa8mcka/DqOIZE9XW6incwkd1Ziw8joDxdu7Dc8Rj4/wvxVlnza?=
 =?us-ascii?Q?FCd2CliCT29okIBqM+7ZgKHUeJAiuhaAyi8naZtEaYUKBzoBIg1CRXVqZaGQ?=
 =?us-ascii?Q?2wJzdnM152hwEWBUVCkpitNSwn/kxN2ZHMbRw9il7sAhCRmmJbIimDRFW9eX?=
 =?us-ascii?Q?BswqZ14CyAmyeHjo4WW1QRL574c6Wxqhl1tYtqKUKX4Mw1oy0Lma7fjTExte?=
 =?us-ascii?Q?/sW31JhH1sz+qjMfknfzG4b3UX5LwocY5JVy/wSmmfF4nHOd7Xq5e3rTyDBU?=
 =?us-ascii?Q?+6cItogSHFs4fKTj0u8gDNP6kVJCyFK512b8I/acWS3IDv6kCJ/dtA60fwrY?=
 =?us-ascii?Q?05MmxwPe8OGHUovalWMOSB23sJ2ktlEoXHpwS/svXKUaWocD/hQIEWYhK8rk?=
 =?us-ascii?Q?wzYplhJqt5uur6m8pY/9FFr7SzHGLk2m0rFBD+zTri9u8UeCFWg+HhV+kp/t?=
 =?us-ascii?Q?EOKXs3Gz5IPOMzy/Jsw4dvThaHsh0DdApgSpvHHOEheF7HOKQ13J5QSBQQrW?=
 =?us-ascii?Q?KlSSMwdzc9JZfhTBxiKLDU9KrueAdxwc/Jh5uqVRhDgY9jyugsyILC8s5Xff?=
 =?us-ascii?Q?iDfjToX99dFyogd3+sv1OnBFv6q/1TcYwfxESOzsJx2hSJ2oXsJbbsfIoQIV?=
 =?us-ascii?Q?HeSdn2Cishdx154Vi1KeBGs9rHSgioJXBn+hHglt7kyRKgHQN2IWpz9T1YgS?=
 =?us-ascii?Q?vze6G1sTdua5FYBjWxzukwF3unr2X14gS3Ij8IcdyzHah/Tmmt5rWJAMbucE?=
 =?us-ascii?Q?qDyOj7W0PDH2mPq8OYHJxlndieDwpAS4BcQ47DVU0OPXPR740q6fAXG6W8u3?=
 =?us-ascii?Q?3MSJtVr8orR9i5ecAw4tEhLVqf8Bim9OEfSt+GX69lCpssxhQgoaHtOAxeM6?=
 =?us-ascii?Q?u/QtVoClXucdgyZ/D9RVdi3jqiT9hVvNaI8KNyT/BYa4Yf/IMiO+celb336e?=
 =?us-ascii?Q?qTfuzSrZr52lH3Iy3j0M7qJrVnVlH3rWHE/fGgGQciGmW27WDBnefcAT83fW?=
 =?us-ascii?Q?BebpXW65BjD1tmOIQus76vhZslgAdIRf1qgHcloX9HsDO2R9?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5038.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d76470d-b328-43a9-ea89-08ded2675c18
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2026 03:10:50.1495 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BGyARVGzMa5LOKTk8qczpac//JAstNNdzhw3VJ52W1DODVwQ7c9B1vK+D7DOh43XsKVt2MsVPb//mwUwrwY1sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6968
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

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Yang Wan=
g
Sent: Thursday, June 25, 2026 8:30 AM
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

