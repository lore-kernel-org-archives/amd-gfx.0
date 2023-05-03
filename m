Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56A6FC77B7F
	for <amd-gfx@archiver.kernel.org>; Wed,  3 May 2023 15:49:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0B0310E30D;
	Wed,  3 May 2023 15:49:08 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::617])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5427710E30D
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 May 2023 15:49:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ekYn0MUWWilK1OxawxeNlYpLN6QNg6FYa6enDt27lcOGKc4PVmkFS1n2cRolYtpwkGBqP5oSo5q7t0QcATvUOSVZl4Mlv0b1Sc1tkVCTZYt0go/DdVyJxjkUyGO09nkWNJkszpwjsoRv4IQkkzGqFfxW1dA7mPkFixprBmymO38kd3YkWjUDEiAdD4DaQBnYLU1ORfFD65ONcGskVOy1RI9JSjaDY3fXpt6gj2DHMUsQm9W9gOQTJ2ImaEBRc/FDHEF3tkLQqDJut5EGhrZEY5oZd5H/qSIgPnWCgp2tsId6B2kafBhRFSq/ZG8cG0ZmNCUVesW13d/nPDxo3zNpdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7EDW5qyJAQ1GnCHYXRGAOMR6m3w1Q2RWwVuB/IZiRkg=;
 b=CgnbXcQCSlmWD/2oO28pqUcOsaKE4RsAg2J/Yoc0+vXGAqzEeARzvWffFZB54qSAv3r139uJEpYVsCgQu8aYVY4BXiCsusAKSjiAWcaepttQ6d7JD5plu9/SCGwG02sBB6aGZ14Si/Xli4CK7ccf1Rt31402d7zvLaqgafupU02deDQ1uLtETVpj3TIYCqCHL6bLKWmEx65hoKfn/UACyefbbhTk0HrThkClDZY9QUxbTJ++K9cEYmDhnzmTHSn216+0dYe9+hAUZiuyOj9KUSPZQ6nlNAIqwes3OKH4+n9+QIqLFXM0nqP03iM91BT4bbvutQmKzXWysUkFVEnDAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7EDW5qyJAQ1GnCHYXRGAOMR6m3w1Q2RWwVuB/IZiRkg=;
 b=QglS5cYI0uOAugOrQ9ZASH7mQH/w8pQnp1M3HRGNjJIiP7D1GLv7/VtbeGc0fXxbKqae/VLeMg6DUqnqH7uKUpNol8l7FeMDCEuCO34zKcFMic7FPvkZ5FOATZ9wR5UpXLadAfvSIoINk57Rkkjo88ZQUZzBJtYxx7ZB7q5/Ogk=
Received: from CY8PR12MB7099.namprd12.prod.outlook.com (2603:10b6:930:61::17)
 by SJ1PR12MB6339.namprd12.prod.outlook.com (2603:10b6:a03:454::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Wed, 3 May
 2023 15:49:04 +0000
Received: from CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::c096:cfef:69c3:fce4]) by CY8PR12MB7099.namprd12.prod.outlook.com
 ([fe80::c096:cfef:69c3:fce4%7]) with mapi id 15.20.6340.024; Wed, 3 May 2023
 15:49:04 +0000
From: "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
To: "Somasekharan, Sreekant" <Sreekant.Somasekharan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amdkfd: Expose proc sysfs folder contents after
 permission check
Thread-Topic: [PATCH v2] drm/amdkfd: Expose proc sysfs folder contents after
 permission check
