Return-Path: <SRS0=BT7C=ID=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0301C433DB
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 06:47:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60EF465000
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 06:47:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60EF465000
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEA7F6EADC;
	Fri,  5 Mar 2021 06:47:40 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2060.outbound.protection.outlook.com [40.107.95.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 734826EAE2
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Mar 2021 06:47:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ErYJzERrrMyXX+iO6rlBlu/pErd5JWoR8QXhm1RHhMXN+0q/t+wUGAxzuNg3t+4KMIewYziY0SH9xQ1ndAEgz/UcecCFD+ZQnaHUnW60ChcWSjqOcobJvXDy1RK/jZvVsnxcOPHZrxUq20D9k5aTfrq6YOxs0bN9etpTaDfM+V/2A9GSXt1jDhbld7TKeM3Jeg58jDqJtn7xno1T24mhy/D//sJZ+eHaZ/ZBcSTwPrFCsKXAsUvrK3SPddL7CnDOgjOEzBHrJihoJfTLSLds+EAglbp7kQL11Bzwg6fZVcLDXWPZLkZllHvfVI/2PAIJtpvOaRdrpfO1IrurOwk0/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iVCOgViYU2c0qw0VT4h51estQGFv03+NVyesK3h1azM=;
 b=byp97aEO21Lu2NN2orDt2re+pyJUikopA/Vf8wyJRGFmFxcH+fJPS9bxo+ziM3chwYQB5Ny9zl8XxTMEDLqK2cSGojOdO2glismkpg3nuGen6P0PZEfxlyLT3g4eEW32sNH5KvUauoxpZqvniNNUbWdz5d8tS2Lx2xlCFxEQkDQiSY17w91cqLyzd//kh3NeFopHe11Hrz1YaoydPWUeATPfH1hX6LWwI2g8Fq8PY/HcIjee11qIkUyDEaRBFXreZOTFe1+I3Z0tRrI+S06Elaljh59tyWFeyHxD/Md5zqJ+IBFi4M+wc/igQ+dOGNSLQDDe+PaMebCSPrFpe5toTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iVCOgViYU2c0qw0VT4h51estQGFv03+NVyesK3h1azM=;
 b=r7BqIKE1+XUd/iyATepuLCN7Ic2723gwxa4/ZlHnikQ+JhrWA72Pz4uL2jzafw1C4dawmJemOkrzYoLhFBAn3p3GWtR4YehjZJCtufMMkvn59hcyzySOE0MTT0I24SnDoT1ZPU7wg6XV+nx1vW30zcCDCRJY+1PaVHRChHRbTYU=
Received: from DM6PR12MB4603.namprd12.prod.outlook.com (2603:10b6:5:166::11)
 by DM6PR12MB2986.namprd12.prod.outlook.com (2603:10b6:5:39::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Fri, 5 Mar
 2021 06:47:37 +0000
Received: from DM6PR12MB4603.namprd12.prod.outlook.com
 ([fe80::69b7:e163:347a:ba70]) by DM6PR12MB4603.namprd12.prod.outlook.com
 ([fe80::69b7:e163:347a:ba70%6]) with mapi id 15.20.3890.035; Fri, 5 Mar 2021
 06:47:37 +0000
From: "Xu, Feifei" <Feifei.Xu@amd.com>
To: "Quan, Evan" <Evan.Quan@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: correct the watermark settings for Polaris
Thread-Topic: [PATCH] drm/amd/pm: correct the watermark settings for Polaris
Thread-Index: AQHXEYhfe3qUypZJAEe4wQpSy8tu0ap086uA
Date: Fri, 5 Mar 2021 06:47:37 +0000
Message-ID: <DM6PR12MB46031403ADF0E4C67C523586FE969@DM6PR12MB4603.namprd12.prod.outlook.com>
References: <20210305062517.583041-1-evan.quan@amd.com>
In-Reply-To: <20210305062517.583041-1-evan.quan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=66e52e69-f4f8-4293-92c4-26843ed68918;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only - Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-03-05T06:47:11Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d0d5ef4f-d772-4a63-ccb9-08d8dfa29088
x-ms-traffictypediagnostic: DM6PR12MB2986:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB2986AA6BB8C28B2A44ACD994FE969@DM6PR12MB2986.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wWMSF+1dQ1TUWByUmR7V88N1PIoeAZdZYCeNqgPHN/vvehhnmJAsCbYFsZBCmqkmQG3kNKm8krkJ1EckVFwY3S21NQtrI658cWRtFjtTI25ygAJ+A9T4aj2jnSI2ruU+UC2nBml+eAqxTzJHXtTHCA3ugGueQ00nisS3gPbZRtfOM47xcGsxfkVrDCSlFUuXWfNID+XG4xnO4BG8W4+nIHMiuHz0n04+tYQKELEOPfuSpOwO1ixYxul64frlLaqCZ5/FKbsl5esOR9tNlaUZ1dXIK3ZxU6lVuQaYEWan3Z9w2IzP3xdpvMsNdzQonnFUNMiPK3GcBYgaj0CM8Ida0uawHlcWuMJl4vZrSS8bUYwxZGrjwc2ryCaWKPTi4ZD22Z1pyZMdT9yPyNsI8UJux/unoiuNHVnfpjxe9eNpAyTYFyspFODx/9fzcQzIN1Vb+OcR804i/2loMAhSS4ODm5k1oTgZdDprziToJzTzlhT+1YfYltu5+MwB4Rb5yLta3HjzeDlZY1DWrmHsqufnV13SnentUM0ts9/qdnoATSyIK/zWTipBHkaucBE3p7An
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4603.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(366004)(136003)(396003)(376002)(8936002)(186003)(33656002)(45080400002)(4326008)(71200400001)(8676002)(76116006)(26005)(66946007)(64756008)(110136005)(66476007)(66556008)(66446008)(9686003)(55016002)(316002)(5660300002)(7696005)(53546011)(478600001)(6506007)(966005)(52536014)(83380400001)(2906002)(54906003)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?gkOsYIJWIVo1ZJBa3LxM3wtJ+D2OZToMkx6OGO1vT3dfupynT8yNEvDWF3Mr?=
 =?us-ascii?Q?LTrA98ROOs6HUYudm74TaSBAH3PnEyDRWnngxj9UK+Oe+AIY/9VHyrs70p21?=
 =?us-ascii?Q?1C8++Sor5BXx+3jcwd9wFiYlhJnuzlkeDI4uY5loElFUzbyvXfxRDd2tlqMq?=
 =?us-ascii?Q?7JWEKwB2plVMPt4MqnNI2KWbA+7A1z7i0m4X9knZA++6vDRhR7BORd6F9A0y?=
 =?us-ascii?Q?MUDeLQBW4c2+ty3EcFNaTLwQ3JW6RQqSyp29K6lAEqGac2mEWwou+eW4FbRk?=
 =?us-ascii?Q?2fgMcJ3c2pe9ddx+IgdBFQkvEbchc4Ok5jJ8aMmcGqVTfpT1cSOX+hPiPiEG?=
 =?us-ascii?Q?IyOtDa+4j2QTTkcow872SBEZRsKOMgo9ZAYGNVvM7bdvNqOaf6sGzSEtNzds?=
 =?us-ascii?Q?1e27vtmRvtWssBiUVIoAhftstcT5JzCpaQvVFMOL0xGEI0ezWkYMtHg1Kvjo?=
 =?us-ascii?Q?xaN0XUWuO8nZ6lrUwftDeUgWN3Q7JJeySsXHmRqXuT5YsSCir/lYTo82BJfq?=
 =?us-ascii?Q?yP7GjNUDmz7tgEPUlkGMgz6IS+7Vx4gFCR/U2WooLpGtLHBuacwutY7664rr?=
 =?us-ascii?Q?1sRh2v9x368TsfClVBPq6O8ESlz3AFJKwOuioAh8NPkODloEh2ii2qYooccz?=
 =?us-ascii?Q?DTvB+9q3wSJXDcywmh83GN+pKt1sovdn7u8QkqL226j8deKEqnhVfdDCXzbn?=
 =?us-ascii?Q?IMJymvn3Fe5lfjmIoZz7YBX6fGtCVYA6YfNXiOy9TLpHRGKMP9rluikEcqyE?=
 =?us-ascii?Q?ta5xC3CpsZelsW7EbvlU6e0cx7gvP9XZiJjy3KMf4SOnHgbrBcEmLPfwhSHj?=
 =?us-ascii?Q?RVGF7YJrJlVH5+QHnEteKlvN7WavGyQMz7pgjxs0u4yBwsZQ/R9j3SOxY5nF?=
 =?us-ascii?Q?Smy+vbcTUA4ava1mKWVxbXuDvh+/fxTEaAR/ji0bV6FtRgkuhzXp+jmwzzvD?=
 =?us-ascii?Q?TPC39tKfZ+nmQatl2JFGD84pkAXtuSrBeS57kvsD+AMBGp/Nkck5AmMvUOAL?=
 =?us-ascii?Q?1vEeaCU+tLZ01mrDnFiuYL0+bz37A+hkWgBhEmfiDkB2BYE2ApsmXgQzl5PV?=
 =?us-ascii?Q?PUBXv8G5ttVxku2h3Uv1hdhfcxsRr23eMv2xUm99x0HrBbMjSFxSPUgy6iUC?=
 =?us-ascii?Q?ZTCXiwK5m9Gp8iXNFa93G4FmcQScSXsp3wPzVjVDnHStx9Fsbh5gow5d/fnm?=
 =?us-ascii?Q?tqjjxZ/BuYaGFMxJ+JCKlTxAYavjBNTh7YHn+r5pNXlczujsX/U55oqXT841?=
 =?us-ascii?Q?VjmGHVYUWzI5RfjwwOUrf/rcl2KQX7FcWcKzRVlG4iZmZIoYte5stzSjAidJ?=
 =?us-ascii?Q?UdViJjUXIw8QKZIiQHbTySYL?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4603.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0d5ef4f-d772-4a63-ccb9-08d8dfa29088
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2021 06:47:37.4536 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8AAnZKV2YDHXnIj23/8UpCHeyKsUfoAEN2J32G4/uM2DwvG7OBZXCp7i+g+TDy9C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2986
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Georgios Toptsidis <gtoptsid@gmail.com>, "Quan, Evan" <Evan.Quan@amd.com>,
 "Chen, Guchun" <Guchun.Chen@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Evan Quan
Sent: Friday, March 5, 2021 2:25 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Georgios Toptsidis <gtoptsid@gmail.com>; Quan, Evan <Evan.Quan@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amd/pm: correct the watermark settings for Polaris

The "/ 10" should be applied to the right-hand operand instead of the left-hand one.

Change-Id: Ie730a1981aa5dee45cd6c3efccc7fb0f088cd679
Signed-off-by: Evan Quan <evan.quan@amd.com>
Noticed-by: Georgios Toptsidis <gtoptsid@gmail.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index c57dc9ae81f2..a2681fe875ed 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -5216,10 +5216,10 @@ static int smu7_set_watermarks_for_clocks_ranges(struct pp_hwmgr *hwmgr,
 for (j = 0; j < dep_sclk_table->count; j++) {
 valid_entry = false;
 for (k = 0; k < watermarks->num_wm_sets; k++) {
-if (dep_sclk_table->entries[i].clk / 10 >= watermarks->wm_clk_ranges[k].wm_min_eng_clk_in_khz &&
-    dep_sclk_table->entries[i].clk / 10 < watermarks->wm_clk_ranges[k].wm_max_eng_clk_in_khz &&
-    dep_mclk_table->entries[i].clk / 10 >= watermarks->wm_clk_ranges[k].wm_min_mem_clk_in_khz &&
-    dep_mclk_table->entries[i].clk / 10 < watermarks->wm_clk_ranges[k].wm_max_mem_clk_in_khz) {
+if (dep_sclk_table->entries[i].clk >= watermarks->wm_clk_ranges[k].wm_min_eng_clk_in_khz / 10 &&
+    dep_sclk_table->entries[i].clk < watermarks->wm_clk_ranges[k].wm_max_eng_clk_in_khz / 10 &&
+    dep_mclk_table->entries[i].clk >= watermarks->wm_clk_ranges[k].wm_min_mem_clk_in_khz / 10 &&
+    dep_mclk_table->entries[i].clk <
+watermarks->wm_clk_ranges[k].wm_max_mem_clk_in_khz / 10) {
 valid_entry = true;
 table->DisplayWatermark[i][j] = watermarks->wm_clk_ranges[k].wm_set_id;
 break;
--
2.29.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CFeifei.Xu%40amd.com%7C629b5ae589cd43f4506f08d8df9f80d2%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637505223446156243%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=I7hiICVKpvwlZtmT302%2BLJJPo8RLa6yu37EuJDOotHg%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
