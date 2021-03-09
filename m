Return-Path: <SRS0=7mEa=IH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14351C433E0
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 06:19:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B10A365287
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 06:19:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B10A365287
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C6676E484;
	Tue,  9 Mar 2021 06:19:55 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2047.outbound.protection.outlook.com [40.107.95.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F71C6E484
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Mar 2021 06:19:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CgFfR4QPctyHBnp6ulB1DzsjsVfvF8zK/M3wTinj1k/JXrQ5wCa9dy5p92KIBWlwIwADk5P0UL3VzRTnxrTsIwAuhlbdgmbDh65OI+s+J7Gg2e4MrQF6J69/+8QPYnEC3m2j18IV65dSDVRP1DjWkGYWqMhhyKTqGqiOrKE3LiiUCVWtSopkVg8jyNZ28D6FaySbrRXKvDkwCNNctdA9mzOshrhATOK3GYnLAhTVY/Xa7blLssWJYBGMipmstwx4SYklymweQksZpetnWjIlKmOCEQAUstaxdNaO+TlhSRruLoJUJ5gDupcVqF0EtWBJ/BE5pDMbxiBHwnqv7ZCJbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nk2/UML6SLaNogD4SqbvPz4+e2261QXDY5U1y+GJVM0=;
 b=hmTQfhX53M4kwu2M1lUBpBpg2zKUon6ySN8skHNC7mS9nRD7N6yUR62QwSSlcQySvA/mrwDGt/OobMI01O9LEAtSW7wsNmJ3qZxWu/QLUWB4m5PMD3BSfaY/G+qbjpTW+RozQz7hkDs9TKAr9KN8G5m5NLkEcqNwI1BQHqK8w8XSE+gtdyc5bvG5GFI6GmVowgUmovrFHVAxczaxU/x+/9ed135iIBi7H0RVARqpF1/pqgdC/C10amlp6shInRnWhekTBTFVtUoT0t8QcgFTC/zRf/55/FCu8yEEgurj8+Xrj10jKeRG+3PfmNeggKjdG2DyDF8fOksXnYDkJ8FWOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nk2/UML6SLaNogD4SqbvPz4+e2261QXDY5U1y+GJVM0=;
 b=ZJUYnKFz7yrzLKAATlX/WKzQbWPtfJHR0remSjXTp080E6EPbrgoBmkw/ixPZica8h8CDCFeHeA7rLEN3IRyfOwKsq0qZcwRQE3OEd71BV6t8oOEGlBX89HqlPq5DVk3Z6kg8tz7AfMKslIRmEGUblqvCctaqml2pd9lFb9t8qU=
Received: from MN2PR12MB4549.namprd12.prod.outlook.com (2603:10b6:208:268::15)
 by MN2PR12MB4391.namprd12.prod.outlook.com (2603:10b6:208:269::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.27; Tue, 9 Mar
 2021 06:19:50 +0000
Received: from MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::c1a6:7b2b:9494:776a]) by MN2PR12MB4549.namprd12.prod.outlook.com
 ([fe80::c1a6:7b2b:9494:776a%4]) with mapi id 15.20.3890.038; Tue, 9 Mar 2021
 06:19:50 +0000
From: "Lazar, Lijo" <Lijo.Lazar@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 4/7] drm/amdgpu: track what pmops flow we are in
Thread-Topic: [PATCH 4/7] drm/amdgpu: track what pmops flow we are in
Thread-Index: AQHXFJot3WpRFXKzHEu2UmNuKv6D5Kp7Lteg
Date: Tue, 9 Mar 2021 06:19:50 +0000
Message-ID: <MN2PR12MB4549198E8D86DC4176EC6C9E97929@MN2PR12MB4549.namprd12.prod.outlook.com>
References: <20210309041012.23367-1-alexander.deucher@amd.com>
 <20210309041012.23367-4-alexander.deucher@amd.com>
