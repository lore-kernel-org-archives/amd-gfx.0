Return-Path: <SRS0=mtj4=FF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA65C64E7A
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Dec 2020 15:48:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45D302080A
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Dec 2020 15:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Vw4kM+X8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45D302080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8936E6E57E;
	Tue,  1 Dec 2020 15:47:53 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E7B06E57E
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Dec 2020 15:47:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MZHRq8UQ5GpzCN3Ka9VxUeSoZqrpckwFfnoZ0xeoyxkaOs48CZ8HQ23vZlYF6WgWCUY2JqptUKYPhHQuUcY346GU+d/hEENUK9mooqESQVMS5rzBacl5vqyYHlnpZON867THdH4xVAm3jsz7mLpQfZQvU7dNukcKPs1au7ackzTSd8VRfvxhI8HLPveAIbvrkoRl2Y96F0g/rM6vAtpWKJ8xL2nvWZqpp2KtBqHFZ+kXXaIaEAJrbZ1VfokS2YF9pZ+EwAgpb4lu28pK8bRHU35Mii+cHeQZHBBZHdjaZAB48IiPSLm5rMo4COLcBR6vAiVQVYdHFWo9w1GXBgNQ1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UnmRCZzM9wjJihC9PxeYK5pgYD4/3p9mJHXx7R6M4Oo=;
 b=h30OnXetc17n2pkS4wzp4yJE6rm2hT00Kgw8u2ZtJ9Kg4r+DvSLfls3K+GDyDf8QScu+mGNZbRjJ+BKua8LiX+6VZ1wqGi0PvincGzjiHE/sNwGGOioLXX4kdEVlRvJl6auL/OvBiW3Pv28j5YHIdFc2YfJsrbikqrIgB9OoOF86VBlQFk1LsDbfFb23TXs4h428LGayIqMwgkwT6C3YIg9woSKl1bX3DpBpfkZMTnFEVLiros6bPkvutmXO0hQHlc5VZpPbAJ0ajDJA3ryfWJlDAQ0qGpVeUOcyoQwnpMevxmJ1jab7LO5AUnET4FGu7F/CWoDWAtCz5h1YbOjRqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UnmRCZzM9wjJihC9PxeYK5pgYD4/3p9mJHXx7R6M4Oo=;
 b=Vw4kM+X8u73PKC+EBjDCAfQb14zyAoqse1BLykHmK5dk98L7ZpLMaM4tUUkgUPbMnSIeDb4oZnMOUTBvDK/HTkaEhIlliLBtsk5jJrAaeMOzwqT1WF6EH4Ai+iwpO1eqZST53WsElPgvy/7Ni0n/6fZMCGWkqi3vQj7KSbUud0I=
