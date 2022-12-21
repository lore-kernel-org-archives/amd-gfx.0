Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20C62C4167B
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Dec 2022 19:53:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD8BD10E49C;
	Wed, 21 Dec 2022 19:53:30 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C274B10E49C
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Dec 2022 19:53:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IoJzNoUjboh9VejfHHblM3ce56Sq29eOLIJhji/WVeCHwr1Ge8gbxpHDhCIgLyNrxIhnKN1DL8hZl2Lw1tHtV8TtJjej6e7KO7t0xP7kWgJnHWvNMCeh/1nECEkMQPmFZcdyG0Fd0C8SPbJ7dwI4oXxAExljDJe9e1gBSnJwVCZf1RJc9IoFym0oSl57QKzAjQQAhLnb19OqJtluS+M9SngrL63vMqU+rQfuYwHuueS7ZES4CqJjkroqxqat3F8IqY+KTrD/KmbN/Na8MBK2QXYqIkmwojqbmWBFUcNTe7h+azbXCpZqLeXbtqIUljAZU3tHeq7Olf1JV8j8VVHGGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bTfo7J/I+tQu/HBTqa7SRMseOZNTFWMvQpm3hKIL1rY=;
 b=e4lVr4ACtHdvrw0mF+jXwCUCyd8mn4kV7Jt6UCgPJnJZGScZkYiMui65E/DZM6SYQkceArOkQnebvmboRhvKgOyo9HYBSPHr/tjqR3B/1naYc+qr6q3GFDk/+R6I4mLxzBdhoqE9LsPE90/oNOHCrguAa7gh5Ha+eBlVNHiXtM3K9qRKBEOlQspdgYZ3/vLIXYqs9pww4i/Ekrtj7EHrpKpAeFWqjHopJrw2fR/enZbwDEq047crHJIkaRjqGinaBQ8KM2vUl3DYuslOHN+YllmzzINllVCAlx8XmOtprOBT/XRBhy+a2JGnKwMCSgYjH3vIX7C+bczuUwsfxH1guQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bTfo7J/I+tQu/HBTqa7SRMseOZNTFWMvQpm3hKIL1rY=;
 b=3EqFGQHgl9pgqRNpVmg9r3HRj4YzN0QO0muDxCICV7CRAAVmd3cL3FuQDH1IuE/n0/inFvkf7eDYi3fAgBOeySR2kDJNQO+/jAE3fHNJ7Dnsgm0xO9TPyaNZtmsciwvA8KJ5VYEaaYd30sMAyqw3//drbc9X7HboTjy2rxnSOfY=
Received: from PH8PR12MB6962.namprd12.prod.outlook.com (2603:10b6:510:1bd::18)
 by IA1PR12MB8240.namprd12.prod.outlook.com (2603:10b6:208:3f2::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Wed, 21 Dec
 2022 19:53:27 +0000
Received: from PH8PR12MB6962.namprd12.prod.outlook.com
 ([fe80::a378:f317:aaf1:1b99]) by PH8PR12MB6962.namprd12.prod.outlook.com
 ([fe80::a378:f317:aaf1:1b99%8]) with mapi id 15.20.5924.016; Wed, 21 Dec 2022
 19:53:27 +0000
From: "Wu, Hersen" <hersenxs.wu@amd.com>
To: "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Swarnakar, Praful"
 <Praful.Swarnakar@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] drm/amd/display: Fix dsc mismatch of acquire and
 validationn of dsc engine
Thread-Topic: [PATCH] drm/amd/display: Fix dsc mismatch of acquire and
 validationn of dsc engine
