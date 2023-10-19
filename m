Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4335CDB465
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Oct 2023 14:12:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AED310E4DD;
	Thu, 19 Oct 2023 14:12:55 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2AF110E4DD
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Oct 2023 14:12:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A/4WJD7s1lE+4P4wfWRGAHH3FMj4F7Czy0p/NEWhOEsWkjORzyjOwHPVujIHwpbOmqf5M8Wzsb4oHA6NcYzQ7L8HIX+6nIM+VNI5421ThR9/nef5mL8Ub6+DMg8A6JAqVw+ToIQX9BqFdrs0EdX3bjhB55+J91Y2ZF0STShoILpq0jxIUvpYjP9zjSWTaJmSe8cD+Rn8K2zHKY2krt9Y7EZhZ2FEygIypySN5Z7v6GI3o2CfwjTqajFEgNT1QJHgVoZ4gHr72mFA+348TdUgZ48Xs9FhiL+YGrViG1yvBqYZiNIVcuSmDz2Xt81hZV9BRhiqmefBYkl4ZCobir64jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QqW2VqahZpns/6I5mFXz5VvaU+k3BYGi7bQFK/+v1Yk=;
 b=QbTBkW5uv8tr4n6vGK7RUk/TZyjsLRZwKfuMO+OOj76IB06Kb/UyWI0IjbqNMWFlxUy9gph8Eqv7WfL0QPEYBpwCt968xxYiE1X+W1OWKWhdbdQco+SNFoMD34I8YYPgSV5rGEvYcGLXGiKjUDuWAmio4VHOrclluyz0F9IQOtvoHOTH9tViAg7qL8E4CBI2Itsnmd3v4hgPfJ9JKHqu+7JGdmQ2unabcXEAADrZpSjEg2RBZ1L9AFQuvHNONmFyl9ktW7qGRexFtC3ZZ1BA2hVpPIV6H0LhPIfgz8JMSRFgUqY5f9gTh3MJ4iI5tIFyMkexGLANieMAAG8Jic6SKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QqW2VqahZpns/6I5mFXz5VvaU+k3BYGi7bQFK/+v1Yk=;
 b=l/Va9fHB63j8fU7HVqzEsgUqptChN99fSTyDVOowdJqvH0inPY+4hmwnViD812/J3UJixhsCW3xMncClIkaQCdrLbEA9goCzSB5EfNq9e6Xpxs1vik5I/vKv2ptmsvg2G9mpJF5ZzVSc8qv3uLDYpBJLLWQj6LMKQ91cS8kwzZY=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by PH7PR12MB6696.namprd12.prod.outlook.com (2603:10b6:510:1b3::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Thu, 19 Oct
 2023 14:12:47 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::734d:d070:e2db:de7a]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::734d:d070:e2db:de7a%7]) with mapi id 15.20.6907.025; Thu, 19 Oct 2023
 14:12:47 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: refine ras error kernel log print
Thread-Topic: [PATCH] drm/amdgpu: refine ras error kernel log print
Thread-Index: AQHaAosBOfpGMnto/kq48SKtTLvzG7BRGYsAgAAMXwA=
Date: Thu, 19 Oct 2023 14:12:47 +0000
Message-ID: <PH7PR12MB59975672E1EE4567ECA2C53D82D4A@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20231019125115.1110473-1-kevinyang.wang@amd.com>
 <BN9PR12MB5257DB46D4FF10958E222347FCD4A@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB5257DB46D4FF10958E222347FCD4A@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=d7a0f2e1-c766-48e5-abc3-fb5f88d82d55;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-10-19T13:21:48Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|PH7PR12MB6696:EE_