Received: from BL0PR12MB4913.namprd12.prod.outlook.com (2603:10b6:208:1c7::20)
 by BL0PR12MB2387.namprd12.prod.outlook.com (2603:10b6:207:44::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.31; Tue, 1 Dec
 2020 15:47:51 +0000
Received: from BL0PR12MB4913.namprd12.prod.outlook.com
 ([fe80::f47c:4d87:77a:989f]) by BL0PR12MB4913.namprd12.prod.outlook.com
 ([fe80::f47c:4d87:77a:989f%8]) with mapi id 15.20.3611.031; Tue, 1 Dec 2020
 15:47:51 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: invalidate hdp before CPU access the memory
 written by GPU
Thread-Topic: [PATCH] drm/amd/pm: invalidate hdp before CPU access the memory
 written by GPU
Thread-Index: AQHWx8Gy9UbOEmvWaEaKWUGvYlGN/6niYtrA
Date: Tue, 1 Dec 2020 15:47:51 +0000
Message-ID: <BL0PR12MB491395D494B2FD5CB787E4D097F40@BL0PR12MB4913.namprd12.prod.outlook.com>
References: <20201201090904.2566339-1-evan.quan@amd.com>
In-Reply-To: <20201201090904.2566339-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2020-12-01T15:47:31Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=5ddceb37-24e2-4a76-adf3-0000c3a414f0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2020-12-01T15:47:48Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: 6ebd4a79-944a-4225-8ed8-00007387e804
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [49.207.207.161]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 187f7344-8f13-4f3a-85fd-08d8961075cb
x-ms-traffictypediagnostic: BL0PR12MB2387:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB23874FCA6B301103FA7B51F097F40@BL0PR12MB2387.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uz+4TW++hh8S27Jg5DJgynVAdmrFUWW6nWA0iPPFzGX2d300bZIMeHC9/34sXuSs4PrylWPJ0bp0h2yHFajSKGOxGOXBYJom8e3m48dM7T5EPneHDVbouXOwzBva9c9MjFSjMCGpQHCroFUXru9uPHhvZM1fRmP4bOlkaq9xMZIwoCacEqDlUgXvJ5CePgKkQIutp+DSwmg90Km+nyNIv9V9HJqdMaZ63ObBpGAIYEqcI1PO7yjqD5e/IJTJTLU4+zpAIX0ZEiQzy+JeY4Urft5GPbasEvMA/ALtYr8SKrFX0SiAPKA4pXiS0cvo5QiDvyFBasl72SfCeQPZfsgxLn6jC8ZnNVqcFTZT7k+Wd3I=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4913.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(346002)(376002)(136003)(396003)(7696005)(6506007)(86362001)(8936002)(110136005)(52536014)(55236004)(53546011)(66476007)(9686003)(66556008)(66946007)(966005)(66446008)(4326008)(316002)(64756008)(33656002)(8676002)(26005)(55016002)(71200400001)(83380400001)(186003)(478600001)(76116006)(2906002)(54906003)(45080400002)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?wunIiwWdEI8uWklkiN0aA+1IqY9HuM63KCYIXw0Um3oJSlYzEmxBcEQHNin1?=
 =?us-ascii?Q?CC6YXzl4Yvz8qPtPPOqBdy33Edsl9QN0w5JOMyLzffuHetl++R5n01OB1YGI?=
 =?us-ascii?Q?txR0Jks7dCePeyizDw1JeQyR7Y1BdRcw9AECLgls/mp/NLmNkeONzkEiuhI7?=
 =?us-ascii?Q?RzSP5R37Z5ZUqm/HvwEvLm+8QC2qyDRSE8MV+FWZmxqT+1FJ7CsRB65baGte?=
 =?us-ascii?Q?dNREYBSbVmquG4KDXWZlMKt5zaJZHaG9Q9tqcx2nvYA7VJCoC6YU7KW8gwxR?=
 =?us-ascii?Q?0p7QGP9BOuNkoBN3F/Z9rCCV1FjpLEiOLwbury7Iky2C8CI/q/s88tTlqoFW?=
 =?us-ascii?Q?FhHvadhIGj+YLXc8Zy7LK4GSmCTNg/VlwjHpm8aZlH5YOTPyp+jU3GndLNlv?=
 =?us-ascii?Q?F5QZ+HW5MOEBzSl9yi8/fAcQOjl1z2zMIczoTm+YTgqOXq5Uv0ATDGIinjjC?=
 =?us-ascii?Q?upEZuFQUCPr1p2oUQdIvgQYAt1ck9UV7EQfCNS0txlzugk/zNleoNlhLaDvd?=
 =?us-ascii?Q?efRwKWSgxsKciF0KRpsoWa6+Fl/DvxdOd7l75a6e3S5t62A/9WM4V8Ltacrm?=
 =?us-ascii?Q?UXJeekJHQibNCbiu7tz4dQmTsyfoV9EDeGYPQEdSqHXlZuof+evCQfMZgxaX?=
 =?us-ascii?Q?OuxySuLpcvvZYx62Mq3dg3aeDqsgylbhM2sEWMrDKHuoJM5P9Akoqfsb7XSg?=
 =?us-ascii?Q?QIiMJvdqi7g/JM+HKapPKPzNVxBNqFwS+T4zNCr0KcRa+v3IM07vKC0P64fo?=
 =?us-ascii?Q?Y+Mp0lamkqqdlQ1obBDXOHp6ofbBz00LUo250HoE6nFPhtcY9bcNt3D8OOMc?=
 =?us-ascii?Q?q9bq1h0KylBbqYnEWNbeM949tzeCb6avSBQlTrUAo45TYXNjH2CQ7qLM2ztv?=
 =?us-ascii?Q?pGaiogpUcIC7dSV4Eoui8DMHbq0NEPEcQ6qeh9U0Ci6uwuwq8sZyqIjP7wqj?=
 =?us-ascii?Q?BJqedTdzO4f5goQJYOMRnC4wsqVDy5xwpOTfeYKbJVo=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4913.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 187f7344-8f13-4f3a-85fd-08d8961075cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2020 15:47:51.1795 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KUIVaOL/maR78uy+P7PqW1xkA15ctro5Z14B63vwJH4w+Oq0eIkAKEocxqoJUjLJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2387
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Evan Quan
Sent: Tuesday, December 1, 2020 2:39 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@amd.com>
Subject: [PATCH] drm/amd/pm: invalidate hdp before CPU access the memory written by GPU

[CAUTION: External Email]

To eliminate the possible influence by outdated HDP read cache.

Change-Id: I93ab87a44d146ca546ca08be21b979ea6713c6af
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/smumgr/smu10_smumgr.c  | 3 +--  drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c | 3 +--  drivers/gpu/drm/amd/pm/powerplay/smumgr/vega12_smumgr.c | 3 +--  drivers/gpu/drm/amd/pm/powerplay/smumgr/vega20_smumgr.c | 6 ++----
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c                  | 2 +-
 5 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu10_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu10_smumgr.c
index ea2279bb8cbf..47b34c6ca924 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu10_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/smu10_smumgr.c
@@ -139,8 +139,7 @@ static int smu10_copy_table_from_smc(struct pp_hwmgr *hwmgr,
                        priv->smu_tables.entry[table_id].table_id,
                        NULL);

-       /* flush hdp cache */
-       amdgpu_asic_flush_hdp(adev, NULL);
+       amdgpu_asic_invalidate_hdp(adev, NULL);

        memcpy(table, (uint8_t *)priv->smu_tables.entry[table_id].table,
                        priv->smu_tables.entry[table_id].size);
diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c
index 85e08a552685..a70d73896649 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega10_smumgr.c
@@ -60,8 +60,7 @@ static int vega10_copy_table_from_smc(struct pp_hwmgr *hwmgr,
                        priv->smu_tables.entry[table_id].table_id,
                        NULL);

-       /* flush hdp cache */
-       amdgpu_asic_flush_hdp(adev, NULL);
+       amdgpu_asic_invalidate_hdp(adev, NULL);

        memcpy(table, priv->smu_tables.entry[table_id].table,
                        priv->smu_tables.entry[table_id].size);
diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega12_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega12_smumgr.c
index f54df76537e4..b52ce135d84d 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega12_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega12_smumgr.c
@@ -68,8 +68,7 @@ static int vega12_copy_table_from_smc(struct pp_hwmgr *hwmgr,
                        "[CopyTableFromSMC] Attempt to Transfer Table From SMU Failed!",
                        return -EINVAL);

-       /* flush hdp cache */
-       amdgpu_asic_flush_hdp(adev, NULL);
+       amdgpu_asic_invalidate_hdp(adev, NULL);

        memcpy(table, priv->smu_tables.entry[table_id].table,
                        priv->smu_tables.entry[table_id].size);
diff --git a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega20_smumgr.c b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega20_smumgr.c
index cf43629d29d2..741fbc87467f 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega20_smumgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/smumgr/vega20_smumgr.c
@@ -192,8 +192,7 @@ static int vega20_copy_table_from_smc(struct pp_hwmgr *hwmgr,
                        "[CopyTableFromSMC] Attempt to Transfer Table From SMU Failed!",
                        return ret);

-       /* flush hdp cache */
-       amdgpu_asic_flush_hdp(adev, NULL);
+       amdgpu_asic_invalidate_hdp(adev, NULL);

        memcpy(table, priv->smu_tables.entry[table_id].table,
                        priv->smu_tables.entry[table_id].size);
@@ -307,8 +306,7 @@ int vega20_get_activity_monitor_coeff(struct pp_hwmgr *hwmgr,
                        "[GetActivityMonitor] Attempt to Transfer Table From SMU Failed!",
                        return ret);

-       /* flush hdp cache */
-       amdgpu_asic_flush_hdp(adev, NULL);
+       amdgpu_asic_invalidate_hdp(adev, NULL);

        memcpy(table, priv->smu_tables.entry[TABLE_ACTIVITY_MONITOR_COEFF].table,
                        priv->smu_tables.entry[TABLE_ACTIVITY_MONITOR_COEFF].size);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index dc28f22aeb38..f8260769061c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -655,7 +655,7 @@ int smu_cmn_update_table(struct smu_context *smu,
                return ret;

        if (!drv2smu) {
-               amdgpu_asic_flush_hdp(adev, NULL);
+               amdgpu_asic_invalidate_hdp(adev, NULL);
                memcpy(table_data, table->cpu_addr, table_size);
        }

--
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Clijo.lazar%40amd.com%7Cd0fc04e728f0413072a408d895d8d319%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637424105789290029%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=GEhS59a7EmWSpSi2e3pKZKkNK1EDeoQ5aEG2ZvFvw6E%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
