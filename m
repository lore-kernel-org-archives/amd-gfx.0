Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F4C3ECAAD3
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Sep 2022 22:43:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E08510E36A;
	Thu,  1 Sep 2022 22:43:49 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A4D810E36A
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Sep 2022 22:43:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B2X3OEraRD6BL6DE69/68+dnVyt1lZosWH8urWZIKMLATgNIr4KEYKOQq+j0g0rHwJTB5FF3FtsdZy1w6vNke1xcmwj2ELtuPoMFBtSDRqEnIzWbb5dnfmS2IFyDwL34qHRXCdM30OPOX3jUGHNoGp7pISJKvNHOyMbOOJpWrcHcc02G8NLRopS6bWjps+mCYH5VltY6/iRFV9j2S5nuFA8PPN2iQ2iFbM0hy7BeLCSTUVwkVlMibpN30cG62S9npF40hAcDKoH96H2nU0NUVlyFAc/HBNHYzmZD9tylAOkNwk+MVMFMoKi2CIu99ZGfslQLmXfe+Oj8uiSS1amIXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uMU16xOE9BiGvIYux/nRxBY2MEGROIsf7R9ppuWAMeM=;
 b=L6aWBafv89ZOYXMDz+9v2whHHDMuO1N0aM93ePc/kCtWV2sb8qxibr2LE05FiiFTgu19+q6gRYsMSTdN/6fQ8t9q5jso2vaEzREVdDvVqnaDyf8TaG1BgAvMhnTyq8YrFyWrC+taMbDZ0bNRkQ+Q+28QOWz8/t3spccryePxlozSA4LeYlQPU97md4RVx+MDgfzgUMcHD6856n48zCrVF1H1GlsGkoarMB9q21ZrUDYrJO8SaOoYi0KpCiU+yxYiDeJ+HGIw4bGn8Da5ush30lB2DhCWfj3Ku3HI818HzCfDOuyPJXME3+xXZ/h8GZ0oscs7OUVxwGECYYhZKEaD+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uMU16xOE9BiGvIYux/nRxBY2MEGROIsf7R9ppuWAMeM=;
 b=JecDjlGsRv9pUzajCm7aWFzNU1zQDifK5mWjh48fD1pBgzWHS0PNDPUN+87LuArwVI7rJZzvFFHsXxJAII+JRe/kpS7lfbksOzy2x59YUhfwt4bBEeTe/nqqJptMLtb2jd2pjp3HWb5WP2/cIAJ4NVHfoXUjPl+62dA4YyU8Y5U=