Thread-Index: AQHZegVpYZFNKoWxD02/ooSLXzBzuK9IuQgw
Date: Wed, 3 May 2023 15:49:04 +0000
Message-ID: <CY8PR12MB7099CA7F5DE0500241D8A6408C6C9@CY8PR12MB7099.namprd12.prod.outlook.com>
References: <20230428191219.533646-1-sreekant.somasekharan@amd.com>
In-Reply-To: <20230428191219.533646-1-sreekant.somasekharan@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-03T15:49:02Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=09d2dbe8-f0dc-4802-9b35-d7b7637f1207;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7099:EE_|SJ1PR12MB6339:EE_
x-ms-office365-filtering-correlation-id: fb8fbbdf-b227-40c2-2a8a-08db4bedec17
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CfdE426gHxfFGwW/M0xJqc1PtviBYmpsR0rJ68LkwfL5LZ32wq/tDP/Dwto5eCoLbzRMDPH7IehOOcXXz4ffiMHq8nBByu4KUDLLegHPZFTR+bl3PR6AaKSUXJEr8yv+0YllkYyPFGPV95jpCnfGgBrV3UlP7gc2nsqVnJyG3daRiR5Jnxf9/g3BRotwSoEab4Dxw0rUrWTWcanagnwBarXKuVXtfKjwSzrLwLvlp8IQu6Jy1Pzn5K2dAeHnrK0FRnip6IY6801GsmLctLSOtvTkfDj2QgKgI8l/lctt5763cqnDAC7sdJXe8LWxR0pJ2R37OAWe7x1GXr5dbYxW5DaSIgMNZozsEO9sG28MxvoXa5xR99HmgVXIPhTI19sCQCwvyUPSHB4dVGmGRwBn94ad/HW3sKZJa0NM2iFVa/rXdq1J8258WTTTbIphM6QK0nuwiSsFcSQK0pi4Hk9gyS1ukQN7qYgTsotzWeDORZEXfdX8N3uu1LIJqOw9lfKdFP+Mm0WMvNQsyCaRa5efs9PL667JPPB2ZlHFF4mpbXq+wKvKFwI+H2DEbHGs5WW6s25iwfp0cbieqUppjrmHmVadLxsLcQt2K3r2pZ8jy3gvvqdVultVcCPdKREWyTsE
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7099.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(136003)(376002)(346002)(39860400002)(396003)(451199021)(26005)(9686003)(6506007)(53546011)(110136005)(38100700002)(7696005)(316002)(55016003)(122000001)(41300700001)(33656002)(52536014)(5660300002)(8936002)(8676002)(86362001)(66446008)(64756008)(66556008)(83380400001)(66476007)(76116006)(66946007)(4326008)(38070700005)(478600001)(186003)(2906002)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qu+sxtXZZ8QMdhuMaDY5VGDfxHpBZhqizUEtTqQSvX1hzIC4UrhDXsrKdVEA?=
 =?us-ascii?Q?CBDQGvXeQEVb5CqP+kFYq6a9fHTHXoYH77Xr3EofQBTorefPoYHhcnwKqYhT?=
 =?us-ascii?Q?Q7ydIiHQ//sQLO96h/M/Qes260wYFlIu3Dnm/pNe+ThF3IZQ20k9OeINwAwy?=
 =?us-ascii?Q?uXzcsfxx1l8ANFIrqqymkmSsiZJIVxD3Jg4kDXqF4mga7VP/NApe69KVVoQ6?=
 =?us-ascii?Q?UzX2yNIu6TvJDbM9gpMFvpJAqo7Wc0iCD+oNCsxwWWK2eGV7VvLnqsTt8aPY?=
 =?us-ascii?Q?u9ohDpBdauiAhYggiJFN32R/YrW+VGN42Wo0BZtjvNK3o0jWAFK0S4qq1P+5?=
 =?us-ascii?Q?asoccHr7ltXK78RHG7MiGbHH2q+LKEVD3Pqu1Orvb0ifdHufb0+z4sVKGzbt?=
 =?us-ascii?Q?lIHjTUpT1DgcS2fypQ/m8a5rlahVP4nIoVpcQmdeN9dGBpkVPk+Wt5AV6CYb?=
 =?us-ascii?Q?GyKOJn1LFh+9exp44FDS1yAcDL4H32k41qQkzpgN+en272RZazh1XN2b1kEp?=
 =?us-ascii?Q?d36jGz/J3GSaUDKiU3pLyj2yMoHW9hMbXYoOnQnEfE3VCg0MrMo/bOfYeNEW?=
 =?us-ascii?Q?tF0+pOsuB9zwfmgG0fbjGAGc/b2IRWLQ3UJMuxq14mEBbfYsVPu2s3x80c55?=
 =?us-ascii?Q?UUHII9xOYiERdNhLOYX9jvcYRQXdcMgZbqUscIrQS1wxiGUrp+kf5dAxgSK3?=
 =?us-ascii?Q?LFXtfmdcXV3DDXuPnjTjPVXmsDgLTDCBMhdpxM1VBeeQw1/FU7ZxRqSMqIDX?=
 =?us-ascii?Q?h9+4Ql+4FXFc+sSF009AhftcspWj9oAqliHzYLA+fhuAHC/TpkqtI1/Hvjrc?=
 =?us-ascii?Q?eTxwCZmofFq0059XUn+Dje8yyh4VB0fM13g6ahZTseecNmEsTpu+oczdKRFz?=
 =?us-ascii?Q?fKgLqaPTRwJN+ofLeRDQ8BGbcj5uzmjJRb/Z12TGa8fyT7csxYore4wcSQxo?=
 =?us-ascii?Q?XDJ1xc/BI2B0CXWZAKBJbYrvVFtc9V/QUD4NegHm4pGzRluIyGtLOnsyiRJn?=
 =?us-ascii?Q?gY/mPNdYkAErPPO5lixH2tjhnvYb8tx7XfsBpxKZuhoLA3fZ+WovWc8xsw13?=
 =?us-ascii?Q?Tf+nN8i817dbhXSnpkrtO4vtAIPp2Hotr8diEbrNcZuVVUdANDvvH5KaistX?=
 =?us-ascii?Q?mgfbicm4bmB4ApePGesQmRUlZMt5jOZLSQnWS3nkxFpPLjljdMQwPH1eKsPO?=
 =?us-ascii?Q?df5V2XeyazL7H5YOCOuWztc90tSNr90Y5qTyx48HShZ4R/kXn8O/NQr+pyOz?=
 =?us-ascii?Q?urS4qfNbsuG5CBlnQWSXcfx2IDEhnHiaXsrFb9lbSafWSWgmv9RZH1wg9NbS?=
 =?us-ascii?Q?cBJOMaxosH26iyHeCwi/x9jPUAi8ftm6dlwLa98IUSKAz3oVzNSQ0XEjhYBa?=
 =?us-ascii?Q?bGdkwt+qlUX77vOb3PQxvOpNmjoSRqAZD3rB6tBac8whqcWkAi8DbQnStPOY?=
 =?us-ascii?Q?W65+NqU3lML+Ha6L3RqCZVGPVmavvI/y7GTZ8fnRc1PTHbU0rzxF+Kjzk3p2?=
 =?us-ascii?Q?XU8bpzldJkNh2nwkCZ/ykusplaZx6vcsGqDaGrU0ksK/AsYJWlzQpDhqb8Ek?=
 =?us-ascii?Q?Tf/5nkrGQ+s/5kEnZP8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7099.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb8fbbdf-b227-40c2-2a8a-08db4bedec17
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 May 2023 15:49:04.2963 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pbjl1C24hT9WUOLmU3bGh9jX1zu4WxtfuPtu14ffBOc8NZjJ+1Kw6VeOrdm0uK7ovxxM3fKX3F2ZhMKUH3OGwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6339
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
Cc: "Somasekharan, Sreekant" <Sreekant.Somasekharan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