In-Reply-To: <20210309041012.23367-4-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-09T06:19:48Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=f7c766d3-55fa-41a3-a87e-0dc88203f150;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [49.207.194.158]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c4649dff-0932-4619-46ee-08d8e2c35867
x-ms-traffictypediagnostic: MN2PR12MB4391:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4391B95FF2C38FE9ED2164F497929@MN2PR12MB4391.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jsrSS05SM/K8np332AiIQrgzQimCPZ2p+Ngk7oi75H1ASvBlVrBXyufnK+puvyvx9w61wiIV6o3TLE5FuJRvMF4SMYtSxdSlgGKMQaLaWKpFSEWAvOHKa8guUuG+XdPrW5Ow4R3SRKbHsurWPPIcAIgtw7b4JIRC2WkrsifT+oxNqw44fdyy8YT7HfAxyTIJAqO4g+4Ne68jws9WznmJYXoSiR2W5LmTa2uRhTIJC9HHWxzPcLUTrsX0cqK/9B+ffC1xPj6Oh4Mk0hdlrrGaonHp0NPAueTQl223hxcRPiZzoxuDK95WOkWPGOjzuuDUoPK9ylSOJBSQiVHrAjMCT6RoBulBgBI0yQHUj4wnzrnuCzY0U/Rfyk8ivELJ0KvPpWS7+lABkuO1GW54azMmw68D8YnZzj8kER3SR3auw9tyUOzCbTCw9d9SiDrGxT6XMnO94XlZ1vFfZ+/KhQxvFXrwcwS1Qg6ZqV24+PGVXVIJxRDOTfqbJe1z34ydbmCKS7/HPOpFasPXbq6km4gKLdgTImwCnVvzEjEIMe/4Ob8axQdFHgwJWBALvv8JQHr5
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(39860400002)(396003)(136003)(376002)(9686003)(52536014)(5660300002)(55016002)(76116006)(45080400002)(478600001)(966005)(71200400001)(186003)(4326008)(26005)(33656002)(53546011)(316002)(7696005)(55236004)(83380400001)(2906002)(86362001)(66446008)(64756008)(66556008)(66946007)(66476007)(8676002)(6506007)(110136005)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?URmR9yU3xKjE5Kfa9m42cSd/8WSOxTVeIj4KE2rD0//hcWuCHFEmP6+zRHVb?=
 =?us-ascii?Q?TsKunxoWL5XcT4x5+5InKd3JjyHP5HiVAaROsoJYxxlaojOsjKW1BTNUAdKd?=
 =?us-ascii?Q?Kl8bFNYE8h2G/I+foUspEbtOxDONf6F3iGK/wVx9Z/I1m6JfH367KqPv4J9r?=
 =?us-ascii?Q?6De1RA6FjRR8zNqbf3lM2Lgv72kMMX3S0sueBZigraB/UWNvAXLMiQ7nYyf9?=
 =?us-ascii?Q?5QQaRYRxHyeixrcSrYu5lEc2WkJ06D7MmgAsgWM0aPtc3XsEkTjnQ7ZuYBtC?=
 =?us-ascii?Q?eJiIKbfy8YUKfTbYMSuxyzS9E29csEZNee1DbpBNo5LPKuuDJ+jw+CGHrGn/?=
 =?us-ascii?Q?p9bLt3ry2MiPkDJLsuAy+Xd1xTJQgG9OREUBke2hZ0txocj6dqlhM27nkdht?=
 =?us-ascii?Q?eLxwN2hR54GUXJyl/mTWj4pFKn/M6uvp8c2+98p9Y8NdaJ1uy0rMNwZqE7nr?=
 =?us-ascii?Q?loNjFaV/hXHE5mCXpv5mlZxrbk3EkeCKzu0/d6hSEkBCFSyN1TB/8uju76eN?=
 =?us-ascii?Q?xspsZ7HE4Wu227ozsFRedkIQ3YyU9OlDk4ToqVlBXEq56qHxQOEMxkMlx5Ou?=
 =?us-ascii?Q?BAderrlpameiqIHK/vsPxfnwOeisjETt+hPhmQ32f3RMsqIERIRaE6kV1Y2A?=
 =?us-ascii?Q?xvFezIsnahAkUqo0K8b3Ue/XeYr+tFnBfiThvJ1BlHpK7i0bndfQVghvWuMY?=
 =?us-ascii?Q?vO1D7W0uj/Snpuk8tars8lIjlAVL5q0WmvFqZZIkqOpc3HxOaxoxi8AfbY9H?=
 =?us-ascii?Q?bm79hbpOrR5/uXSBOAYF/bmX1afKZMShRHYaa9G3V/VQGag+fGwHYj29oEmt?=
 =?us-ascii?Q?u/FdazjI0vM+KHMMWkI0LdhYZjA8SGoXlWs7Txgi8sGxh0URu1bHwQg1XdDn?=
 =?us-ascii?Q?MSAudJ1/QzmRScFHtQhLT+hukfXF9F1ZgBP1lXv961+47moXZFdDjPmARIq/?=
 =?us-ascii?Q?Hn1Wzxtt5E2hwtLwhMIuvLAZ9P3Vz9g5JzymufQ/vRsjs97MJJWj9GOSb8U1?=
 =?us-ascii?Q?ceBrYx0//MShQiIe5AZ32UZVzor7zxkjZboGGI9e/tHziSmitM0+UE4/Cr/9?=
 =?us-ascii?Q?C2SnKrqs0a9JyWttpi60OaRUQxi4B0GTll0BYEZrjFTT2AXQSFOYid2Hutsp?=
 =?us-ascii?Q?QXimP9xrem99aYwBknlC2dcTcSNUd/qt3cmoxvliwV9meYqcYGNTJYMIQAkY?=
 =?us-ascii?Q?zG8TCD2xw0P8JZLgRc+7BniF7B7vJShjbv3g7902GuWzLVSQGnUwLFBmmxhU?=
 =?us-ascii?Q?FZXMaLQzHCnTc8sgfL5uNz/rW+ERhCJV8mlPk9/6NoGlXDIDfbq37+wWtwsX?=
 =?us-ascii?Q?LpA5vRw0BFza1q5t9m+MWLki?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4649dff-0932-4619-46ee-08d8e2c35867
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2021 06:19:50.0965 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uAO73wn3b67hEcJPa5DUn/771D6XUjUwuo7GBylznuxL4quAdcx9GDsX/LAm3ye2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4391
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

