Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42988C53200
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2026 08:38:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D107110E5EE;
	Wed, 29 Jul 2026 08:38:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Tf5+KwUG";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013017.outbound.protection.outlook.com
 [40.93.201.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0C9510E02A
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2026 08:38:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IZh6P3WkXtk7vKOwlYSUX/f9gMaK3qlnTowVBYv7WYg4H30yFhpOJdVWMMAzTmZn4Bb0CdvzoBtJc6bVuM75CoPVIXC+a7511DXmAimNOSofWoegj4BF33WRaG1oUyNlCrGqDeywsJaBUlpzMov7JQxVbGmNHMHwvRUfugVnvPccGz0GPEVF2+EebSWw9mL2cH+LKs+Etk7JBbf3TfEiQ9Hz5hyBptSHvZ40kXIhulmxTbaSnO3dQakIPN0pnEK+/IYJZnPZWOhINnv76nzy5nggdqVJSRd2lYY/zhmvLp4HlLu1ws74OPpbNnEcnHkDZp3AoeWPYhbgv5HfrJz7xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ZZhSs0E7XUJw04Zo2LFMLIFb2bs/Dz2V1Y4FNnkKWI=;
 b=wlQ2Cj754L/ysanCxDr2tghKceFPHLaWbOUWzWHF51pBIa8h5ePl4v4gUnxL/KYoRck/UajDk5LlqKnSXe+vZUEXIJChv4UATNckNBhVMQueWXJobXJ62kKfOj6UZNjg5WTfABxy5tiYaBPWn0CzJOQ9d4aGPBXMOuMYP4x+/VJLxVNsVjmfWs2etDH4rAWK0s+7l9vXm3wHju9MKL1zjCzVOAuAwQo12bhwY9WRYdx3EevOxxc+9q1zgnrPxVdiI8fOrxlXMopyPKJbnxiJ3MsNtIirrxkMOGGmdR81umwmxzUmK9vISrKUJCOvcqTVZbLa6ZeBgzo09/gzJyjcVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ZZhSs0E7XUJw04Zo2LFMLIFb2bs/Dz2V1Y4FNnkKWI=;
 b=Tf5+KwUGUSBuiNYSUHhBsCsbFkhyYm86xItE4HzE9JpkNfauU9Pp7TPNQAqyuIXk6Ev4u+BXzM8q18EKzOvhBDEa72OsnSF5GoyFp3RU17uq9zjueElF25uTwTgNfvlA7eKo+e0hUXUxQcjeIQjie4UKQR9zjZ82UTCqXlVyBC0=
Received: from DM4PR12MB5748.namprd12.prod.outlook.com (2603:10b6:8:5f::19) by
 SA1PR12MB8698.namprd12.prod.outlook.com (2603:10b6:806:38b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 08:38:42 +0000
Received: from DM4PR12MB5748.namprd12.prod.outlook.com
 ([fe80::6c62:e99c:480d:2729]) by DM4PR12MB5748.namprd12.prod.outlook.com
 ([fe80::6c62:e99c:480d:2729%2]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 08:38:41 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: RE: [PATCH] drm/amd/pm: hide pp_table sysfs on APUs
Thread-Topic: [PATCH] drm/amd/pm: hide pp_table sysfs on APUs
Thread-Index: AQHdHzS1SZbf+CyvC0Ok/DRbvaW8w7aELOHA
Date: Wed, 29 Jul 2026 08:38:41 +0000
Message-ID: <DM4PR12MB57480E162CCD244941533F858ECA2@DM4PR12MB5748.namprd12.prod.outlook.com>
References: <20260729083118.3658560-1-kevinyang.wang@amd.com>
In-Reply-To: <20260729083118.3658560-1-kevinyang.wang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-29T08:38:35.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5748:EE_|SA1PR12MB8698:EE_
x-ms-office365-filtering-correlation-id: f3f9d47c-3d44-4950-93d2-08deed4ccb51
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|38070700021|6133799003|11063799006|56012099006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: IBIjinm8UcbuhqOoHiSOhuGLHF6qQ+9U82SqusWV52BUR/AYdM2ElRSKMY76ogpsgi1tT7FwJrcxI0SpFGjkKHwpBx2+m4HRcy8Idw6ukTWmYAXK3dDd/4oWwCmYaluwo4tJzXjPpFMpu82z2d07vhhAtkGHbeoCz0SeHT+u9BYVbefMOoqu96ca97/yOp/R+s7yUgqaOz4cNCx9wTakkxShCGgG9EDCawKA4J7emy0I8PEuFth36puL6wIl4ePjcarqK1XZKL6pCXZZkVpbj5m40zlE5kPIZhSN9Ka2/R+0YniaCEY/o+Xr9aVq5jz374HVzA15b5LolU+8xPawkCR+kmmS5hC8dKTC8Jn9I2Ptt5/pG3qpFFfPqL341jtMW4ulHF8DmvIwe6qRI+EQAU2OXpmR7DLtSYFjJAQvKMqdWIkypzjaNAqgUaqhT0x64wU7Q67qH4q045xwiZXzzImBy0amitDkPwBaF4Sp9tGOJU9EWSt23nDgBK3C3+0xyVXhodlt4FbdPOGNM0GXe/t1kxQtutkB6jyBBjNaTRV5BmwviC0NuThBD2YuqMtCVCmiiRziopCs3NK8BaAlpunkXw4GmYNU1b30BatqSM5f8wZiNF3fRlTPGsbyqPXrr+KsEEaOKAvGxbnTe+ib+jei1YGLV9nZraJj8OXCI7dHmeTDUxFyFCJQMPSKPBTGudBZ+rzaJApAz2vGTTQnoWtvFsda8cb/jikzCNfiCQM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5748.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(38070700021)(6133799003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Z3qseOysTKt1r38UZ2ZqxP8DnSA/j6JweFCau2EIdd9FK1cStgnoV8mMFRgS?=
 =?us-ascii?Q?u0Of1PO4BSHrpYGwNtGLsnnFVwBTA4K9oKn9HAMTdFkBeAE2ZE17tTQcfPRk?=
 =?us-ascii?Q?MCdSCL1fNVcIaiNB0XjtbymNterc7KQlmR1OX/mQZNZKG8synOF6/XrKDt/i?=
 =?us-ascii?Q?GGq7fS3VHk+1SDvAQ+ZoZN5iiOTbMzePtXf7600mgmud7aeKPR9LJTnmLvsw?=
 =?us-ascii?Q?VjbEXmoqZZOFHEbiY2m4iBkapssNbp/4g7zXNasXs2/59kIRRCrFB84HyAbc?=
 =?us-ascii?Q?ZthGtT1CG74B9WdQG1ejg19IJT8K5LQZrBL+l0Cw7N6amh6W8WCnZ20UCh8K?=
 =?us-ascii?Q?Yp/bkWa3lbfzGntuWbSaAgM868Ynrv14zh9aVTNhDGT4BfrZNKZjRsDmoolL?=
 =?us-ascii?Q?xS7H1iemQeM6YIeDaEpOGHy70Ky9+sn1lIk+EcWLxqUlM6SMlswGCPgDzsx5?=
 =?us-ascii?Q?tzXIohxONywJbwDDv9VJeUU6bW2AAZmi4YPkBY32SXfb9H2un5ikjS16UMJp?=
 =?us-ascii?Q?oX0OwZ5eKjAArRFwUNDWvaTD1gESyGNn9WsLtvjPq/V10M8dRG6DGRXfBxel?=
 =?us-ascii?Q?uQ5P224J+xFZc7ThTwcJOB1BokHg0C87lyd0eatRfkIcMywYMFw3TaUAe5UL?=
 =?us-ascii?Q?L7Uj4idyqDZgwYGXFRxUtSxf9ynSKZLkvS3MQwWZZ4pWMw0/G0z5yveD5gSH?=
 =?us-ascii?Q?ikLMKGb7XLqY8FMetxaLtaR4uEa/4cwGqPmGMBNZcTlkoOYTgref0LudVQaz?=
 =?us-ascii?Q?wIQdG7idFQZqdw0U+KMTbROAdf5FHuP05T5gRxtiZ6qOQ4GCN23rQk6WFHnM?=
 =?us-ascii?Q?Un3Zm1kTFF8dB8LWGG1XTlIZwL5joISQY+dVhRGTq01+irIlPVY5u9VSSPT6?=
 =?us-ascii?Q?1BQVQ+66xBIa1fw4I7W7MZ7aUYXuehBqnDvxnEdYaLS06yV5Vs7MjxaNVWpR?=
 =?us-ascii?Q?3OC7ynNPRZb51n6CSJqtLVqNQspk6u7ZO4mutwkWB4x4uEEW7BsYdVnG0wE5?=
 =?us-ascii?Q?JjERKaktC4cH8FOYuXDT39eouphfdjqTESPW0/i3tJyoEyu1LW594lHTq5cE?=
 =?us-ascii?Q?kN+nFloWJRU1FlLOaed/aDVo7qZ3nGINm75RoEKDFYrIRPIzvq2+qkrYoWp+?=
 =?us-ascii?Q?+JYA2+1iVZHBP7UyYa1O1UEOGwlrZi1iFN5vV5T+E14zgBg/k7KWB02PyJvY?=
 =?us-ascii?Q?8jM+QxzB5mqyJ7ge1DxIjsw81Wdjo0XHoPja4h285Bt14HscJ6OwGRgyzgmU?=
 =?us-ascii?Q?v97eNbryQ6Lu8bgOVyMUSD2YRwppuOerdbZFhj6bUCdgRyOK+CiCOpW22v2f?=
 =?us-ascii?Q?O5pp2sqP9wng/y6LYrafHbVdfvZEs6NzIaKfx7IQSQPZyM7Tsqve54OUk4Xa?=
 =?us-ascii?Q?O4jdc/RboF9NJRhdKclcnsVrxMaFw5xZqNLpjw+9l3sYt1ZxTlp6J9V9HK+t?=
 =?us-ascii?Q?K+0qEVWQOYiLg7YqaxNGyvY492Xx7keKBKOLKlwHBp0tHoGsl+pCw3wvChcc?=
 =?us-ascii?Q?HJCD6M1ULJbMTLk41WAGkoMsZN2RR24xetM+Y2pqaFDK9IBGAh8wATp6s61e?=
 =?us-ascii?Q?8/l670ci295bwK229Zqhr+V0RlESj+h+A6Pt3XsLjzxVFvEdcPhBAD4iY0lE?=
 =?us-ascii?Q?TGxTKg3mzC14+JZQ/0A0drdeUx/Gp5FRzNRt1UPOD16RHxsbTOeb3QhmddM6?=
 =?us-ascii?Q?hFaWXhmwV0xgcd9GZj14qnMTsgQqeYQf2c0JzzzRXSl5+FBl?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5748.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3f9d47c-3d44-4950-93d2-08deed4ccb51
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2026 08:38:41.7569 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TQP6GDIKF7eEMWL1NdU6H7Lv0Gm8gIazk875+cTLhuMHhlXLeJZL4iCpjx5TTB0xSaLlmUznYvufSUI/IRe8pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8698
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
Sent: Wednesday, July 29, 2026 2:01 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking <Hawking=
.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH] drm/amd/pm: hide pp_table sysfs on APUs

APUs use firmware-owned DPM tables and do not support replacement through p=
p_table. Generic callbacks can nevertheless expose the sysfs file and accep=
t an upload before resetting the power management stack.

Treat pp_table as unsupported on APUs. Use the same platform check in the g=
et and set paths to hide the file and reject uploads.

Fixes: 289921b03fe5 ("drm/amd/powerplay: implement sysfs of pp_table for sm=
u11 (v2)")
Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/a=
mdgpu_dpm.c
index 8f59ea12fe0e..c3688b3b12cc 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -1183,6 +1183,13 @@ int amdgpu_dpm_dispatch_task(struct amdgpu_device *a=
dev,
        return ret;
 }

+static bool amdgpu_dpm_is_pp_table_allowed(struct amdgpu_device *adev)
+{
+       return !amdgpu_sriov_vf(adev) &&
+              !(adev->flags & AMD_IS_APU) &&
+              !adev->scpm_enabled;
+}
+
 int amdgpu_dpm_get_pp_table(struct amdgpu_device *adev, char *table,
                            size_t size)
 {
@@ -1193,7 +1200,8 @@ int amdgpu_dpm_get_pp_table(struct amdgpu_device *ade=
v, char *table,
        if ((!table && size) || (table && !size))
                return -EINVAL;

-       if (amdgpu_sriov_vf(adev) || !pp_funcs->get_pp_table || adev->scpm_=
enabled)
+       if (!amdgpu_dpm_is_pp_table_allowed(adev) ||
+           !pp_funcs->get_pp_table)
                return -EOPNOTSUPP;

        mutex_lock(&adev->pm.mutex);
@@ -1717,7 +1725,8 @@ int amdgpu_dpm_set_pp_table(struct amdgpu_device *ade=
v,
        if (!buf || !size)
                return -EINVAL;

-       if (amdgpu_sriov_vf(adev) || !pp_funcs->set_pp_table || adev->scpm_=
enabled)
+       if (!amdgpu_dpm_is_pp_table_allowed(adev) ||
+           !pp_funcs->set_pp_table)
                return -EOPNOTSUPP;

        mutex_lock(&adev->pm.mutex);
--
2.54.0

