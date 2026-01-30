Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37F49D73EBB
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jan 2026 04:31:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9012210E0BB;
	Fri, 30 Jan 2026 04:31:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J2+5Mu2p";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010008.outbound.protection.outlook.com [52.101.46.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4623F10E0BB
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 04:31:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=INnbwi1TgFA7LKAUZVEGRpGr37mGDY6qpUHRfhl39uO/I93D1amoc/U6oRccTULBRU+tUp4GnBCDbQU76GcdHwygqg7KgxMVZLSEOUgT5HTAdhphaWTkdZEeYPjPk+i0WypDJXzWb3iao6Wvy/Y76BKxfPBQxDMzo6yJmpJi1RGjKDRi6DHMa5O09QOKd/20PCmBTujpEYXWmHCknBYK60zFUfi7qS2sEBWYGa4ge1yFETbTAvZ+MS7t9/hPMW1t8Bozjbteca8+uI2H1VdmOfRlYN7I4ClIcstpE7o1cjMvw5G9pmuPSwhfAIEHmuLDmFKx0eNWiOJRwP/fvkpwPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/UE/AOp92Sr2QZaZMzpyXOMqC3saVtylyMsjuAHfcc4=;
 b=JUMED2XWF+xVd+Mj3ifXUHqxGw+ERNkwunA6W0MKNjk93GyAMGNZdzZ2y9JeK8P2ube5MOrsflbZiNWeBnx3pHc4dh1juQwIi6vkvwv0H6FuUUMc1G2F1l6CNzeUYUymudNWdSkPoBy2rSVNqBJOkrAYHIGzRU0Hug6OsEUb2wvEvYMIGw43dyfEkTqyAWiBkwfP5ZsW3F/DR52y/TPcSN0QXo2jhST7NtObSvKa72OWjwiHHSv413GydU9eMuEPenHcmkKH20XUlAID+FtyZ06LH+e1jqLmTMCBuZh1XZ1GK22mohgqAImwO/TmNcT/RE26DuboFpY1BImZjw9o/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/UE/AOp92Sr2QZaZMzpyXOMqC3saVtylyMsjuAHfcc4=;
 b=J2+5Mu2pWD3QDUA7NAUmpudCTStgLXzDv7zq6vQ0NaP47MVNrRj/cD/JmbeIv35u19cL2FYH4+qQrApvQUOcX8j9TPxsLrAcPvnIHzYqeLgWdFZtl1bBZn6dBZKuwmH3wEE7v/iRtzHNnR41zkdX5JUCpQGTKPwDdlCVZBboUhs=
Received: from MW5PR12MB5684.namprd12.prod.outlook.com (2603:10b6:303:1a1::21)
 by IA1PR12MB6137.namprd12.prod.outlook.com (2603:10b6:208:3eb::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 30 Jan
 2026 04:31:35 +0000
Received: from MW5PR12MB5684.namprd12.prod.outlook.com
 ([fe80::f0a2:a7d9:42a8:ace6]) by MW5PR12MB5684.namprd12.prod.outlook.com
 ([fe80::f0a2:a7d9:42a8:ace6%5]) with mapi id 15.20.9564.007; Fri, 30 Jan 2026
 04:31:35 +0000
From: "Xie, Patrick" <Gangliang.Xie@amd.com>
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH 03/14] drm/amd/ras: add pmfw eeprom smu interfaces
Thread-Topic: [PATCH 03/14] drm/amd/ras: add pmfw eeprom smu interfaces
Thread-Index: AQHckZBwcSTKXLHFWkGZXOMXK8ijurVqBouAgAAY4AA=
Date: Fri, 30 Jan 2026 04:31:35 +0000
Message-ID: <MW5PR12MB5684FDFF4AE9ED979F97790AE59FA@MW5PR12MB5684.namprd12.prod.outlook.com>
References: <20260130022950.1160058-1-ganglxie@amd.com>
 <20260130022950.1160058-3-ganglxie@amd.com>
 <PH7PR12MB5997FA8D1435A8C68E584B13829FA@PH7PR12MB5997.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB5997FA8D1435A8C68E584B13829FA@PH7PR12MB5997.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-01-30T03:01:17.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR12MB5684:EE_|IA1PR12MB6137:EE_
