Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF0C4C47DA6
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jan 2024 13:16:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5887210E8EB;
	Thu, 11 Jan 2024 13:16:02 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB29B10E8EB
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jan 2024 13:16:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bda/HCLxNDVGhoJKdIBUuVPON+Ig0bfV9rD1yjqYjB9AuiUWRpWYIXQjgyo9KL4dZwc16ZCyrh5NzyK32Ks/KUp9JpQ45ixk+hIfE0OMB9Wp4XpBLTmO12ZRrTHWfGhl50wDrc7QAeQ598Z801XYRLEEp/kJFJiLIpmGUAyMMAeVKNo/PExyVnoBFRTvtBsvD8W8TSQr1I5h9k8sIEdhUOX3O4voyQ2frGZ1uwycHb5cT37OJ5hmv5ZNZUzplbKHjteNM7O/rW61TAYR3pvozjQjkEdMS5Cw7/EQmdoD6QTM1BEdHxOoxzmrMO1/B9sK0kn9gYQM0D8qDP5boQSHSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hKc+kfEcOKorU1Mca1LJrQvNwh7PzKrWQU0h2luGs54=;
 b=YVhhtQDj0li9HhiZOpcNsk+ANNRipN218YhsJOQUWBdixNsmIdCfS/nY+9X/hpRy5zoH5dd6qsbH9brmhtrHbIKB/YnSnGNDRIBmT8jTaycy5PL3tCILbQWWi8OaQYKJvkkyqrOmPLv4czRHaPGNbqUERijvE4ESiWddflbzsbDZ4BhPuaFJuFp0FYwXsQvYhmfO1FmDaEQrYe7Wq5rrvPwu/87HAe9L5WUxfV6Gfqq51P3C4CsbSOLCt8vFsqJDiLc6RN174o9U6OboTLpShdFC9HrEhAok4DcEnH5cBcb2UlqOTWJo+XhILih8Ry9EMdsCl79d4eHw6/5yiASzpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hKc+kfEcOKorU1Mca1LJrQvNwh7PzKrWQU0h2luGs54=;
 b=Hm8qR9XC0Q4n9+aQlyBw0R29drG2b6Bu0HGdolj7APkyX9a5d0tlu+8qwmoYrwjGMvI6E3vVO5IWjdBbVS5LLBlg4qLwXSJyh0fbSHzUPnXRjcPfcPjYHTWTei+SL9ishkIt3dpoSdjDxlhjcwdbRe74yXctBRNr/3lvy0ZR4PQ=
Received: from DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) by
 DM6PR12MB4514.namprd12.prod.outlook.com (2603:10b6:5:2a7::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.21; Thu, 11 Jan 2024 13:15:58 +0000
Received: from DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::1766:791f:b4a0:5edc]) by DS7PR12MB6071.namprd12.prod.outlook.com
 ([fe80::1766:791f:b4a0:5edc%4]) with mapi id 15.20.7181.019; Thu, 11 Jan 2024
 13:15:58 +0000