This seems a duplicate of dev_pm_info states. Can't we reuse that?

Thanks,
Lijo

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Tuesday, March 9, 2021 9:40 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 4/7] drm/amdgpu: track what pmops flow we are in

We reuse the same suspend and resume functions for all of the pmops states, so flag what state we are in so that we can alter behavior deeper in the driver depending on the current flow.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h       | 20 +++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c   | 58 +++++++++++++++++++----
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c |  3 +-
 3 files changed, 70 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index d47626ce9bc5..4ddc5cc983c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -347,6 +347,24 @@ int amdgpu_device_ip_block_add(struct amdgpu_device *adev,  bool amdgpu_get_bios(struct amdgpu_device *adev);  bool amdgpu_read_bios(struct amdgpu_device *adev);
 
+/*
+ * PM Ops
+ */
+enum amdgpu_pmops_state {
+	AMDGPU_PMOPS_NONE = 0,
+	AMDGPU_PMOPS_PREPARE,
+	AMDGPU_PMOPS_COMPLETE,
+	AMDGPU_PMOPS_SUSPEND,
+	AMDGPU_PMOPS_RESUME,
+	AMDGPU_PMOPS_FREEZE,
+	AMDGPU_PMOPS_THAW,
+	AMDGPU_PMOPS_POWEROFF,
+	AMDGPU_PMOPS_RESTORE,
+	AMDGPU_PMOPS_RUNTIME_SUSPEND,
+	AMDGPU_PMOPS_RUNTIME_RESUME,
+	AMDGPU_PMOPS_RUNTIME_IDLE,
+};
+
 /*
  * Clocks
  */
@@ -1019,8 +1037,8 @@ struct amdgpu_device {
 	u8				reset_magic[AMDGPU_RESET_MAGIC_NUM];
 
 	/* s3/s4 mask */
+	enum amdgpu_pmops_state         pmops_state;
 	bool                            in_suspend;
-	bool				in_hibernate;
 
 	/*
 	 * The combination flag in_poweroff_reboot_com used to identify the poweroff diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 3e6bb7d79652..0312c52bd39d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1297,34 +1297,54 @@ amdgpu_pci_shutdown(struct pci_dev *pdev)  static int amdgpu_pmops_prepare(struct device *dev)  {
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(drm_dev);
+	int r;
 
+	adev->pmops_state = AMDGPU_PMOPS_PREPARE;
 	/* Return a positive number here so
 	 * DPM_FLAG_SMART_SUSPEND works properly
 	 */
 	if (amdgpu_device_supports_boco(drm_dev))
-		return pm_runtime_suspended(dev) &&
+		r= pm_runtime_suspended(dev) &&
 			pm_suspend_via_firmware();
-
-	return 0;
+	else
+		r = 0;
+	adev->pmops_state = AMDGPU_PMOPS_NONE;
+	return r;
 }
 
 static void amdgpu_pmops_complete(struct device *dev)  {
+	struct drm_device *drm_dev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(drm_dev);
+
+	adev->pmops_state = AMDGPU_PMOPS_COMPLETE;
 	/* nothing to do */
+	adev->pmops_state = AMDGPU_PMOPS_NONE;
 }
 
 static int amdgpu_pmops_suspend(struct device *dev)  {
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(drm_dev);
+	int r;
 
-	return amdgpu_device_suspend(drm_dev, true);
+	adev->pmops_state = AMDGPU_PMOPS_SUSPEND;
+	r = amdgpu_device_suspend(drm_dev, true);
+	adev->pmops_state = AMDGPU_PMOPS_NONE;
+	return r;
 }
 
 static int amdgpu_pmops_resume(struct device *dev)  {
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(drm_dev);
+	int r;
 
-	return amdgpu_device_resume(drm_dev, true);
+	adev->pmops_state = AMDGPU_PMOPS_RESUME;
+	r = amdgpu_device_resume(drm_dev, true);
+	adev->pmops_state = AMDGPU_PMOPS_NONE;
+	return r;
 }
 
 static int amdgpu_pmops_freeze(struct device *dev) @@ -1333,9 +1353,9 @@ static int amdgpu_pmops_freeze(struct device *dev)
 	struct amdgpu_device *adev = drm_to_adev(drm_dev);
 	int r;
 
-	adev->in_hibernate = true;
+	adev->pmops_state = AMDGPU_PMOPS_FREEZE;
 	r = amdgpu_device_suspend(drm_dev, true);
-	adev->in_hibernate = false;
+	adev->pmops_state = AMDGPU_PMOPS_NONE;
 	if (r)
 		return r;
 	return amdgpu_asic_reset(adev);
@@ -1344,8 +1364,13 @@ static int amdgpu_pmops_freeze(struct device *dev)  static int amdgpu_pmops_thaw(struct device *dev)  {
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(drm_dev);
+	int r;
 
-	return amdgpu_device_resume(drm_dev, true);
+	adev->pmops_state = AMDGPU_PMOPS_THAW;
+	r = amdgpu_device_resume(drm_dev, true);
+	adev->pmops_state = AMDGPU_PMOPS_NONE;
+	return r;
 }
 
 static int amdgpu_pmops_poweroff(struct device *dev) @@ -1354,17 +1379,24 @@ static int amdgpu_pmops_poweroff(struct device *dev)
 	struct amdgpu_device *adev = drm_to_adev(drm_dev);
 	int r;
 
+	adev->pmops_state = AMDGPU_PMOPS_POWEROFF;
 	adev->in_poweroff_reboot_com = true;
 	r =  amdgpu_device_suspend(drm_dev, true);
 	adev->in_poweroff_reboot_com = false;
+	adev->pmops_state = AMDGPU_PMOPS_NONE;
 	return r;
 }
 
 static int amdgpu_pmops_restore(struct device *dev)  {
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
+	struct amdgpu_device *adev = drm_to_adev(drm_dev);
+	int r;
 
-	return amdgpu_device_resume(drm_dev, true);
+	adev->pmops_state = AMDGPU_PMOPS_RESTORE;
+	r = amdgpu_device_resume(drm_dev, true);
+	adev->pmops_state = AMDGPU_PMOPS_NONE;
+	return r;
 }
 
 static int amdgpu_pmops_runtime_suspend(struct device *dev) @@ -1389,6 +1421,7 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
 		}
 	}
 