x-ms-office365-filtering-correlation-id: 0721124c-cce6-4d41-ea30-08de5fb873e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?kZj7VLbJXtEmbaGmrPqZwnJ92PndVnNGpaNnQ087DtmxZPFOFhbb/CYKv9Ye?=
 =?us-ascii?Q?zZ8IZM9A4xWJqTDz43GIFP9NdyKIksYiI/2VRbiep8S/OBGivJ33RqXqNZ+w?=
 =?us-ascii?Q?UE+fw3O5p9MW5sMHohsVMeDRWfQXb5niYI5eKdUhPg7lIzGxo/Z1yDL8d2cS?=
 =?us-ascii?Q?CQEb1UNJ57a6iV5dqdgkABBU4OtKk/c2kCUbmwMIsyZdNS02s/uSBAK/8sK9?=
 =?us-ascii?Q?JP2kGZ57McHpHYEOU39j9wUU21VMkOdB1L5LiMm/78gUZuV7Z63z9DXBIveM?=
 =?us-ascii?Q?M49WiZPwTdCxTcGxPJiBEAh3KavDQcBIo+th3KkYToUzSZITBkuUbi8ZUpPS?=
 =?us-ascii?Q?N8FMm2/1jPKb4C371b2QnR7M4hPRHZC17lGSGaEfYUnNvNDolyMnRgpSmp86?=
 =?us-ascii?Q?xjWBvSoNFR/Yb+EnzoHW5ucdaQ0UvXIjD6b5q3taNA9ayeRYvTyjTxrJz9DJ?=
 =?us-ascii?Q?TbVZkwhmRrvhukISnT/y2P6CrFVB08y9kLh3v6EU9ILVkaekhErNf7TFJ4E/?=
 =?us-ascii?Q?K/XxDiLKrJQgIiMJ1ZwHIzi/hqS3x+TjvZnzX5M4BxDHluiHnFtSxAIzdVTy?=
 =?us-ascii?Q?y8Muna6xhNO1aF6vjWTCjk40bCqnrWvx+Athp3Sa2NbgrgP1PUtNYh2eb/sR?=
 =?us-ascii?Q?UALpXmpSlnErFcGbYGnYxwEmnzuwtg7ya5Frp/gx8Ksm7+La4lTUoOl9NIpT?=
 =?us-ascii?Q?nP20CxP/ftuhbQAgIOB1H7LXUJ4OS/mKc2S2ttKU7nmumpdaF+M/e1F5Yd/d?=
 =?us-ascii?Q?2CPjHPtgiUqtLx6csAh0mvgOXLK9P9ey4BuJDgxFTZbeAwv469IbUSzOUOXk?=
 =?us-ascii?Q?yHRM8upmdxv5CCryDfBy/Cr5KT82KsV6bqC7BOpcRWGQl4YxuncUfxRL72c0?=
 =?us-ascii?Q?DvB97uD3JjY5rp23ZcfOJ4KAeThswIsC3a8DuwcL8RoulgGAqzCmtH3Wnio/?=
 =?us-ascii?Q?c76mJhUjWlUfJldrOWL7u7sQnjdWdowDWnlRRIjtNzaJ/jIlWgHfXtJ/1WNa?=
 =?us-ascii?Q?3LmNZqrZbeR8NQXMXbDtQb3RCniwggLGRhnT58+MI4ceJjmjEvtikzoYX0Vc?=
 =?us-ascii?Q?N/6ANHl0GTiDfIO2PBwHJIc5m/cF5AZ+GI8pXYr4bkTUo9U8HDsp9rUHeN43?=
 =?us-ascii?Q?et6ALFSqsN4CfsiICjigmTyAndH9nfPJ+mY6WCN8f+8bJ7B4PhyrTrFXUZhJ?=
 =?us-ascii?Q?EqCkgZvT7gVFliUkGlBbq4QgQSEBIPX7XczhFiXDUrAvPpCNmkg7H0oUnmRN?=
 =?us-ascii?Q?udVaBf7pGQ3T0jr4HkHVf5MaroxWmL1v9/uPxsdar5SOHwxv1LqsDOZmNbsN?=
 =?us-ascii?Q?F4YuM92NkUK7+hMZb5Oqll5HmBCYqffX2Ds783k+k72cd/83TDO1XENAYpTF?=
 =?us-ascii?Q?tLtIh/cVXO1kgnx9WoskUPVyCYXPzH11ieJOGbN74zh49X/vh/pfRP+1pOss?=
 =?us-ascii?Q?gBjBoDngBt7T+Iof7i11PTVcYDQO6d8tnLNbJFo1DjLSBZfDNi422pdUKMgg?=
 =?us-ascii?Q?ncqn/ge9oC8uEp0Yoo+QnCAvV/O5lq2EgIa063SZN02w/UX5F8XhXhxqvZfX?=
 =?us-ascii?Q?2NAWidWrSTpdqA642m9qEv71dpzcZniJyvMQXdTjFErjp1icnfYoJc9iKhA9?=
 =?us-ascii?Q?rGD8JVMlPyXK4oALvzoK60k=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW5PR12MB5684.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xLB5T22ck0FzcH3mvEfX9zRYQxBmLk1EOlqF2bvxr+BaNVn0uJr7elnXROMo?=
 =?us-ascii?Q?v3d3d9E8h0YDe8zo91qNSBHixIHVVBL3GpsUogNrNUurLHupHxE2fIF6Aywk?=
 =?us-ascii?Q?t5JncezZoeZTXPl2gI6wvntMCt3SeHPNFDUBuAOK6XOriTxof3+6HOGAe0Ad?=
 =?us-ascii?Q?ZmTT7/IkWB6qnJmvq5QnEbXhywqgqDIGeY8zoiHdjpVVxZ9J44dmABztOV9N?=
 =?us-ascii?Q?YCwlIaxwo0R5ljrWYJNp53r3L5tg9x2rxmp/6dKuuahQc7mu8oVxm8BxN6h3?=
 =?us-ascii?Q?ygKhb72uomC8i0hVUxjEDobjCuVFV4B4neIQVmQECFAU+o7zwguMHxhSrYa0?=
 =?us-ascii?Q?jqs7ajgQJR3TbdoNK9A7+L4vnxqUpZd9EOuwTX9ZncIW8CjttY3mDN42j+8D?=
 =?us-ascii?Q?7GLy3fpx8xKJbf1xIP+fLtgBvGDPA4DUIChxV59vE6T59fiF2kLiVlFq/Cox?=
 =?us-ascii?Q?/cI/HWalEAApmNCfQ5L6AyJbJgd7iYsDRuV/lLujG9LJ8GxSoh4QQbr0MO+u?=
 =?us-ascii?Q?DSfVtUXMeLdVHnm94Ru1xa5w1ipYZNOVD/KZA7KkAPbGXBw0KO+U0v+5ESip?=
 =?us-ascii?Q?k7urev8nXUj2P0W86rJAnUEYZyiseuSwTwsU5ON2doySC4BznE0dcaLmHvb4?=
 =?us-ascii?Q?M3l7yU7uZRfdr14jjjar0lOcsLX09wthvmAw49/zn/C7+gP04rLK/ehs8y2o?=
 =?us-ascii?Q?IdNNabrEtdF3JRevMhDcARDd0OF4JSu96ZT0Z4cBcb6EbWYZplHNiJOIC4Ye?=
 =?us-ascii?Q?gfK2vYd/7S4S9/II83qFAgQ9RL8VIZKrSAT34jFrk3NRZTSEImnXaioa8Mib?=
 =?us-ascii?Q?MJWtzM1bQ2PeK/1eZjGh4H2XtR83QCFc2Fd0S8/ln5FgAFf2ouxnORIMgwjZ?=
 =?us-ascii?Q?TUF6QLwaZqgvmvUab0MFM9bTnZua5JPwTl30zKwkw/leTQ+DUrgpD3EDgBMs?=
 =?us-ascii?Q?lKuQ0k3ISLJwkdnbywmUcPDE01LMsHTYUonIc9q8jsoKmwUCHFfvpT2VrPwN?=
 =?us-ascii?Q?+oVbQ+o6zNBETn+OmPNOeBjAgQwkqGsAb/EqdWeQX2s+OZzBgJemzPwyXZNX?=
 =?us-ascii?Q?6vmNJd8L4o6TJcGZWlTY4qxbBedDOMD39IUGgbAJVWjcWjWxGQicCoGYIykg?=
 =?us-ascii?Q?FAKLCy2YiyaVRFcHF2YUjj4aX7r3mlndq0umOCaDWn4bXKpc90MLxrVzWHIN?=
 =?us-ascii?Q?kq9UMrWroYrbRBvAZdd74CqC/x1W7FlUukZ5d13tGhQQJTSgM6LdCr/+wNo8?=
 =?us-ascii?Q?Q/21Ecfwoo9D8Tf+TbjPUxxVpygGXXPoCaVJQwQ9va1WfGyiEWZfyL234ljM?=
 =?us-ascii?Q?R35c5uHbYjBZUUnyXO4RN0spOptmfdJoMgoJea/GHD+/UjgdSFimNq9JxvEi?=
 =?us-ascii?Q?T4TWWLKSA6Hz3R8RkfcdpXF0hSzGna8zp5Mn7Njg8d/39s1ue6PwlMuGDY1H?=
 =?us-ascii?Q?qe3lLMnW4PGy11RyqGmd9MQn12W5WVMhnU2RIURg6dG3W/BKV+mavgOh8nVS?=
 =?us-ascii?Q?APDoECScAHfOVd2vdrF8L1bgXasCw0e+CfG1204UpNUdTG4dDKMl4L7O5o7K?=
 =?us-ascii?Q?jG3cIRLpXYnepHara/meN3jAOut1XdUlizP6Zmvit+1I8fUKnzsX4JfxpnOV?=
 =?us-ascii?Q?5bvgVYzGP0gvLjxD/VJWT4l9tLAXR6oCTNGmpus/zuFAXTYZRqpLuqdt+RYW?=
 =?us-ascii?Q?AsUqsmrs4oVUpJctOUYicqLDhSGdz4E0pq5X0xIqyK/yXBv/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR12MB5684.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0721124c-cce6-4d41-ea30-08de5fb873e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2026 04:31:35.5792 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EJ+xR+Z+jLlMEYxTJl3Arzc/Ngqpoafk6TLcCc+cHA3ZO1lWOa8b1ziwSoSgdsp2XeumDPBTU9aigoVgGCAQ1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6137
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

