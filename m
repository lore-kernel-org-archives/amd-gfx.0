Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EB42C77B60
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Apr 2023 06:50:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D26910EC60;
	Fri, 28 Apr 2023 06:50:00 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AA9C10EC60
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Apr 2023 06:49:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JMJFuWbftyDDc1KK83eHdoLGIZgrlEpcqV6ArxOklZMxpZwLPsF3H0yDCVW0MyajrfHBzwMDbjpQFc3hGwDGvizMW/QIwgz5jsmWTUevk5w1euBz5rqAQIvjJfxxV1+i09JkLdFXEm36QAkQt/BH17sQoIhOX9bXO7PlfIXcQiByvLY+Dzsknqs2yd9K8VIRaCNeFGbIHkF6KrAgW59ujv5fYiVPlm+5fp6W+GaVqp/ULzoE4MqKcdG7oM2LYDNZ5ZBiTldsodSHBMl46HY8EwTZcM3VJF2JtdW6ZfS0fv6PFTeBtt28q9NTxhRgL8ON/mHP9mCQ9/BJGByI250kpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1QBI93BR6AKS3u8yTNwlCoCrs5AQZ98CcH96+BGPZE=;
 b=DwbuG7cdIdjKmhByA/jV1jJ7xOShvbLWMZ1SdV8WtT99gIgFrDh68ruuwVQfGxHtbzMtBuCz8KY6GlrBPsP59WcG0Wvv48sCv4Esvi8bAUHhwolo/xXDp8vOvP4TB1M2mmTo9Ta8W2Zy5iPJ/3nXBS7iHPU0nRq7GFJz2ZUn/EXjLMoYRapCcMXlX1VUZ5O8ah+fR3gJYB1cZrArivQG2lRH1JPdDCmNdoiWdhy1sXur+lwrIhSQhPGWNuwuRBSWasxuLo5sicjddf6K8gbUa579BD4cz23CBlnDHyEscI1vpH82KE57mo+X7w//KzLgqyuj1GKzJw0XoU/U7nw2RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1QBI93BR6AKS3u8yTNwlCoCrs5AQZ98CcH96+BGPZE=;
 b=QAe6L6DgXb99DbQia4kGg6XgZ/td9OO+Vdzmn/KbgCzykR4e1wbJxCbGC5FO0+a/Xfln8ogGgkJr3JaWgQb9hLmMQzZ8qTSZRcErvUrvw/mhBj1Hn67v70CL2rqRTQTb/v7823ljRZy494iG0Nt9rwYMUBYRK8aAFTALL/6zMyY=