Received: from BY5PR12MB3873.namprd12.prod.outlook.com (2603:10b6:a03:1a3::18)
 by BL1PR12MB5128.namprd12.prod.outlook.com (2603:10b6:208:316::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 1 Sep
 2022 22:43:44 +0000
Received: from BY5PR12MB3873.namprd12.prod.outlook.com
 ([fe80::41a0:9c0a:a18e:38a]) by BY5PR12MB3873.namprd12.prod.outlook.com
 ([fe80::41a0:9c0a:a18e:38a%5]) with mapi id 15.20.5566.021; Thu, 1 Sep 2022
 22:43:44 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdkfd: Match GC 11.0.1 cache info to yellow carp
Thread-Topic: [PATCH] drm/amdkfd: Match GC 11.0.1 cache info to yellow carp
Thread-Index: AQHYvdTQgIzJmWumbEuknOJaaV3Uba3LLFeg
Date: Thu, 1 Sep 2022 22:43:44 +0000
Message-ID: <BY5PR12MB387318D60C341DE66211E724F67B9@BY5PR12MB3873.namprd12.prod.outlook.com>
References: <20220901072959.4085193-1-yifan1.zhang@amd.com>
In-Reply-To: <20220901072959.4085193-1-yifan1.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=34b043b8-40e9-44e4-825c-630adb7fa5f0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-09-01T22:42:35Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8c069cf5-5069-4cfd-7ddc-08da8c6b6d09
x-ms-traffictypediagnostic: BL1PR12MB5128:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hl6Xaq1LFU0kHCttzd6toQlsN/E4M+Fz/vFUyEEMWXfzC8CmE8ubazOXa3O2cawxF3D/2mAP3QbNLrNbRJ55gx/ggeByV3rXg0G4xyCTIArJoS+iCwC+ZnbtTEYEXryxC4cSmFy/FMnkq7L6gLTIZw9kARQPJqoSt/4v3Prp+Uh18n62//NA9la9pPE752xYnaMGhd4qlW/CgrVkwwiJC+Zm3K7JOApEaCNkDfLJRudEwvqvIooWyHrAzNErQh3RNJ1/9EYu2V+7/am8dyWFR8nKqnQ+DjLkvYc/vv1FkzZOBQExsclCxvmyZxluObNj6XgYOAvE6iY5TEmgLmmsjfGOx7tMw+xnccwCqv3iI9wnD6t7nkqL0DNuYqzCTw+ItSDaqgFGfLCiZxHIwHAXAa8RhrDHgmRqEBL+kKAWngegG/XZ7y9rGiwKgm5Q+8HXgpuOZ7eK3sPRrz5P3SxxLxWDiKlgxS5x34owrQX48YQUYco7IV6xz3NZswDSRHmUFK+u4m2DYtxfrxW5RYMPuY6MDFbHtfIlOxOoP8ANqUKQcuRh84jLItCQfPLHqDNVGsg7HX5zOiifmuv7aeaSe7FiDdH8iMhNtyUK4YmW7QALqgUf0Mu2K5fVcbeVEoF7n1qKNtg1tMGhawmfiMSvY892JhfpN93wfMYFORB/BT3LfvOu1fxpHGxwSZL34rhrytavwvSNnfMD6KvMxMNtBmhV9qw9gzqlmqrmQjsMMulTly/sOuvb4gZM3DT8RmjPeZwuFaCPWH1i3VknCMxx6w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(366004)(136003)(376002)(396003)(39860400002)(346002)(38070700005)(64756008)(66446008)(122000001)(38100700002)(66476007)(66556008)(76116006)(66946007)(8676002)(4326008)(55016003)(316002)(2906002)(5660300002)(186003)(54906003)(110136005)(83380400001)(52536014)(71200400001)(478600001)(86362001)(7696005)(6506007)(53546011)(41300700001)(9686003)(8936002)(26005)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RrjndW3C/ew+fqHrc0yfUWqpDufaFwCOz3uCCTRXZ8qEL/rUmiL0/MeJAYSQ?=
 =?us-ascii?Q?JaAc04WaT/SrBIRx+rSWzBEmfyv6TvhSIIY0Yy01TYVNg/CygEXxBTubioKA?=
 =?us-ascii?Q?24K3uhBXrYxgVI8bHJtANOkwPuzRcHZ1uMfYcyGuyBGKfnRre+2x3mKK0GyV?=
 =?us-ascii?Q?Sj0u1H62MLbbDI2hkfdlV0clfusL21geIGXpne/DhI6p7w+N//m/DA33bIS4?=
 =?us-ascii?Q?b5vTtIpte/N8FLrPZ4y4NVFW/DX52qoOHBltomJFTFOYmTMrs2qKg3spW5i4?=
 =?us-ascii?Q?6FhhIhNRbztgBx1wJBDb0SlZvgtOUycxYmg5I/Fam9TKcWHHbRO17JcdmrtC?=
 =?us-ascii?Q?6wEd7dHKYiXI6DCMHFc/7J4G+a5ad3qOhcFe6S2PXH1nMAqzZKMZRSZtkjoN?=
 =?us-ascii?Q?m7CYIJJcejRzKZcY3z9nawhYLR1s4PYwfs17+LECBMSlKMHrSLXX4Xc9K6Ps?=
 =?us-ascii?Q?pYt33MHPZZ/dhGMbrdngy5BssM32joPiQHCQntyIUsr1hGpy0cGazvlPVII7?=
 =?us-ascii?Q?vdVqAk4QJs32lnHDMpdQtat41S/wX4t3AzCeDmmjQXZCIFQ+VF5qmfyD8Zcz?=
 =?us-ascii?Q?4HjM4/KZ80yqNCiLals8EFzpP6sxwCr8QmD3Ay95wh0VFhyNZc/tsk015D1b?=
 =?us-ascii?Q?vpyB3cqGj5sb6DryB3IJjW3XGzjz6YAlSvIgll/ay2se0gaHbhuv5Nl+8oIp?=
 =?us-ascii?Q?5isEdc1tNr+e+0O+BC8SOUMu8ObN0C9xWKAA4K1f2nXsWq2oLpUO7iTXnrpp?=
 =?us-ascii?Q?j3nwTkn42cTO96rTY1r+UAwb6gtq+CMY6aKg8lgYgmBvvlpxmfZdpawA2sIo?=
 =?us-ascii?Q?OYyYhjar7XSuaXB8usywXaOcGhBN4ktUwifxXOIQIVS+n1es3VjZHdQp3rF2?=
 =?us-ascii?Q?Eltat1iz2jhs41WNWf3OyjufwDL1jsALr3NSmhycq/kQRTYy9uavixHHT+sn?=
 =?us-ascii?Q?xnxB6fwL19RCIcQLRlGnwJjtPQXT+ikjUr3ZTo2L8jL6o4rlwuddNnDOa/uG?=
 =?us-ascii?Q?AORM0rQ0sO1nXCMnLzwndigYa/5VcNAgUY8UOXVyHD4K2j2qYEqSgLTAAWmQ?=
 =?us-ascii?Q?8xit/PZjMFakM9yS6KyIBt2jmHDfFxma5ZZFxTUeCNhS/xzQIHp/+HGIYSVB?=
 =?us-ascii?Q?mZq9ni1Zudp2g0z3DsCG4Vpsf8NqkgfzaSAOJp4Ba6vP2FzHy/ilJ2GK3A19?=
 =?us-ascii?Q?R8EdMXWMjVv1rmcn1aQhvrplJsfgA7nMkg8iUwhi5c1til7Wrf+d6SBdA0eW?=
 =?us-ascii?Q?QQ6xpACl5D/d/TmcpuQ+w54djcAtM8UileoXtoi8snTWk0Ht67qIJRIU0a9V?=
 =?us-ascii?Q?Co5H41SV34R6WnM6jJQoIbu7F+sOk8PmxP6VSkV2NmVhAeEixdTn26UM8hg1?=
 =?us-ascii?Q?k/1aZRNM4/XrtC7gOOlGn7d1zLn2StrHpq4hxeYxFA6IOMejdWXykrdTjOny?=
 =?us-ascii?Q?/D2DdQUsZsColxDIiQgNoiscUEcr6CLkFFyVb/opy4sBKCPnzp45wDsSEQ+d?=
 =?us-ascii?Q?14cbvQJwGLP2DVY5SiuVvLKc0XeR26TV39sfPXYJwRyN9vtq/OQ5UlTsIugy?=
 =?us-ascii?Q?eyKLMLCFGGwzkXZweuNYIUE89kOn3PNLSq/YZEp4?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c069cf5-5069-4cfd-7ddc-08da8c6b6d09
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2022 22:43:44.4918 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MLpGwVu1rBywNEntvuARTuNX6Eyr94GeSsc3qlO9DwDIbTJqusyoxRat4SKmdq6NnO8pyvRvScQDBqPzej/Esw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5128
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Du,
 Xiaojian" <Xiaojian.Du@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Reviewed-by: Tim Huang <Tim.Huang@amd.com>

Best Regards,
Tim Huang



-----Original Message-----
From: Zhang, Yifan <Yifan1.Zhang@amd.com>
Sent: Thursday, September 1, 2022 3:30 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Tim <Tim.Huang@a=
md.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd=
.com>
Subject: [PATCH] drm/amdkfd: Match GC 11.0.1 cache info to yellow carp

Current discovery table doesn't have cache info for GC 11.0.1, thus can't b=
e parsed like other GC 11, this patch to match GC 11.0.1 cache info to yell=
ow carp

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/am=
dkfd/kfd_crat.c
index 24b414cff3ec..1c500bfb0b28 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1516,11 +1516,11 @@ static int kfd_fill_gpu_cache_info(struct kfd_dev *=
kdev,
                case IP_VERSION(10, 3, 3):
                case IP_VERSION(10, 3, 6): /* TODO: Double check these on p=
roduction silicon */
                case IP_VERSION(10, 3, 7): /* TODO: Double check these on p=
roduction silicon */
+               case IP_VERSION(11, 0, 1): /* TODO: Double check these on p=
roduction
+silicon */
                        pcache_info =3D yellow_carp_cache_info;
                        num_of_cache_types =3D ARRAY_SIZE(yellow_carp_cache=
_info);
                        break;
                case IP_VERSION(11, 0, 0):
-               case IP_VERSION(11, 0, 1):
                case IP_VERSION(11, 0, 2):
                case IP_VERSION(11, 0, 3):
                        pcache_info =3D cache_info;
--
2.37.1