From: "Kamal, Asad" <Asad.Kamal@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amd/pm: Fix smuv13.0.6 current clock reporting
Thread-Topic: [PATCH] drm/amd/pm: Fix smuv13.0.6 current clock reporting
Thread-Index: AQHaRHl4C0h2ZzQEK0KkK5SwzaSfKrDUl27g
Date: Thu, 11 Jan 2024 13:15:58 +0000
Message-ID: <DS7PR12MB607185C46BEA60AA660A51F88E682@DS7PR12MB6071.namprd12.prod.outlook.com>
References: <20240111103205.124017-1-lijo.lazar@amd.com>
In-Reply-To: <20240111103205.124017-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=e3d85d14-ce31-4cf3-b56e-f91ec62fc77a;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-11T13:15:04Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6071:EE_|DM6PR12MB4514:EE_
x-ms-office365-filtering-correlation-id: edc6bc9f-e430-4722-e937-08dc12a77371
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IqplhPaqWC92GjOY7idr15tsLgyGUeF5wg0WqdZwCdErDabNjAiw3PRhhqF7tGUmJGD0QFE2CkFLrAn15vGIerP0LKTbrpl7WivMehIDwkHULcYqsvI+Yq8rNGHEfxXWQJp7MIDzSWVE005cONdneJkmCQeZihBBwnbrNKTdCdfI49W2d5fBRnh5w4Z/MNqlCvwnmhksQem4Son+uuV6Bb3DGRsP902wZDAeqGBuPfUbpn2ezM1MXdUp1Q+tQtmWuNQfyr8zNp64AQfswGHPoyuo6fCVbvcDAn7VkN15OREvQF01sxeVuSJLTGunxRuEyLKrmHFW2QyhKBNG93vW4Ob/TXD0KbQJpg2WBshKgIvtooYhSkFVSYocTY9ZfusjpNkfScSCcV/GeVGmuaSR+YIdg23GuPRjy9/1MzLKI5wcnXphG0Bfv4eOjfWdxJ3PBjD82Izmt8S6dFqP2/5N46E1B6hFNXgSQzL+f58uqqA50hnTS6w0Zaqalmje/n5cICWz8ghp2NVESik5eK9sx2WupT6+oOtrc6LSc2P/nnGPpRTGMQxwaQ0bIOwN9PSegBU8rnC9nZ1GyHxQbbNfc86YEd86nlLW+QHLtgeII88vM4EgtI9dHqBANxtfy7XV
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6071.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(396003)(39860400002)(366004)(346002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(55016003)(26005)(71200400001)(83380400001)(122000001)(86362001)(33656002)(38070700009)(66476007)(76116006)(5660300002)(4326008)(66946007)(9686003)(66556008)(66446008)(64756008)(54906003)(110136005)(7696005)(6506007)(52536014)(8936002)(8676002)(38100700002)(316002)(2906002)(53546011)(41300700001)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VaGrqTl3Jrhcp5Q3bCL5cwKG43XYqI5sPsl21Ii0ZuYHwEnp0YUv2ruaCGu7?=
 =?us-ascii?Q?64B2Nv8dOMmQXOt+6YB4gBHfGtg8W4kCXV6IEhqyYsgftz6dU+AVwh7gkq6V?=
 =?us-ascii?Q?uUOs6rGcPbf6c4Rz2syGKRvl1GFQJ0vVufPpQ2eGTsIWBytclOJ6mB8mS4pl?=
 =?us-ascii?Q?Ioj13eU00/UXkUPNYaAFPhVReVxJqtXGX3pXLGWcsHKXoJpARPFy+cNq29Cz?=
 =?us-ascii?Q?JacpzvJNKiwSle62mRSzlR8NrqbNX/G6K4zymvUvNEy6JM9V1OoKxIoCIk0W?=
 =?us-ascii?Q?4/xWj0koKV1J8T8lgnLrHWdPNnmO7XdjnpFyorEz2kAl1qsBeiDZZPYFG31L?=
 =?us-ascii?Q?udn6wn9s1ajdWrC5iEOEjorPnMw+ja3zxoXmGj+QTqag5+gA0xGklLBGVOLS?=
 =?us-ascii?Q?kQa+5XjqSADPMUTtdkGeb+PKHwmvhbXA/K9SG0TuYXj/aafIoz3fMLtTYCU+?=
 =?us-ascii?Q?EWyj/ejTTqsVj5AobPGwnf3jmHJiKsp/5SylCQKnpXxVyqPxqysXJSlUXiAK?=
 =?us-ascii?Q?UqaqzAvXaTS8bluLyJWtvKX54iXei+UHUbua1yu9/7xFPbNajvo/H0c30G5/?=
 =?us-ascii?Q?SGSEgFjabgOCwxM+Ebp/bXmQeL3RU+H6aE9l57MPBIMFYUquzGrJlyGG/vHS?=
 =?us-ascii?Q?pKGj7zBGLNcf+jVbwCt570fHDWCTMHLH6mjmHrODoW8YITKEgZDa3axETTWt?=
 =?us-ascii?Q?JzcEAmwHfcVRFttmjcqugMzb3dXroLVcg3C71fWOhwqxVlkYimDNnpxobwnA?=
 =?us-ascii?Q?x07ebPe+LmR6dfCJE451nUI7LVkolY3N+5WK6navNJxMYvH4IAEW5AwCY7x/?=
 =?us-ascii?Q?roGAePSvf+NJwgpOHvJdf2IQf6cGmCR9789olo7FvGPVjcKaZpJwb/hsWMF+?=
 =?us-ascii?Q?6PZpPzU0Ou8110YqT4OD4gST8q+5aRD5mAAKLldbas02xrFiQ/+6qOTyVpzB?=
 =?us-ascii?Q?LDv0eqAUZDMNSYI0Jt+cNaR2FC5RCO5XCs/yHwslJOoHdJj5hSXt/WKPmwu6?=
 =?us-ascii?Q?3VOT0NjFd6i1DimV+rpmH2pve1HN50NKzB52wJ4pHT9uZvrAG55CRqjPbHT6?=
 =?us-ascii?Q?YdV8wTaHL+VKRHuoJzVnExo4cODGCeccjhhQuNosKZ6w+a3IpzyTLwY1sxNe?=
 =?us-ascii?Q?sacRG+8o4M3lrl2iLfimZG7nGbDiW+vexi5wM3m2F3RENbm2gHmqn+AJF9vo?=
 =?us-ascii?Q?Q1DxWCzxEaP0bANIxIccaNUu+fB/n/QH3DOw7tva2G81ONTDhS62H0UWim7W?=
 =?us-ascii?Q?BEyja2gwaJz0gQSooedJayOPXQv5KjTBv04/dsU5f5BboUF4278TN7dyzO00?=
 =?us-ascii?Q?ukjq4Kmm+VwzjpebWz4Y3Pip3LWnFYXkTC6NPk+fjRwo4Q+pMQiFNDlJ4PmX?=
 =?us-ascii?Q?fUYmj6XX21eLYMtOSLZuFuje1gL5qCwT9Y1uD0Mt/LWekqTmFLT3JjnTP3sZ?=
 =?us-ascii?Q?s8wtnGLuDi9MXAqjBeQ0cj12NZrv247jPfTHH9AbW8JPHJYdA/Rxddf7QRCa?=
 =?us-ascii?Q?a48jsVPtWwgU6IbK9XJv3AfLoWZ2h1snEWr+8Y3FjlJ5jV+V/uRcHbGlgqEh?=
 =?us-ascii?Q?YHqNsjrZAAj/irYWrVs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6071.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edc6bc9f-e430-4722-e937-08dc12a77371
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2024 13:15:58.5003 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: an7dXaNCZqb7T3gt51UaTE25pFm3Qhv5MOsWxiNIwqQqmqEZsVXut0f17dTdDFiKLkRPyGChSFYbO39CQuf2Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4514
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Ma, Le" <Le.Ma@amd.com>,
 "Wang, Yang\(Kevin\)" <KevinYang.Wang@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-by: Asad Kamal <asad.kamal@amd.com>

Thanks & Regards
Asad

-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Thursday, January 11, 2024 4:02 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Ma, Le <Le.Ma@amd.com>; =
Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Subject: [PATCH] drm/amd/pm: Fix smuv13.0.6 current clock reporting

When current clock is equal to max dpm level clock, the level is not indica=
ted correctly with *. Fix by comparing current clock against dpm level valu=
e.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 7513d1cfeebd..a28649f21093 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -970,7 +970,9 @@ static int smu_v13_0_6_print_clks(struct smu_context *s=
mu, char *buf, int size,
                        if (i < (clocks.num_levels - 1))
                                clk2 =3D clocks.data[i + 1].clocks_in_khz /=
 1000;

-                       if (curr_clk >=3D clk1 && curr_clk < clk2) {
+                       if (curr_clk =3D=3D clk1) {
+                               level =3D i;
+                       } else if (curr_clk >=3D clk1 && curr_clk < clk2) {
                                level =3D (curr_clk - clk1) <=3D (clk2 - cu=
rr_clk) ?
                                                i :
                                                i + 1;
--
2.25.1