[AMD Official Use Only - AMD Internal Distribution Only]

Thank you, Kevin
Will add const to the array

-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Friday, January 30, 2026 11:02 AM
To: Xie, Patrick <Gangliang.Xie@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; Xie=
, Patrick <Gangliang.Xie@amd.com>
Subject: RE: [PATCH 03/14] drm/amd/ras: add pmfw eeprom smu interfaces

[AMD Official Use Only - AMD Internal Distribution Only]

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Ganglian=
g Xie
Sent: Friday, January 30, 2026 10:30 AM
To: amd-gfx@lists.freedesktop.org
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; Wan=
g, Yang(Kevin) <KevinYang.Wang@amd.com>; Xie, Patrick <Gangliang.Xie@amd.co=
m>
Subject: [PATCH 03/14] drm/amd/ras: add pmfw eeprom smu interfaces

add smu interfaces and its data structures for pmfw eeprom in uniras

Signed-off-by: Gangliang Xie <ganglxie@amd.com>
---
 .../amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c    | 46 +++++++++++++++++++
 drivers/gpu/drm/amd/ras/rascore/ras.h         | 18 ++++++++
 2 files changed, 64 insertions(+)

diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c b/drive=
rs/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c
index 79a51b1603ac..03922aa03417 100644
--- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c
+++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mp1_v13_0.c
@@ -28,6 +28,16 @@
 #define RAS_MP1_MSG_QueryValidMcaCeCount  0x3A
 #define RAS_MP1_MSG_McaBankCeDumpDW       0x3B