x-ms-office365-filtering-correlation-id: 52ff0483-c7b1-4862-12ab-08dbd0ad78c7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yW1panwrgpXjZWsr7uhbyP2KxHrgbnFtwc9OGSJBCEj1zgzbhroLm7tgrzhgHxAOZUctELDfo17xrtDU/02tJ6ubJlHFnqXUzAaywxNSYY0rv+b5Zck6Cq+pZk+5Bhk97L1iTW/TGSF2+zTsOFqvnPpa6YDGZuLywUNm/jw9hem5CtSaqNxSjbn9DhKibAPNUJzp5L3elg6DNc51HXLsIn7nYAZH8p3nlGLY5jItp72cQtI3pj0rUTY580OcPUJ5R42PB3Gz1fmpAD+//l/kLDRTRYKKPsNGG7jGV2NGn27o203mK2cP+yy18FCQtkloQHFlGiMxPAFdVQ6T8Shept/3SUOD9EJd/gJwHaWBaXq2UVdnvPSXBzmX9YeUKpfdPgzJwegfQeXQPoYwEU3fqpUP3qG5F9T58SLAIc/xDhJUSr2+iCz1hax52pbZIne0Mw3K+dP6ApRWN+tCDq2LttLLdBB/XHTo1ozoU+q4A9sD+3FmCliQgsXpWUr7psjjyXzPuuwpkUM0T35c/hciYGqPrqdhukPGksEtMKcWCqYedNWVmaxklewVeHF/Q4d3yCBKWGvBA42QDkALLB/tjjt9QjAxUz9NZcbLcDpjMFqRrpUjGNn4M5Vcnvhqu8iU
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(366004)(396003)(376002)(39860400002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(26005)(110136005)(53546011)(55016003)(66446008)(38100700002)(122000001)(83380400001)(316002)(38070700005)(7696005)(6506007)(71200400001)(76116006)(64756008)(66476007)(66556008)(54906003)(66946007)(478600001)(33656002)(86362001)(41300700001)(9686003)(52536014)(4326008)(2906002)(8936002)(5660300002)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ye3hVkLeTAEOay8gF31wi/yIOHBPA9/DRcMMOqbHFWYgLQtU3Ddu8ckOgVYr?=
 =?us-ascii?Q?Al/Ap8uQ+jnqs42GPP6iLXsE5GsRVZwxYKwANTroJpQqqzKpnRJq6aFD4/I3?=
 =?us-ascii?Q?8woDuNPWYD/fFlyZn6Tv1RbajrjKjhUm/QLacGm7DwNM/8LXUz3Zkv3/Ety1?=
 =?us-ascii?Q?rqPo1RUiHWVuzMefDLO5FywFstZ7Jf3iDotCMV7YI8bVSU8LmQtK0NDDe6Sh?=
 =?us-ascii?Q?qjpvzMGfcu94LacX2BjHpjndD8QNnvRHGsJRnjrcCA7ww5ivcuLgGm7VaaXF?=
 =?us-ascii?Q?Wme9hlCjQFgiw+8t5RdWv98UaxpZIJUP7UxhJH0r1q2K8RbyOOec9ExGtN3h?=
 =?us-ascii?Q?YWqUch08DYBv6b5WqN3arXy+CKgZ0HFslcLkI3TM8OfxQxrxYWSldb/h+hi8?=
 =?us-ascii?Q?DzUJPbuO5W9jQLxssGPLb2vVfwjqAOtLdkU5d7PcnOLJgWSRhdiMPgfzxsSF?=
 =?us-ascii?Q?pHMuVqXhRS8IMTrttOfpLwA0oY4ApqJq0RwB68gB4IIK4xEHkjdSE95AdHrj?=
 =?us-ascii?Q?72+GLHGVRDJLCDA7XDKm6hBluAJxrfwz4G+P/mHTKeHAY+UA3UFWLLJtUEyB?=
 =?us-ascii?Q?V1ESCjUlwjkguHHv2r8A2UyoJGZ6OI8xzhoCnF7QaerBXoBi+E04/ySsTwvO?=
 =?us-ascii?Q?yxUdqFWeuTcYUJ6w2vQeLZfrPGhL+XdNGxB2hxOzKL2i9UaFSS8UYg5TIcTr?=
 =?us-ascii?Q?2olvtUyX3cNUmepQOn1ZdGCvFSsbZwbb//XfDFqtMGDfCb0w8Be10ukBEDDX?=
 =?us-ascii?Q?aZtvTI1MRgdHDVuvrKK66eGx56j52t24/pbP8AILJ3wekh/FeBHyoEv6TuaL?=
 =?us-ascii?Q?gUBojsT2SOV6z1+nyKkYONTn+I8FNh622SkqV7Ehu94kuS6lULCCHiyo+uyI?=
 =?us-ascii?Q?avVKrpLXDiJ0E0oubAeH8Y2S/U5/zBHbH/ne2VfBQD7qtpQyC0b6C84uMM//?=
 =?us-ascii?Q?wmudSxaJk9YPGOgjUnvQyo17ovzG44S9pV9/BSvi1ftfo+DFbIFbBQmnEhs6?=
 =?us-ascii?Q?k9eT+C4kihYq2UROdAU6GBTzgGjKppQvgYkPcl+DnTZGgNtfqH172CsIWyay?=
 =?us-ascii?Q?g6Fd2aiUbzdbDb9XqxUMAtxHt1OWXMZ6BXZ7vwKQ1meUve76/OmaHvVggLC8?=
 =?us-ascii?Q?h0hb0xIzCdTM+xvvkNBYs8255iiFA4LiA1d8FqEaf5m3VPnxY5eAcFc4uEPg?=
 =?us-ascii?Q?b/iaug5b/TSYX8AKYKFBnxXc0B9+pZ//h2wFGUON4NkZe0ljozAC907zBk7/?=
 =?us-ascii?Q?qEcBC8XaKGPwsfxAstBJVrEsJ6IcP5WN0024JK1YQjT9BjYN8KzxPW3vFOtr?=
 =?us-ascii?Q?jLypZGTv5dMhXg0E0HBjBABZZbs/Y49JYtuboeSkUwfGmz599IKDf9NWbBZq?=
 =?us-ascii?Q?xxfYTSSIMfpQNzlmLukLkJUK1wDvuqjDRFcTeeL+pSrnEaDFPWqsx+AKCIC3?=
 =?us-ascii?Q?ESkw6BU1EeSkWBdOHdgSPlEluYiiapNeO9R++9SlkNVNT4x+5Vzz6bB5gXO0?=
 =?us-ascii?Q?8iz+TCHAH/fH1g6uvxUXKGT1pV9EvixOvjEYp5cRi4HSBbAjaQqUfXTQSM1y?=
 =?us-ascii?Q?6pEKxkon7YzxOr3oB+E=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52ff0483-c7b1-4862-12ab-08dbd0ad78c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2023 14:12:47.6694 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b5edDWO8QVO8LgmdSbcDpy1gs4PUFRrPt6KdjRXtLjqf5WOz1lK3Rt08kTwvpfp3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6696
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
Cc: "Chai, Thomas" <YiPeng.Chai@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

                        dev_info(adev->dev, "socket: %d, die: %d "
-                                "%lld correctable hardware errors detected=
 in %s block\n",
+                                "new %lld correctable hardware errors dete=
cted in %s block, "
+                                "no user action is needed.\n",

Hi Hawking,

There socket/die id information is already here for new error detect,
For the accumulated error of the current block, socket/die information is n=
ot recorded now.
you mean we need to add socket/die id information for accumulated error?

Best Regards,
Kevin
-----Original Message-----
From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Thursday, October 19, 2023 9:23 PM
To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; amd-gfx@lists.freedesktop.o=
rg
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
Subject: RE: [PATCH] drm/amdgpu: refine ras error kernel log print

[AMD Official Use Only - General]

As discussed, please add socket id and die id in the output message.

Regards,
Hawking

-----Original Message-----
From: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
Sent: Thursday, October 19, 2023 20:51
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>;=
 Chai, Thomas <YiPeng.Chai@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.=
com>
Subject: [PATCH] drm/amdgpu: refine ras error kernel log print

refine ras error kernel log to avoid user-ridden ambiguity.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 5b831ba0ebb3..cebc19d810e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1034,10 +1034,11 @@ static void amdgpu_ras_error_print_error_data(struc=
t amdgpu_device *adev,
        struct ras_err_info *err_info;

        if (is_ue)
-               dev_info(adev->dev, "%ld uncorrectable hardware errors dete=
cted in %s block\n",
+               dev_info(adev->dev, "%ld uncorrectable hardware errors
+detected in total in %s block\n",
                         ras_mgr->err_data.ue_count, blk_name);
        else
-               dev_info(adev->dev, "%ld correctable hardware errors detect=
ed in %s block\n",
+               dev_info(adev->dev, "%ld correctable hardware errors detect=
ed in total in %s block, "
+                        "no user action is needed.\n",
                         ras_mgr->err_data.ce_count, blk_name);

        for_each_ras_error(err_node, err_data) { @@ -1045,14 +1046,15 @@ st=
atic void amdgpu_ras_error_print_error_data(struct amdgpu_device *adev,
                mcm_info =3D &err_info->mcm_info;
                if (is_ue && err_info->ue_count) {
                        dev_info(adev->dev, "socket: %d, die: %d "
-                                "%lld uncorrectable hardware errors detect=
ed in %s block\n",
+                                "new %lld uncorrectable hardware errors
+ detected in %s block\n",
                                 mcm_info->socket_id,
                                 mcm_info->die_id,
                                 err_info->ue_count,
                                 blk_name);
                } else if (!is_ue && err_info->ce_count) {
                        dev_info(adev->dev, "socket: %d, die: %d "
-                                "%lld correctable hardware errors detected=
 in %s block\n",
+                                "new %lld correctable hardware errors dete=
cted in %s block, "
+                                "no user action is needed.\n",
                                 mcm_info->socket_id,
                                 mcm_info->die_id,
                                 err_info->ce_count,
--
2.34.1


