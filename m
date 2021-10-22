Return-Path: <SRS0=y7aQ=PK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958E4C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Oct 2021 02:15:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FBF06138D
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Oct 2021 02:15:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4FBF06138D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B49CC6E526;
	Fri, 22 Oct 2021 02:15:24 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8E006E511
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Oct 2021 02:15:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MlFk9QOj+YW3JO2xlWgnVZXQgHzO0J96O45kqDfG+o3/ocMDPZ7dGQpc5cm62mDyYDZds1TCyE0O5PZQHFEqmtcvLJv19K+mj/054n27Us5NFElSXmMXBxrUOwVxzHIUdK+VFI178TVak5GbzthKtrJr/Tr0ifh77iW1A7dwi8NdrK0zlzWlO/6N3kIVcDvlYG359H5fEO7aRrGDc82Ym1baENu0z38zzCtKCYFlPTc1MhMXb7O0Y5C+QyEzipQ7S3Lqo9IQxbUI5ntNHbl3tIFruEDdhFC0AX23Jliy3ak4E8/ymu6QkZ6SSaAWOUN71soIXfjQ/MH44YS7YiPBOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Dt3nCO0Q3Q4xi4lfWGdzigFx+Z91ngnk0UFLP26Rto=;
 b=Dz+gHJmcjT49IbjGQSLLQ2iJscguJdoEI6OawRqo6RZ08q+iY5DhhhB5Ut0HOeBkGxtjx3eB0bvGTiTYe6wwWjOmsfSBcXscc7RLJB3NHQacC+V6b5maqvaojmoc0BZz5YbsuLu4wGMizzSTob2Bmf23zGJCbYrJezSLLzZwJL4x7y8ySHRrvubhGKfFZMuCwi/eMcE7refaFxBA6C2DfvaWPZq4bvJHjujGdoB0SUih/JmTfGZNa/HXwYeJfwOAlfjjuiT9SP0s3GSCFL3vCXZIn1G3sYVQazmyAm2ma6dCEcqQmNc9ECE6HTHE+AqydC9KcB3MCrAPpONy32ClgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Dt3nCO0Q3Q4xi4lfWGdzigFx+Z91ngnk0UFLP26Rto=;
 b=a6xt2QlTYTsYn+WowjoXNUCaauGQL29R3uBnpJbUaWCwFMu/Vua6yChzZZifC3JxEoH21ak/8NV4ZBWRY/Q+vo7qFKX5J/jJhaeWK9x0v21IqXQQKoULP5r7Kzcp/eNvyvt36Gdym+2ViUb7ULQEFYRwEtfVkvnqqr9I+ByUz1w=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 DM6PR12MB4941.namprd12.prod.outlook.com (2603:10b6:5:1b8::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4608.18; Fri, 22 Oct 2021 02:15:22 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3142:d7d2:56a7:7c45]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::3142:d7d2:56a7:7c45%3]) with mapi id 15.20.4608.018; Fri, 22 Oct 2021
 02:15:21 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: Workaround harvesting info for some navy
 flounder boards
Thread-Topic: [PATCH 1/2] drm/amdgpu: Workaround harvesting info for some navy
 flounder boards
Thread-Index: AQHXxsXfnEzLpIdewE+1tZhfcDi3f6veJ72ggAAfxsA=
Date: Fri, 22 Oct 2021 02:15:21 +0000
Message-ID: <DM5PR12MB24698A99BFCC7CAB657BAFACF1809@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20211021215134.224476-1-alexander.deucher@amd.com>
 <DM5PR12MB24692ADBF61EA1E62739DF3DF1809@DM5PR12MB2469.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB24692ADBF61EA1E62739DF3DF1809@DM5PR12MB2469.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2021-10-22T02:15:18Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=f0dd7db6-f97b-4cc7-8d37-79a542845258;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9e3573d1-aee6-476a-87bc-08d99501cd2c