Thread-Index: AQHZFWwzl+7WJSqyj0uESXK1IAcKVa54wHuw
Date: Wed, 21 Dec 2022 19:53:27 +0000
Message-ID: <PH8PR12MB696205B369BC1C4ECCBEE3E6FDEB9@PH8PR12MB6962.namprd12.prod.outlook.com>
References: <20221221184359.546013-1-Bhawanpreet.Lakha@amd.com>
In-Reply-To: <20221221184359.546013-1-Bhawanpreet.Lakha@amd.com>
Accept-Language: en-CA, en-US
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
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-12-21T19:53:25Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: f122675a-6504-4cb9-a304-db45fa1707b0
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR12MB6962:EE_|IA1PR12MB8240:EE_
x-ms-office365-filtering-correlation-id: d14a16d0-d8a3-4bd4-f1e3-08dae38d06d1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a6CB/lPXLc9FpRAzJoCrYtLca+WGWR1e/HTeoEZ4qT4Zii+SJdpTh6r09HTlxVd3omvfYvjuDzHkh8ABq53l93xUFIgtMon9ZOKPXD/lpqFFuD2HwyBNp4KRGBXA0xxOvOcPph2tVD+N+TInLB0pdDPgzAHZ+KagebaO2pZodz59QC8Bb70b2vZwcJfXgxh+2fZTpg8HhK4ha5bhz4NxcPc2GbFyTtpa6XU6jXzuSWpCHurpN6tvdnY+x854aujRITQXpi+68pVK/jBi6p0R9faTy497iLOzCZdJfD8Mt6Qc+AqG05dnUJ0LvdVh2uQ1wjWeo4QYrrHdYRupVAZ0aWmEDy7+AlkGXGjlidgnMSUyW76z6PJo+AHVLM0oXs5VYMmNZCp97aS34dHvtGmXns7f2lWOAVqDMoi4Xavtn0AmYbuE+aI8jlbRRFeDDA299PL0lCzhLmEWqUIcbWDzliVN+JWaaKYGxuquTe+AoCoB2X2xYDoMPm4X/xI2+I4N6rl3nqBBNs5dkE2keBK/xC7G3aKZfSBIGMOPAkSgzoelK+I2/7XbUX+6TnHaNUm0UW7xYeIGeIEozNI2pgKCdst3yrulQaVljKl4H/Cx+vHN3nRIZuKPqy6kaVsRW7zGgJnwrGzDei4yHDvql1X5tmNOC9wexi7Wz138UGn9BP1EsMWlhP3gNI/nA6mQ1YR0whit/rXpoWJpLaiIZDL4Qw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(376002)(346002)(366004)(39860400002)(396003)(451199015)(6636002)(54906003)(33656002)(110136005)(4326008)(41300700001)(55016003)(52536014)(86362001)(8936002)(83380400001)(5660300002)(316002)(66476007)(66556008)(8676002)(66446008)(38070700005)(2906002)(66946007)(64756008)(76116006)(38100700002)(26005)(9686003)(478600001)(53546011)(6506007)(122000001)(7696005)(186003)(71200400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+tBUk+77NLeB/g+TkOmU7dGh6a6MyO3c+OKKFpAlbsq589Q3y4q41jQbOWjJ?=
 =?us-ascii?Q?YQX0R2brssVyYnG4XlqKHCM8TpIJle/mTgDJIb5/9Efh7crH4vU4WmtzdsB8?=
 =?us-ascii?Q?uMz62fPOd0sHVk8ElMBxtIcsdULyUVX3+I64qbEDKtYHz17yw0EEHCqxI8lG?=
 =?us-ascii?Q?d8bA4LqDEdoNBfx+YQKHAw5ekB27IlbrxShQng5anrWp0F2nKAZaUjWA4pk2?=
 =?us-ascii?Q?eGKQH8TPkHuOK2MtTuGRZsW1wIoNvGcha7EYow02uYfEnEAyt4aiMKicoYrh?=
 =?us-ascii?Q?eqK79a/MoFy9+vU90wXXN82T1t1B2fK+aATIRz5H9cA5JO3nvi+7IczDW9Y0?=
 =?us-ascii?Q?jIxRZcfFN8vPEWuti6gVx62BiLZrJ/KoW5yu1WlPVxziE8W1Dg1oRNYixyvV?=
 =?us-ascii?Q?K7FHIC6J6q8Pwmabz48cw2Mmc6gfGbwhuuw423aO0lRFOA33Ge8D+d/IB1+h?=
 =?us-ascii?Q?eTUtJiAiy08gBJxuMq242RP0UHP2voY0VfXOXhZBhdcifhvb4+MguqhuIItz?=
 =?us-ascii?Q?Nnkv6akl116G686j6mHm0f7KUowjLJjVB65bF5qXfnlapdZK/0nlf3xVQsua?=
 =?us-ascii?Q?DOAtc6b1Hn8AD6yQtHzkaoF71MbOWQztYN5oJDm6/Y3NENL3l/RZeWMEdxAL?=
 =?us-ascii?Q?hlt3CYQgR1u8UaCtLha/NUhShb2C3tllmA21ZHLKv06DhsHS5OW2uGCnLj3r?=
 =?us-ascii?Q?aw0P6V+XWEUWqCAa+aVTr7Z3al1dcRBm+H0xyggO0lZnN3l4O15kjCDGyF/F?=
 =?us-ascii?Q?9uXeCggs5kUtJ5PhHOdjaPNTis87SbukzuYeehhJFI7YTj7kD799N6X9JgRh?=
 =?us-ascii?Q?Q3SIK7ZbOWuljvpVubERTXWDszE0YLpXWZjLjZgoy9w2tFvQQyeWre/ZSjVm?=
 =?us-ascii?Q?jZ5S/U8ASBbYg8tbxXqiSGY4najjvZznNk+cV1+Jkl/o9/XuLNo78svfK6AW?=
 =?us-ascii?Q?3N1TQnHBvs5qdF7rLIaeoRIFItqjZEKN8ixr7DyJDlT7seljpXswsyP4AphC?=
 =?us-ascii?Q?qrsL8Jf4PZb1F1Mz/5fAGPfqLIkpt/D9b5kMNUMVQDXQfBupc+pkHM/dIAwu?=
 =?us-ascii?Q?A9VASQuALU5NoIA+qGS3VJJDZK0re7y1ddEV55q0juym5hQZky8zlm1DoEaJ?=
 =?us-ascii?Q?OdmBjmyIKZFh2kMKzSfNvoUNEc0PF9gJlxC9Ehb8b2nlFmUbdjVjpNgJh1Wb?=
 =?us-ascii?Q?l3WtzxWfULZ3hmSSKNAvNgVOEyqDOtUnZIQT/rTVnOaDm8pYtDgfYAEZ6yMH?=
 =?us-ascii?Q?ujHfB9ekC3FL8XM2Zwow7UvC7AS0iC/NqxUG5Z63jAXiAHG5G8/2jyjdKglG?=
 =?us-ascii?Q?gGKK75tIZrwvFQO3cigO1yfX1gBvC84u8d8PArcEwptZeL0US+CKc76Vj8h3?=
 =?us-ascii?Q?ynBTAmdoO0AHgXXawtiOQwXkFe5u099qd0TPPj0iVzvly7gEE6+EIOlvjZ4I?=
 =?us-ascii?Q?xljqS/FESZsVFfxy9WwzkgiVH0LRlAgqGkolzzeWUUO3UkAFWwekTWAMhJiI?=
 =?us-ascii?Q?R8eZFc/SSeOOWqXvpvlL1Ax7W3UIL2ebxTRRqcS5a3BzyUYGnv5BFWN/lm8H?=
 =?us-ascii?Q?pvLQbP/4JEoeLijuziQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d14a16d0-d8a3-4bd4-f1e3-08dae38d06d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2022 19:53:27.0350 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XgEGQ0lJrlLhBW9IqgBa318wQMiyb5U5+LsDSqYtKhel7daion6ohZGZfRZbyLe8oakm8mMBPwAoIk4bOooSMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8240
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
Cc: "Wu, Hersen" <hersenxs.wu@amd.com>, "Liu, Wenjing" <Wenjing.Liu@amd.com>,
 "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

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
2.25.1
