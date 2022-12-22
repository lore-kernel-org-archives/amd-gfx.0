Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D05AC4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Dec 2022 05:57:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33EBF10E4F5;
	Thu, 22 Dec 2022 05:57:25 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E536710E4F5
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Dec 2022 05:57:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c+22AJwQMi8iHxEfB9rvhrFtNqgYUQeOwb9IWE2Ae4TuaJOaHzYzHVt9G2XGhFvKoxz69HuO0Yy3v1DULUtgsGYIznx/DYi3eUaqjLq703LjigK0NF6JTUVlWnW7VkX2MEwDsuZ7xetLH7mP2IFPW/O3Y9BOJOKpoa+x6PkXAhB0t+IGX4fTGxvboJXPidCdPvjkDvaV2yKVbB4IZJAgFC+2IvBNrPwqQnAcZN3GwwdmFd5HFwDTe/rOgvFPS8ayRETIetDznt8M43XvH/JAAEALIDQ+uhRzga0eOLDvWy7+r1kFGAxf2xg4+f4mH4XH8XV3OWpSzxxuG9AveDJVgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z83rcv6wKNLr09m2WUzHKUjr+q9Rq+EhZw9l7wLZDg4=;
 b=NLqieIJ1eDs3tQjHtoPm5L8xkmk0tSKBkeGiq041gAfTkHQ5ZzCswRMQE22I4NNfeZpRfWnsD0AIS13gwL1hYC4u8D1y3mbflIFj2quzegHw4FdkXJQxUSSD6CCLfFzD1MmjiPy5kpjH4Bf+DluYs31ATQyVCidHGCpY/3q2xmaNItJqLPA2sPxVB+7uCnEb9wsFUtqfbQr7lulXLUH/Qts3I548qvm0gIy8f9KSrEpInQHtqocW7zK4g/ZQnTI0YdWYjjA0vaKTKtseCuehmZS9C9oQlbZ6TBCk6KB+YKkPnAcG/h3RVx8HDrqi1+qrnzXOzeZkyYy4ityucfZ6pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z83rcv6wKNLr09m2WUzHKUjr+q9Rq+EhZw9l7wLZDg4=;
 b=VplmBKqYP8D5Z4SAWHMqsXwqVGCEtdaXbVVWEUzMDjLGoZjtHyETFzXM3xFHQKiwDewavLnFS8iw1kG+5X5GH/16bzCkk+ZLoea9odgdLh88Fww9AwweWoenmm5qHWewG/S5BVZWVsx+nwlvH5Ym9O+gLywESoz5AACcXbSm7GM=