One minor comment inline.

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Sreekant=
 Somasekharan
Sent: Friday, April 28, 2023 3:12 PM
To: amd-gfx@lists.freedesktop.org
Cc: Somasekharan, Sreekant <Sreekant.Somasekharan@amd.com>
Subject: [PATCH v2] drm/amdkfd: Expose proc sysfs folder contents after per=
mission check

Access to proc sysfs folder/subfolder contents are permitted only
if kfd_devcgroup_check_permission() function returns success. This
will restrict users from accessing sysfs files for a process running
on a device to which users has no access.

Signed-off-by: Sreekant Somasekharan <sreekant.somasekharan@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_process.c
index 95cc63d9f578..8ff505d29bb4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -275,6 +275,8 @@ static int kfd_get_cu_occupancy(struct attribute *attr,=
 char *buffer)
=20
 	pdd =3D container_of(attr, struct kfd_process_device, attr_cu_occupancy);
 	dev =3D pdd->dev;
+	if (dev && kfd_devcgroup_check_permission(dev))
+		return -EPERM;
 	if (dev->kfd2kgd->get_cu_occupancy =3D=3D NULL)
 		return -EINVAL;
=20
@@ -308,10 +310,14 @@ static ssize_t kfd_procfs_show(struct kobject *kobj, =
struct attribute *attr,
 	} else if (strncmp(attr->name, "vram_", 5) =3D=3D 0) {
 		struct kfd_process_device *pdd =3D container_of(attr, struct kfd_process=
_device,
 							      attr_vram);
+		if (pdd->dev && kfd_devcgroup_check_permission(pdd->dev))
+			return -EPERM;
 		return snprintf(buffer, PAGE_SIZE, "%llu\n", READ_ONCE(pdd->vram_usage))=
;
 	} else if (strncmp(attr->name, "sdma_", 5) =3D=3D 0) {
 		struct kfd_process_device *pdd =3D container_of(attr, struct kfd_process=
_device,
 							      attr_sdma);
+		if (pdd->dev && kfd_devcgroup_check_permission(pdd->dev))
+			return -EPERM;
[HK]: Move the if condition below the following struct declaration otherwis=
e the following compiler will spew the following warning
warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-s=
tatement]

 		struct kfd_sdma_activity_handler_workarea sdma_activity_work_handler;