+	adev->pmops_state = AMDGPU_PMOPS_RUNTIME_SUSPEND;
 	adev->in_runpm = true;
 	if (amdgpu_device_supports_px(drm_dev))
 		drm_dev->switch_power_state = DRM_SWITCH_POWER_CHANGING; @@ -1396,6 +1429,7 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
 	ret = amdgpu_device_suspend(drm_dev, false);
 	if (ret) {
 		adev->in_runpm = false;
+		adev->pmops_state = AMDGPU_PMOPS_NONE;
 		return ret;
 	}
 
@@ -1412,6 +1446,8 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
 		amdgpu_device_baco_enter(drm_dev);
 	}
 
+	adev->pmops_state = AMDGPU_PMOPS_NONE;
+
 	return 0;
 }
 
@@ -1425,6 +1461,7 @@ static int amdgpu_pmops_runtime_resume(struct device *dev)
 	if (!adev->runpm)
 		return -EINVAL;
 
+	adev->pmops_state = AMDGPU_PMOPS_RUNTIME_RESUME;
 	if (amdgpu_device_supports_px(drm_dev)) {
 		drm_dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
 
@@ -1449,6 +1486,7 @@ static int amdgpu_pmops_runtime_resume(struct device *dev)
 	if (amdgpu_device_supports_px(drm_dev))
 		drm_dev->switch_power_state = DRM_SWITCH_POWER_ON;
 	adev->in_runpm = false;
+	adev->pmops_state = AMDGPU_PMOPS_NONE;
 	return 0;
 }
 