Received: from CY5PR12MB6155.namprd12.prod.outlook.com (2603:10b6:930:25::15)
 by SA3PR12MB7858.namprd12.prod.outlook.com (2603:10b6:806:306::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Thu, 22 Dec
 2022 05:57:19 +0000
Received: from CY5PR12MB6155.namprd12.prod.outlook.com
 ([fe80::193b:3c18:2cce:2fb5]) by CY5PR12MB6155.namprd12.prod.outlook.com
 ([fe80::193b:3c18:2cce:2fb5%4]) with mapi id 15.20.5924.016; Thu, 22 Dec 2022
 05:57:19 +0000
From: "Swarnakar, Praful" <Praful.Swarnakar@amd.com>
To: "Wu, Hersen" <hersenxs.wu@amd.com>, "Lakha, Bhawanpreet"
 <Bhawanpreet.Lakha@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amd/display: Fix dsc mismatch of acquire and
 validationn of dsc engine
Thread-Topic: [PATCH] drm/amd/display: Fix dsc mismatch of acquire and
 validationn of dsc engine
Thread-Index: AQHZFWwzO7dJGHcQ8E+cbwYArkKj5a54wPCAgACm1RA=
Date: Thu, 22 Dec 2022 05:57:19 +0000
Message-ID: <CY5PR12MB6155F74A2D79A2AA2C6CC4F38FE89@CY5PR12MB6155.namprd12.prod.outlook.com>
References: <20221221184359.546013-1-Bhawanpreet.Lakha@amd.com>
 <PH8PR12MB696205B369BC1C4ECCBEE3E6FDEB9@PH8PR12MB6962.namprd12.prod.outlook.com>
In-Reply-To: <PH8PR12MB696205B369BC1C4ECCBEE3E6FDEB9@PH8PR12MB6962.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-12-21T19:51:49Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=10c6bd2c-2fc4-4e57-8ea8-0ac761e75904;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-12-22T05:57:13Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 4ceceff7-16a8-4b04-9e70-6e1fe166870b
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6155:EE_|SA3PR12MB7858:EE_
x-ms-office365-filtering-correlation-id: 2e77ae20-4f41-473c-4b3d-08dae3e1632d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9Xl91MxImhE1/Ycbt1xkEm2vi2Detf6FgSICQd8E5uKZ5Qv26qH0J/ocw7U+nAkotb/HtoYpeolXAoYn9gfnNF6KEmiLlhRdrzc7EG7elH6DFYbMqfQNBXybC/uiobY1lJUN8BU5IJXCqapiaGpH+4U+jq0qMBZ62c3roqPJAWfjCjxP00sm3krA0Wlfbg1LCHZaAwejdM5Ce1fO1F+/FRuOqS7OIpG9C1HjTC5ivcC3e4iZl+EpqgawO3e0kF8S3yEuOjhWRmtyuc091bPSZApFd0bB6p/5eTH3wMmU2nC9LjaxjCMJdoYsih0a5Ldzz9KxRl0CXO+0VBEDawfm5RHVmdm0NjV1HBYqjOWB9Uf13eb/nECZZzP3vWk/DTqa47midId7NWrh9D45J3W79CyIFIHFSuKddl+GVTi7jzOXEOAvtqcGIfscJ/bCLT0kAgHDxlhEwz/4Wf2zw4LEGbWckrJDvDCj0nbE9EkvWodQoOmaUhTBWZ63qUafQigpqeQHhKLlDKjo8xGMhbj4HBfc9FIJYVWkaZwmwFc4SJt9p+ACpcIlfcOjFQS7RYss0PKKlCVT+onjI3nyG3GdBUxmqSmXQL2tr2IresPYTWrfimuj5WNVC4ti24VFyE2AmPOcJAIWPi/dYC44NTu3skFoMgf4i7Ad+PPTqxGgf28+IIh6P1kSOEmRRa0kw6dNWdLaNp0h6t1liwhbdilbNA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6155.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(376002)(346002)(396003)(136003)(39860400002)(451199015)(4326008)(8676002)(7696005)(54906003)(52536014)(2906002)(5660300002)(66446008)(110136005)(66556008)(76116006)(66476007)(64756008)(66946007)(71200400001)(478600001)(41300700001)(53546011)(9686003)(6636002)(26005)(186003)(6506007)(55016003)(86362001)(83380400001)(38070700005)(8936002)(316002)(33656002)(38100700002)(122000001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ck1m1Ig2xc6x2SbdaSpcC79CSlELBw/4hsVA0+pXbDFGmrUwkPhNopG+2mST?=
 =?us-ascii?Q?ZsfuXisWpeg5Ga5GBj8Nk5ishPKZ/tqziXkDkg/nEkokqNlYGhdbFDXoWHoZ?=
 =?us-ascii?Q?5fgPfuoVy47bG6IKSc0DIEdNxvjHae743hsFU0CLmDD7xrVfGFo7tlxi98iV?=
 =?us-ascii?Q?79410COXgkbPYL9rrWnzbPF7li67rYKGAGKrZ/LkOBVUy+NjOWJhCCS5X34Z?=
 =?us-ascii?Q?v+RmF9cWp7SdZC065kSZKZiIu39rpBN2f2o+jNeybJkATwTei6Vz0XSPAWT+?=
 =?us-ascii?Q?uoxImY71nrWb551/szAFYAYuLogTUKEz6u4lrfkNbdUCS/8Xmq8o3DhwlVg2?=
 =?us-ascii?Q?sv+OEpmmZr8j9WI4Lhf595Kx5Z0S3DXe2kMrSQ47Z+oKRMDnVDr/85iaZG2c?=
 =?us-ascii?Q?bMAKjM73TusyW9NMHdUbz9FPq4XGY2Bo66N5NvAodyUkgOxzd06a/oZ40z17?=
 =?us-ascii?Q?jjxsUBo9Kd3E4p9HypkXoof2fE8DGRBruMwbRu2E24M+rRqRhZPJZX0rEkUe?=
 =?us-ascii?Q?8Xi3/D5hP/9KoYGjjJm0GwT21UxeGn0CqKYJ/pMVSDZUwo9NA6DtYvKaIdaW?=
 =?us-ascii?Q?C24a54fI5kzZ9BmYtOmuSZ1qYTtzXtyWU9i4C3ohHQ8Y30nN7a6ba7cMMZKc?=
 =?us-ascii?Q?DaT1biLkku0HAXbELTGc/0fjk2dIGfi9pQlwtAe+4I5Zuvi6QcW/cj+MRKA1?=
 =?us-ascii?Q?rhLuC7d1b515nWkzyFke3psDaC5vfqi2o0NB86QfTbtJPEO7xDfuY391rauz?=
 =?us-ascii?Q?WIAil/IG5S+buCMTfULKnsAYbUFwLdZiLVZo7BPmXC/rpGQbQJpMlnCX1szM?=
 =?us-ascii?Q?kEw1UfV/ZKxzLaWFgLH/6/zJSDJ6S3qsVB5gXR4ehWHLoXMLK2xYmlKtcDEz?=
 =?us-ascii?Q?xBxkICi+tye0LAFNAGLc+SSKUvh+Y398RNjuPfru8tBXC5XzAGjBLliLyMnD?=
 =?us-ascii?Q?cavMNAUx+Vh8/A8/Ke7EUJLozNeYomqMUV8gzynVFeOaj9lE5po5PkHo8rRF?=
 =?us-ascii?Q?O+VvdNu1MZXywEOAsqt4+8sKPkmueL3CbWtIdbQR7irjOXgP5VWIPQH7+hS6?=
 =?us-ascii?Q?bIU7Cqk4Lvj8Uxqptb+Gcdp+dYLUwYd1HOTNbv0SIYPNpjw58b5nZv6/pCP2?=
 =?us-ascii?Q?SeMBd+IbB1R8hwwl9bVQH6Np0FKLP4v1TTfI8FdmnALStR6ZC3sa1b7HAs3E?=
 =?us-ascii?Q?30I7IEy2U9r0MtulEWI2COMOaF31KYt4ueFhEKY+A5pJR2Re2pstVzzvv5ql?=
 =?us-ascii?Q?4mRvE+Zade1hFgOaHQtkOZNUGc1fLJAVA2CFfb7Lodzicsj39fWJOX/Sf5Ii?=
 =?us-ascii?Q?TstUREvo/PFh8X4OOOu2Wz2ObA/dDX8dLMBQjRrnPgJknGX6+cZzC0/AE7FA?=
 =?us-ascii?Q?q2ijieNm4N9vTTR/jjU/hYY3F23m/U7bZ6qj0cQWGsN1HJLrsdBUZPep1V/7?=
 =?us-ascii?Q?57HGnpNcgz+ujMElDOXaXhwP38jyA2LVsr1bfG+NnHTqvhPz8C6nQq0kut6R?=
 =?us-ascii?Q?afRnAPgvaQuoNO7tXZVmArsCzWsBHf3Q0l9vfKDVH0fT5aZps0KwIpu7VDEt?=
 =?us-ascii?Q?GXjy9LzdZWIPrp0Q9o6Ps8K+kpIPRMC0PAwKkGGQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6155.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e77ae20-4f41-473c-4b3d-08dae3e1632d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Dec 2022 05:57:19.7249 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HCQXQqPPEO9YC7DB6YpBmKM48TPGp6KFlo6hDYExUVjfbc6z0nY/2NrW2kKr/CdnLj9+W71wBf+xxCa7hg1ejA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7858
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
Cc: "Liu, Wenjing" <Wenjing.Liu@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Hi Bhawan,

Kindly correct the spelling to "validation" in Commit title - "drm/amd/disp=
lay: Fix dsc mismatch of acquire and validationn of dsc engine"=20
With that fixed, patch is good.
Thank you.

Acked-by: Praful Swarnakar <Praful.Swarnakar@amd.com>

Thanks and Best Regards,
Praful Swarnakar

-----Original Message-----
From: Wu, Hersen <hersenxs.wu@amd.com>=20
Sent: Thursday, December 22, 2022 1:23 AM
To: Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Swarnakar, Praful <Praf=
ul.Swarnakar@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org; Lakha, Bhawanpreet <Bhawanpreet.Lakha@am=
d.com>; Liu, Wenjing <Wenjing.Liu@amd.com>; Wu, Hersen <hersenxs.wu@amd.com=
>
Subject: RE: [PATCH] drm/amd/display: Fix dsc mismatch of acquire and valid=
ationn of dsc engine

[AMD Official Use Only - General]

Reviewed-by: Hersen Wu <Hersenxs.Wu@amd.com>

Regards!
Hersen


-----Original Message-----
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>=20
Sent: Wednesday, December 21, 2022 1:44 PM
To: Swarnakar, Praful <Praful.Swarnakar@amd.com>; Wu, Hersen <hersenxs.wu@a=
md.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org; Lakha, Bhawanpreet <Bhawanpreet.Lakha@am=
d.com>; Liu, Wenjing <Wenjing.Liu@amd.com>
Subject: [PATCH] drm/amd/display: Fix dsc mismatch of acquire and validatio=
nn of dsc engine

[Why]
We skip dsc_validation on pipes that are underlays, but in the acquire_dsc =
code we don't have this check.

In certain conditions (when underlay pipe index is lower) we will assign th=
e dsc resource to the underlay pipe and skip the base pipe.

Now during dsc_validation we will skip the underlay pipe (this has the dsc =
resource) but try to validate the base pipe(this doesn't have a dsc
resource) due to this mismatch we hit a NULLPTR

[How]
In the acquire_dsc add a check for underlay pipe so we don't acquire a dsc =
resource for this pipe. This will match the acquire/validation conditions.

Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/driver=
s/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index d0199ec045cb..f97d8ff16e71 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -1382,6 +1382,9 @@ enum dc_status dcn20_add_dsc_to_stream_resource(struc=
t dc *dc,
 	for (i =3D 0; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe_ctx =3D &dc_ctx->res_ctx.pipe_ctx[i];
=20
+		if (pipe_ctx->top_pipe)
+			continue;
+
 		if (pipe_ctx->stream !=3D dc_stream)
 			continue;
=20
--
2.25.1=