=20
 		INIT_WORK(&sdma_activity_work_handler.sdma_activity_work,
@@ -379,6 +385,8 @@ static ssize_t kfd_procfs_queue_show(struct kobject *ko=
bj,
 				     struct attribute *attr, char *buffer)
 {
 	struct queue *q =3D container_of(kobj, struct queue, kobj);
+	if (q->device && kfd_devcgroup_check_permission(q->device))
+		return -EPERM;
=20
 	if (!strcmp(attr->name, "size"))
 		return snprintf(buffer, PAGE_SIZE, "%llu",
@@ -402,6 +410,8 @@ static ssize_t kfd_procfs_stats_show(struct kobject *ko=
bj,
 				attr_evict);
 		uint64_t evict_jiffies;
=20
+		if (pdd->dev && kfd_devcgroup_check_permission(pdd->dev))
+			return -EPERM;
 		evict_jiffies =3D atomic64_read(&pdd->evict_duration_counter);
=20
 		return snprintf(buffer,
@@ -427,16 +437,22 @@ static ssize_t kfd_sysfs_counters_show(struct kobject=
 *kobj,
 	if (!strcmp(attr->name, "faults")) {
 		pdd =3D container_of(attr, struct kfd_process_device,
 				   attr_faults);
+		if (pdd->dev && kfd_devcgroup_check_permission(pdd->dev))
+			return -EPERM;
 		return sysfs_emit(buf, "%llu\n", READ_ONCE(pdd->faults));
 	}
 	if (!strcmp(attr->name, "page_in")) {
 		pdd =3D container_of(attr, struct kfd_process_device,
 				   attr_page_in);
+		if (pdd->dev && kfd_devcgroup_check_permission(pdd->dev))
+			return -EPERM;
 		return sysfs_emit(buf, "%llu\n", READ_ONCE(pdd->page_in));
 	}
 	if (!strcmp(attr->name, "page_out")) {
 		pdd =3D container_of(attr, struct kfd_process_device,
 				   attr_page_out);
+		if (pdd->dev && kfd_devcgroup_check_permission(pdd->dev))
+			return -EPERM;
 		return sysfs_emit(buf, "%llu\n", READ_ONCE(pdd->page_out));
 	}
 	return 0;
--=20
2.25.1