x-ms-traffictypediagnostic: DM6PR12MB4941:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB49412B9CE69760CBA83DB006F1809@DM6PR12MB4941.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1079;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dS4qUZWBpD7XyEG+EOOGkyDgm31RwlkCfApmUMvG7xjP4S1lJs7qXJhg4AXUBF36d66sXlVnfQj3L9P5FgkvhYu1BgCU+yBTVqW50sPGjoLXaSqhZ8RYtUVEp/IereAnf3alPngxWkJP3tdK3L5B5xOFPBhJgKgcZpvCyyMDrM2esWoHGMXg8xzkAAo4TgoMI9CL7sWaeSK4hzFrgrgKaMyBddQMHAuudeXK/ODvzSsD1A6WbUcgyt2tgGacaNZorWAkDx91Zplgg8fXiwgSSqli3SwIfJR8m2LwYptTCDR3BWUHZuV/Lt8ou12P5Sd86ArXY/VZx42NeIZTD5fAB5nMzVhEfHnGWPG6wdpI7KY3wUHCZzOpHCOOU0KwHxGwJdNkUJBEGqxIQlIyS06oJueiyOaoXiph5pqnepOg+cEWyLzOj9NW6SM6WetwWaxtYZm06zlC3vzm+y38VFxnnbcFWA1gIuu3u2+Mq0sD6mAswubb64wR2XE8HDQOKBhR47JyY0IBdZDl4EgTNdPr36zeelCQBYUKuqHWJHWu7dfjAj4E19FqDncgMs/cNiyak7dUv4UptSBywXs6dvf1evKgcBHw24PGVvai8NNLMXSallMMhDyzbdiK+FTAnaP/+qRAha4EDxhsT/UNKyk1mznz+cX52fNuLuMAZoCZWbm4eRnc4VdsCOi6aH5lhH6tpy9HoGns3ATG/GlhAi+tLQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(9686003)(508600001)(5660300002)(66446008)(8676002)(2940100002)(8936002)(71200400001)(53546011)(33656002)(6506007)(38070700005)(966005)(52536014)(122000001)(7696005)(66946007)(110136005)(45080400002)(64756008)(4326008)(66476007)(76116006)(2906002)(55016002)(66556008)(86362001)(83380400001)(38100700002)(26005)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MvEnvSLD1J/jXTvJ5vJFfKH+roJx3H78knL0273I/UTC910Vb27+/Jx5R9XP?=
 =?us-ascii?Q?03p7Bw4pVk0EtQd4dpqLjqcWi5ZDcDPt3ilfpSpdoLG30ak0vyb7bvWAkZKh?=
 =?us-ascii?Q?yO5PaBu0K4Wr/4KPxbVaYS3Qmm/hq8LCtY5OS3spdXzbAIGYOIddJardezGo?=
 =?us-ascii?Q?cDcw9qFSzoTR1druUvq/oRII1ncNuVgOboJqVbvKqa0Jz/s4mG6Oom0cm+Ir?=
 =?us-ascii?Q?obroW6eZtahljaFYapvAdSPoNJYwbYrOsXrOckBTQPVgnH4Rv8bx89zfw8ai?=
 =?us-ascii?Q?DzP2VSLIbEwBYSDz2nKPdDISCvZTTFLvXY1oVZDvp+P4DYgwUkSywpPIsmyV?=
 =?us-ascii?Q?qHYBDDslCtmOBfaJ0/Rm2Fbj0M34zJiTPAA16DEC24Ge2VuFRXBPdzQhdVj2?=
 =?us-ascii?Q?aAU51jxKu3q4sVeopXM3zj36mKmftEAAsr5OOhCCxqx1LNRY12oOVHGSMbiT?=
 =?us-ascii?Q?YfqYJRjylQveMb66GpV67nIjIqBIbDsQB3f69e/eT2uFs6niEf4q+n+Bl6Ot?=
 =?us-ascii?Q?gbF9Toh4rSaG1GvFuatMArACs0SYkPVJAo0YVeMwxxo7HeEKfm7HGJ8AJ4R+?=
 =?us-ascii?Q?1jtI3Hx/QXmPIT98izdsmCTISBz3s1T2kr4pz8K7Gf0YuMXiII2zMQS8B3sZ?=
 =?us-ascii?Q?8J7qTTDco/3OC/Oc2kicDvwOpF8k8YCTUJLXGv5wM3vzdTSBVOUNJyXTZ80W?=
 =?us-ascii?Q?H9Rj5XjeMaishWbA3jKzkKO/12YP+XjMgAeLkMwGH7+YFl6ldhSwYc1yLTJs?=
 =?us-ascii?Q?FsmmSnF+Awo8RI6YMFVGXBqKn4N5TTX6Ro4Gu15unBvVkbogpFNOsgiQ1CP4?=
 =?us-ascii?Q?AMCe4zthvTP+6XcLGy68yCu3tN3vt660FMnUBpLAP7AoNWbaFyDFohNqPUii?=
 =?us-ascii?Q?9MVy0YCDjiUEvxJ8WKXEOM2fk1TClpPoTcFSSoK4jO/qXdq7+WlWV+9cltIw?=
 =?us-ascii?Q?4iWQ3MGBkosZq6HmBn5FhnYseYbAynkhNnDBt4Ykjn6ekagWvsS5Ltg9FlLX?=
 =?us-ascii?Q?3kjnEmeUnAJbt+Wgqf+Q/iTdcxLZBiirmgNSv65RwkYSDpg/6HLKv3h2Asrh?=
 =?us-ascii?Q?S0s8KveFUe44a1Sypf0MGRYEsa+wR2p0LsGGJY7E7XaC+MIRszQsZn51v7Ag?=
 =?us-ascii?Q?VgpHGxxSQ8J9TVk/SwGSaWwDAqm3wJbOpt6L7U6dYOvXU8tP+CWtesgZANGS?=
 =?us-ascii?Q?7Nr//4XqFxg5GFNUqCJQ/BZjDNFByaK+05/CTJNokHoBTjCt/hHSBU7AJHIv?=
 =?us-ascii?Q?ge/s7yvYxkpW3i2gxSZ4O48QZxSBCByKuRA4gsI5+kNO7XkikEWGQ66jdAzM?=
 =?us-ascii?Q?b/Eek4Ierh/8fU5jC2EHeDsz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e3573d1-aee6-476a-87bc-08d99501cd2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2021 02:15:21.8280 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: guchchen@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4941
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