@@ -1464,6 +1502,7 @@ static int amdgpu_pmops_runtime_idle(struct device *dev)
 		return -EBUSY;
 	}
 
+	adev->pmops_state = AMDGPU_PMOPS_RUNTIME_IDLE;
 	if (amdgpu_device_has_dc_support(adev)) {
 		struct drm_crtc *crtc;
 
@@ -1504,6 +1543,7 @@ static int amdgpu_pmops_runtime_idle(struct device *dev)
 
 	pm_runtime_mark_last_busy(dev);
 	pm_runtime_autosuspend(dev);
+	adev->pmops_state = AMDGPU_PMOPS_NONE;
 	return ret;
 }
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 502e1b926a06..05a15f858a06 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1327,7 +1327,8 @@ static int smu_disable_dpms(struct smu_context *smu)
 	bool use_baco = !smu->is_apu &&
 		((amdgpu_in_reset(adev) &&
 		  (amdgpu_asic_reset_method(adev) == AMD_RESET_METHOD_BACO)) ||
-		 ((adev->in_runpm || adev->in_hibernate) && amdgpu_asic_supports_baco(adev)));
+		 ((adev->in_runpm || (adev->pmops_state == AMDGPU_PMOPS_FREEZE))
+		  && amdgpu_asic_supports_baco(adev)));
 
 	/*
 	 * For custom pptable uploading, skip the DPM features
--
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Clijo.lazar%40amd.com%7C522d9fee476f4075753008d8e2b14e6e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637508598450890140%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=pLFkgulTUPmA3C1RRbdJh2mxkGDWxoxTrkMRTs6HfjY%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