+static enum smu_message_type pmfw_eeprom_msgs[] =3D {
+       SMU_MSG_GetRASTableVersion,
+       SMU_MSG_GetBadPageCount,
+       SMU_MSG_SetTimestamp,
+       SMU_MSG_GetTimestamp,
+       SMU_MSG_GetBadPageIpid,
+       SMU_MSG_EraseRasTable,
+       SMU_MSG_GetBadPageMcaAddr,
+};

[kevin]:
It is better add 'const' type for this array, with that fixed the patch 1-3=
 is
Reviewed-by: Yang Wang <kevinyang.wang@amd.com>
+
 static int mp1_v13_0_get_valid_bank_count(struct ras_core_context *ras_cor=
e,
                                          u32 msg, u32 *count)  { @@ -87,8 =
+97,44 @@ static int mp1_v13_0_dump_valid_bank(struct ras_core_context *ras=
_core,
        return ret;
 }

+static int mp1_v13_0_eeprom_send_msg(struct ras_core_context *ras_core,
+                               enum ras_fw_eeprom_cmd index, uint32_t para=
m, uint32_t *read_arg) {
+       struct amdgpu_device *adev =3D (struct amdgpu_device *)ras_core->de=
v;
+       int ret =3D 0;
+
+       if (down_read_trylock(&adev->reset_domain->sem)) {
+               ret =3D amdgpu_smu_ras_send_msg(adev,
+                       pmfw_eeprom_msgs[index], param, read_arg);
+               up_read(&adev->reset_domain->sem);
+       } else {
+               ret =3D -RAS_CORE_GPU_IN_MODE1_RESET;
+       }
+
+       return ret;
+}
+
+static int mp1_v13_0_get_ras_enabled_mask(struct ras_core_context *ras_cor=
e,
+                                            uint64_t *enabled_mask) {
+       struct amdgpu_device *adev =3D (struct amdgpu_device *)ras_core->de=
v;
+       int ret =3D 0;
+
+       if (down_read_trylock(&adev->reset_domain->sem)) {
+               if (amdgpu_smu_ras_feature_is_enabled(adev, SMU_FEATURE_HRO=
M_EN_BIT))
+                       *enabled_mask |=3D RAS_CORE_FW_FEATURE_BIT__RAS_EEP=
ROM;
+               up_read(&adev->reset_domain->sem);
+       } else {
+               ret =3D -RAS_CORE_GPU_IN_MODE1_RESET;
+       }
+
+       return ret;
+}
+
 const struct ras_mp1_sys_func amdgpu_ras_mp1_sys_func_v13_0 =3D {
        .mp1_get_valid_bank_count =3D mp1_v13_0_get_valid_bank_count,
        .mp1_dump_valid_bank =3D mp1_v13_0_dump_valid_bank,
+       .mp1_send_eeprom_msg =3D mp1_v13_0_eeprom_send_msg,
+       .mp1_get_ras_enabled_mask =3D mp1_v13_0_get_ras_enabled_mask,
 };

diff --git a/drivers/gpu/drm/amd/ras/rascore/ras.h b/drivers/gpu/drm/amd/ra=
s/rascore/ras.h
index 3396b2e0949d..2db838c444f1 100644
--- a/drivers/gpu/drm/amd/ras/rascore/ras.h
+++ b/drivers/gpu/drm/amd/ras/rascore/ras.h
@@ -49,6 +49,10 @@
 #define GPU_RESET_CAUSE_FATAL   (RAS_CORE_RESET_GPU | 0x0002)
 #define GPU_RESET_CAUSE_RMA     (RAS_CORE_RESET_GPU | 0x0004)

+enum ras_core_fw_feature_flags {
+       RAS_CORE_FW_FEATURE_BIT__RAS_EEPROM =3D BIT_ULL(0), };
+
 enum ras_block_id {
        RAS_BLOCK_ID__UMC =3D 0,
        RAS_BLOCK_ID__SDMA,
@@ -127,6 +131,16 @@ enum ras_gpu_status {
        RAS_GPU_STATUS__IS_VF =3D 0x8,
 };

+enum ras_fw_eeprom_cmd {
+       RAS_SMU_GetRASTableVersion =3D 0,
+       RAS_SMU_GetBadPageCount,
+       RAS_SMU_SetTimestamp,
+       RAS_SMU_GetTimestamp,
+       RAS_SMU_GetBadPageIpid,
+       RAS_SMU_EraseRasTable,
+       RAS_SMU_GetBadPageMcaAddr,
+};
+
 struct ras_core_context;
 struct ras_bank_ecc;
 struct ras_umc;
@@ -141,6 +155,10 @@ struct ras_mp1_sys_func {
                        u32 msg, u32 *count);
        int (*mp1_dump_valid_bank)(struct ras_core_context *ras_core,
                        u32 msg, u32 idx, u32 reg_idx, u64 *val);
+       int (*mp1_send_eeprom_msg)(struct ras_core_context *ras_core,
+                       enum ras_fw_eeprom_cmd index, uint32_t param, uint3=
2_t *read_arg);
+       int (*mp1_get_ras_enabled_mask)(struct ras_core_context *ras_core,
+                       uint64_t *enabled_mask);
 };

 struct ras_eeprom_sys_func {
--
2.34.1