[Public]

This series are: Reviewed-and-tested-by: Guchun Chen <guchun.chen@amd.com> =
, on top of "drm/amdgpu/vcn3.0: handle harvesting in firmware setup".

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Chen, Gu=
chun
Sent: Friday, October 22, 2021 8:21 AM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-gfx@lists.freedeskt=
op.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: Workaround harvesting info for some na=
vy flounder boards

[Public]

I will try it.

Regards,
Guchun

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Friday, October 22, 2021 5:52 AM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Workaround harvesting info for some navy f=
lounder boards

Some navy flounder boards do not properly mark harvested VCN instances.  Fi=
x that here.

v2: use IP versions

Fixes: 1b592d00b4ac83 ("drm/amdgpu/vcn: remove manual instance setting")
Bug: https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgi=
tlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues%2F1743&amp;data=3D04%7C01%7Cg=
uchun.chen%40amd.com%7C80a3316b28a64ff87b1e08d994f1d6ec%7C3dd8961fe4884e608=
e11a82d994e183d%7C0%7C0%7C637704588695008369%7CUnknown%7CTWFpbGZsb3d8eyJWIj=
oiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sda=
ta=3DOc66Y7qakmiS3UKOytgTY418mtBRs%2BCEnesLpwTAyIA%3D&amp;reserved=3D0
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_discovery.c
index dfb92f229748..814e9620fac5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -507,6 +507,10 @@ void amdgpu_discovery_harvest_ip(struct amdgpu_device =
*adev)
 			break;
 		}
 	}
+	/* some IP discovery tables on Navy Flounder don't have this set correctl=
y */
+	if ((adev->ip_versions[UVD_HWIP][1] =3D=3D IP_VERSION(3, 0, 1)) &&
+	    (adev->ip_versions[GC_HWIP][0] =3D=3D IP_VERSION(10, 3, 2)))
+		adev->vcn.harvest_config |=3D AMDGPU_VCN_HARVEST_VCN1;
 	if (vcn_harvest_count =3D=3D adev->vcn.num_vcn_inst) {
 		adev->harvest_ip_mask |=3D AMD_HARVEST_IP_VCN_MASK;
 		adev->harvest_ip_mask |=3D AMD_HARVEST_IP_JPEG_MASK;
--
2.31.1