Received: from DM4PR12MB5072.namprd12.prod.outlook.com (2603:10b6:5:38b::22)
 by CH3PR12MB8725.namprd12.prod.outlook.com (2603:10b6:610:170::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.23; Fri, 28 Apr
 2023 06:49:54 +0000
Received: from DM4PR12MB5072.namprd12.prod.outlook.com
 ([fe80::fb6c:ec84:7b2b:a4e4]) by DM4PR12MB5072.namprd12.prod.outlook.com
 ([fe80::fb6c:ec84:7b2b:a4e4%7]) with mapi id 15.20.6340.021; Fri, 28 Apr 2023
 06:49:54 +0000
From: "Chen, Horace" <Horace.Chen@amd.com>
To: "Wang, YuBiao" <YuBiao.Wang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Enable mcbp under sriov by default
Thread-Topic: [PATCH] drm/amdgpu: Enable mcbp under sriov by default
Thread-Index: AQHZeZd4zsc7jJTzUE2kqEtzra7Oia9AR9uQ
Date: Fri, 28 Apr 2023 06:49:54 +0000
Message-ID: <DM4PR12MB5072B3D16F60B619C08BA3C2E16B9@DM4PR12MB5072.namprd12.prod.outlook.com>
References: <20230428060449.1215710-1-YuBiao.Wang@amd.com>
In-Reply-To: <20230428060449.1215710-1-YuBiao.Wang@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=b8222b51-e83c-485f-be08-f57007aadd00;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-04-28T06:49:03Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5072:EE_|CH3PR12MB8725:EE_
x-ms-office365-filtering-correlation-id: fe3dd7e8-199e-49a1-607d-08db47b4c5df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MGpE6QDLz1huvR2JPmJ2YTlqF4QPOBTEYvxRCCjR32tVBtDCiubXqi6ec49nbhlmneEShLCDNLTYmd260Xo00Bm6G8h1ponaMEoHz6eNx+aiAh+JV64yx/9Z2dpg3xOH/YKs9Fw9w2cPXQFnClPG2AQFqrFvQJxMvPX7fJ9MefScy9XhXrwgJEsnqbULldaswsx01dAnjgkQ8DyLA/QfDGp0vvWqiFhiPZ6MgauiYpJXE2pz2x8NmqSzCzEiVr2vUboGQdOAgXuGYb9d0kpq+lhxGATpUueoIX6637T/oh9TMFdkvwuNIlW0soVvb3bRWcaolP0Ic0ylN4eGZFNhrVj+q2nXKauKUjNGRTwKpMgYcXFalqpQ2m5Z+jUwhci3gJDuL5Y/svmxAMUqXZdfjwyLAU1cgvl+BF2bML82DGiJvm5eLdMw6TxEEnQTwLE//mvjgNa4qORVGO+c2o1YyWSZ5zfqhEyjre6XGxxSWpcH3MRgKzQWhpJmA+Vol9hWdM/GHCrn/P21DBQRsUS56FdUtoxtkC55aURPNm5/WPAW38WalRDRIDyplW+7hNSjRJWBO3vJlXo0Z+FRwAx5MGwBpN2SoRKsOGftPrKH6omuhnTi7vHHwhjSN93wBrA6
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5072.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(366004)(39860400002)(451199021)(110136005)(54906003)(478600001)(52536014)(5660300002)(8676002)(8936002)(2906002)(38070700005)(86362001)(33656002)(64756008)(66476007)(66556008)(66946007)(55016003)(76116006)(66446008)(4326008)(316002)(38100700002)(41300700001)(122000001)(26005)(53546011)(9686003)(6506007)(83380400001)(186003)(71200400001)(7696005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3YGwHlOf4631yfltlER5+oSNDyMbHz707AFD4bZJoAG86+/ev8N7W8AWnMGu?=
 =?us-ascii?Q?Axl68m5qQ5s8J3/Oro4KFFErQ/RtQlHb9X2DC3ms3RBNsqupgSpmwDBlbzYS?=
 =?us-ascii?Q?eGLQBdvQya+7oCXvI2FTYRBUSBTcNQi7xQUm/ykG5dBuW+xVxmV+8abOYjYw?=
 =?us-ascii?Q?axE/aO+XRg9t04KOIGv4XCgQbpxRAN4gqlpOFXLRjCnxIWvQgrreGjtg3GNg?=
 =?us-ascii?Q?ksP4G/ZnD1234vfX3oJ8JMNHsXXnOv3pLG91QoH8ysC2Gh1N/llNr8ibzczc?=
 =?us-ascii?Q?aGWvh4YDbSFheyyFyPhgR6FLw7op9kvvuLGgIk5ltHYoNBb5UeDJK4Z0phZy?=
 =?us-ascii?Q?ViqHRwZa6jRh41UzepERBzlk75EwSnkHVWFQ0Sh+glrJIJfmB7WCE9ns4LFO?=
 =?us-ascii?Q?OrhgAPvW8AoFl3VLk2dERuH2VuDJU88kv8gioJOhg232/kE/6+1bqFXwLYlU?=
 =?us-ascii?Q?yLv8g6Wc4DaKuhgoDljlG01oG2yj/CgLBxr9u5orIcjx0ELcdyMrJfSv7IPD?=
 =?us-ascii?Q?vF9lVAUy14JyGmYDB2iUi88zbnYj3ULhCJrTa7426hyjhcg3VcgvDXCXH79i?=
 =?us-ascii?Q?oC4clxMhcDTi+NHxJz+f0eJraXG4VYXmDDlpTU9tXjVgPnGZzxeeOEgN1LP9?=
 =?us-ascii?Q?VO6zy0EhhUnmKxdjd5Q5u9qqIW6uJcu4e3HwPXNWa2UtZEh78UmOsrkRbXUJ?=
 =?us-ascii?Q?OjURA2QO5Hdq0IMv3sPF9ThYLlXTyKMGFPIXLShPERDjJ9tOtvW+W5Gv9M5z?=
 =?us-ascii?Q?Q+QhR2H1ylM+vdCMtrduXR80735McmdomFa8TP41sZVKSmQAWvBxGGmvxs5p?=
 =?us-ascii?Q?GFndw+Di37YZ/yesli+AZXYQU4ijrGTNSXJBKTZ7vXH0F8Zu3oNnz1TB4pUO?=
 =?us-ascii?Q?Si83k8ffj8Pvjhcl7vmMbb5o43mGz7yaQ8zLRPynF0ybuWbgoP27HYXStper?=
 =?us-ascii?Q?1TL1xY8bZ1QnSiQZoXcC+s11ohWDfeSB62KpcU0BfINQZrBUJTvdmt9Ljlmz?=
 =?us-ascii?Q?mpMOojlJBMsLtOtzrFDAxTwHp0U9YHQ64IyCydb0c48OtaLhkUL2xsmgirDn?=
 =?us-ascii?Q?XhSOThWU26W8IXYvAEzbGwfvzEUgS9p6WIK/k9mvzswaw/pBgMRM7ZK6uvUR?=
 =?us-ascii?Q?oYg6I4tOkC7ZsRjp5tHKVh/mBVvM5GSBypdU2hGzPujs8SfiGo7dj+sQYNit?=
 =?us-ascii?Q?lKidmaYlQWWVFEnMJ3sa+XU6Ora8BKa+63rHD1mpz4mAWO9epQJiPJU1bOuF?=
 =?us-ascii?Q?ReR0nuE+I1XqCXbuPMzYUCvRmZMCZqes0TV3JW23Y5bSxE8sKPNURwWVUR7T?=
 =?us-ascii?Q?drtZ6fIaxylC+CsZIVeJ/ulIqATQuqwcOD7FkueGrQczhLJm2VewwyAJAJQt?=
 =?us-ascii?Q?QTeLzfnBv0zA9x1dWqU0MBAVmp6R/ZAH35Zq2scZQa0zjmSYE9+BuvXaCKOc?=
 =?us-ascii?Q?uW1vmxyNY6QDMP+O/BZ/N1lTGN+HeWurXndBi7CRfEuV9jQKxKHKaXgZPLk2?=
 =?us-ascii?Q?bloBR5FaUBFISUTPQ0EyiRDJOvMimXJrznDPboe2dyyTeVr03Cmp0sh/gJ4o?=
 =?us-ascii?Q?9SiBmfqQPTeQkNf5AB8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5072.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe3dd7e8-199e-49a1-607d-08db47b4c5df
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2023 06:49:54.2125 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mk/kVuAEOKa4tm/sU0DEqLix6k4gEcZwdwsOJTKgEKnCwYRAehalCUNjUEXRu/at
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8725
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
Cc: "Wang, YuBiao" <YuBiao.Wang@amd.com>, "Xu, Feifei" <Feifei.Xu@amd.com>,
 Kevin Wang <Kevin1.Wang@amd.com>, "Tuikov, Luben" <Luben.Tuikov@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Liu, Monk" <Monk.Liu@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Reviewed-By: Horace Chen <horace.chen@amd.com>

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of YuBiao W=
ang
Sent: Friday, April 28, 2023 2:05 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wang, YuBiao <YuBiao.Wang@amd.com>; Xu, Feifei <Feifei.Xu@amd.com>; Che=
n, Horace <Horace.Chen@amd.com>; Kevin Wang <Kevin1.Wang@amd.com>; Tuikov, =
Luben <Luben.Tuikov@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com=
>; Quan, Evan <Evan.Quan@amd.com>; Koenig, Christian <Christian.Koenig@amd.=
com>; Liu, Monk <Monk.Liu@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: Enable mcbp under sriov by default

Enable mcbp under sriov by default. Asics with soc21 supports mcbp now so w=
e should set it enabled.

Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_virt.c
index 9dd474262c29..1311e42ab8e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -65,8 +65,8 @@ void amdgpu_virt_init_setting(struct amdgpu_device *adev)
        adev->cg_flags =3D 0;
        adev->pg_flags =3D 0;

-       /* enable mcbp for sriov asic_type before soc21 */
-       amdgpu_mcbp =3D (adev->asic_type < CHIP_IP_DISCOVERY) ? 1 : 0;
+       /* enable mcbp for sriov */
+       amdgpu_mcbp =3D 1;

 }

--
2.25.1

