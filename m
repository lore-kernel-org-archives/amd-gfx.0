Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFE48C433FE
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Nov 2022 04:43:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7542610E3E4;
	Tue,  8 Nov 2022 04:43:37 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 811DF10E3E4
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Nov 2022 04:43:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FzK4FWVXEe0p/4pyLIRFjleyNP/ICaMhbIB9RpziG+C7zzgvq0CndquHum/Ig3Ynf6Q3lOS5o4fo16l1NNp3N9WrgLCAjOPikgH9BCi2JjpL+eXdx4viBo4YuXxqteDx5BsVS/Alk+LkXT+9zvVkWLV4aM23SAO6dJalq9T5zLRk56Sn9szJYr09BAE6i7iXbfvhRHn61uzDkjyoOoVkL6QG3CJip6qK/dsJC6LnsCpulRc9HKDkc0a5aM7aho2YK0hhd+Ho+BqcNJBE/pgzh/gkS0s2NjBksD4AWIYkUTl2947Uj2v803j74jzWyVz4suf94w3RkwbCUFDaKDbDBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HBKfzkKNxWA/A6iCwlv+V4sT/gLr4StUfovuqBFRqzs=;
 b=FEUWweQ16LehD0Ibl+yNcuCjWSzI8tmM2VAJs74rSieLM1k+OiBGwslvU719OYI3LWBjZ/sTDtVWU5XTZNUKPjwuJCepqv6FyrTPl1Hguf5xFoqi/4egEnCY4EczRyRy9Yk6oGKyhmFjcLcRvqfRFNU7sCxSJAYrrRPBvA/ZmWXF9qNs3lLPE4yAfkRaovHOv1RkIItzEvl5wwWs0o4qsOAf0fFIIF9B89cQ9Aemw7vp1QkPW7LOmfysDyZEX8qEsxS10g7qLtDPG3yL1zbS/GJnKMiaPWxleDQTVKaeaijaGHVHfzOmYFA9ztZ3x438CYg5JCsv43gyo+97VsEBaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HBKfzkKNxWA/A6iCwlv+V4sT/gLr4StUfovuqBFRqzs=;
 b=gwR2b5NgoE9Esyx7abLO1YIC1Lo1Q0q0JDucAYSu7P86KLsFviIJDSnnuuAP1XImeepVWh432yDJyMQRM+xQm1OnxjuNtKjef7Ld1u7gA16j2VC0fIZCsW+322qG61adkXyphS/c2ir5lQjggNgGyjBRBRJKxV544OtlDHBrXTg=
Received: from DM4PR12MB5181.namprd12.prod.outlook.com (2603:10b6:5:394::22)
 by DM4PR12MB5182.namprd12.prod.outlook.com (2603:10b6:5:395::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Tue, 8 Nov
 2022 04:43:31 +0000
Received: from DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::18c0:59fa:c888:156b]) by DM4PR12MB5181.namprd12.prod.outlook.com
 ([fe80::18c0:59fa:c888:156b%7]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 04:43:31 +0000
From: "Gao, Likun" <Likun.Gao@amd.com>
To: "Patel, Krunalkumar Mukeshkumar" <KrunalkumarMukeshkumar.Patel@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Pan, Xinhui"
 <Xinhui.Pan@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>, "Zhang, 
 Hawking" <Hawking.Zhang@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Add support to clock gating for sdma 5.2.7
Thread-Topic: [PATCH] drm/amdgpu: Add support to clock gating for sdma 5.2.7
Thread-Index: AQHY8n+/5yYQSkyOT0K5SghgRccp9640ZDiAgAAP2oA=
Date: Tue, 8 Nov 2022 04:43:30 +0000
Message-ID: <DM4PR12MB5181250E40583F3E2A8A84A8EF3F9@DM4PR12MB5181.namprd12.prod.outlook.com>
References: <20221107080501.3205127-1-krunalkumarmukeshkumar.patel@amd.com>
 <DS0PR12MB63911377B20123352536679B9D3F9@DS0PR12MB6391.namprd12.prod.outlook.com>
In-Reply-To: <DS0PR12MB63911377B20123352536679B9D3F9@DS0PR12MB6391.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-11-08T04:43:28Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2022-11-08T04:43:28Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: 543d608f-9758-47a1-8aaf-fba7a7c35b9c
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5181:EE_|DM4PR12MB5182:EE_
x-ms-office365-filtering-correlation-id: 0d278e5e-34c4-4dac-547e-08dac143c94e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BvaHjKRCPsq/FCVlCSP4MRMDGIJwJezEC0RKEA/6IQkZSftOBkliNNKIBJ6T8Qno2nFYSNKREVWhStKKeT780RJZ9mnDWyUssS5MSEXayxRCan31GG4lxT+KH40vFXtgcLUHIogqmO/73ZuTY5hqCqD6hYWPJwFtpJKdAQlUjbY+QMrw1hnJZKFzkO0+plhESEcJ/1lzlfV0/zDUEmzcduk9aaNI+Y9gOFl68719wPW2VTguT/xeujJlUq2+2FyARdZxVO5n3PCN7Hk3UjZYjGQjRVc+NaxpUQlmNuIP7rAFX7WPRt5xJ0iDoHHGcKEPlp8GaR18UkUkhgNSIYHaNLrAQ6qunh/rosxc9aXbJFRIp5BLx6+Eoe79jMPX+hvT35QeEh6WSuxDf40O/iZ2Y6PXORdQzd3z0mBVBpMMrq0JN/12k3mKb/5OqWnV4V0tWsZT7qbYU49C6UdVPpxR16Ll12Tu1ctM4tsVXBdoKw81THC9kbiffrfQfPIc1nHhVVl+qZQw4Vq3iggFF0o9T2lpcnzUw1G43gLtmkNReJiq/zOhkHsb7nP2b4wDq7IZ/FV/RyJ3jT6CmB4zVBqm9b62xRF0oibQcsEPs4+Lk1LeZdOSCIwRnPBaEBaUyGYiphmcWqcKVwMCBTgctW9eAJx5ouT4JPL/0801rHX3l/y4kkAUs7eRFFlWvsV1ncXAZrHorPAO2sOQ38tzrkgb1Xvm2YPz/5WG52ezQnYpFOW3vpIiYFNryazzUzezayoYCfAwTP2Z92puiABaZHamyBThexJj9vm8GOgJwOdBhfE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5181.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(346002)(39860400002)(396003)(376002)(366004)(451199015)(6636002)(54906003)(316002)(110136005)(8936002)(83380400001)(186003)(33656002)(2906002)(5660300002)(55016003)(6506007)(7696005)(53546011)(86362001)(41300700001)(8676002)(4326008)(52536014)(64756008)(76116006)(66476007)(66446008)(66946007)(66556008)(9686003)(26005)(921005)(71200400001)(478600001)(38070700005)(122000001)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ud4WJdSbYsdUstKr7D0WkaM4wNK4xRUDTkt1bMVKQCCobNdtm1hyiz886yoC?=
 =?us-ascii?Q?hwE4m5C1x9q+k7IsG0qhqtN+rFoy+wjkTanvj1UZXz9I8IoNL7wMIKb1gw+R?=
 =?us-ascii?Q?PF8EixJhsWesLnioCttWnaDiJU2JtjfOXbqwQaNNZR274zgDdynFWC92Dms4?=
 =?us-ascii?Q?1nxlDxCWw7hYfYlZNJjkqLIetq22azAWmo6tozlEC5JDdtSHaIttXwVC001T?=
 =?us-ascii?Q?CeVRKNwv4ZphKHa/nBZ/Z3NXs9GaZBHBVScl6C/YhsaIXR9OFLULHS1yJ6hG?=
 =?us-ascii?Q?Hrh5AsddyfeYw/apqlMXdIQzN6U696OhE1/0j92+FAMEMfyTu9kGlMSccGKa?=
 =?us-ascii?Q?d1DP8kunqLtlMyZJEXDRqli3Wh1EFdxMKz6Jm3SjcnGZTq8pG/QqdMODMDYZ?=
 =?us-ascii?Q?keoHl5aUR6nZ6utyKPefal7hloUy6/vKKgT9SprLnxz2JLw4/uWP3R/OyxSH?=
 =?us-ascii?Q?rVCbkM+2ICz7NInfvZjHCgT5oLnUox9goGBei9wRnQ7cpFNRmHXavfg8K9a9?=
 =?us-ascii?Q?iFcYn8jDsrOjY8ECLR/GaIpWbJ/Ej9zk4NTUvW8dtDJKSkATzk4qBe7D+9WT?=
 =?us-ascii?Q?6U9Kqazid0wZfSgksc1S0U1lk+6lYN0IvFkdNF0CMS+3+SMs0gz5MyPGFrm4?=
 =?us-ascii?Q?sUncnAko6TY8H6BPEZIPF+Sc5JVzACd0ePZ70EzgKILszdIS6CzPWJIP83vc?=
 =?us-ascii?Q?eGFnOjpYfAoyMZ93Gt8+98Rtr0+tuQZqoV9aLJiqg1E5IbIMkr21szfJ3B8p?=
 =?us-ascii?Q?mp9qpForU2d6rW2wzj33hlPYf1jxLj20GYjMKfjrgurI39+XDa1P/5lZrbU1?=
 =?us-ascii?Q?P9TsKyXn6KRG5y87uwgGWnFG53okKuAD9WZgzFo+SuAeJnqJLrf+d0ZevcZn?=
 =?us-ascii?Q?/D7MWMf035fiqHCYdpY8/FL1koQjVWXD7s1U6E5weZluatO3Fg36M93ogr0r?=
 =?us-ascii?Q?WTVyZrlUdPd+oBGBDpk1F89Oa+vKRfA0eZIaLpmvUKxMWkYvyEtf7PILBuVD?=
 =?us-ascii?Q?pGM5uwTuiq0ob4zkQBM6vkzkS7wniGDVHft28IwxRl3meKaYRDqumuStFgJA?=
 =?us-ascii?Q?sINBrIFn89fMnvZqrj+n9GCA/HliSfxsPmC4WCUONuemMfRMBsVfulTggyjH?=
 =?us-ascii?Q?0hHblOXKk5qCtFl/nt8eXFKMMSOjYanzgdcQRCBDUt41WRHHDzN40QmoJLOH?=
 =?us-ascii?Q?Z0aWEGiXIi1tMBQc7sQNw8awC0dmLXvqUONVLnf4JJt98Adby68njiAcuh/7?=
 =?us-ascii?Q?cAy2S2BMhqYFuxRXh80SUhRDqbt9Z3Gm6ziJaepJF88xUuOofmOQ115LI4LR?=
 =?us-ascii?Q?VL28uZ0yoJPp+IIsvyoXodZIVinlYZu/H50ZvBcqq65swR9YtF54Cvv8jneX?=
 =?us-ascii?Q?I7TOvzh9dzUIcoXHqyDdyDW2m2Q2bszpwklWXXbsUpIX0YZgg2rGyfm3jRtx?=
 =?us-ascii?Q?2zH+altr8lYjMIsEjH/RLgsKB18WTfaOHJGmtB8TbcdAei9S2xy08tGDJuSq?=
 =?us-ascii?Q?djKIIOb6eWYJaInmu0PDg766wpNaVVOGVqKMr2uFb9ZkQYoqahu7JXpBv8zd?=
 =?us-ascii?Q?3ge/C/49lMDhAliQu2Q=3D?=
Content-Type: multipart/alternative;
 boundary="_000_DM4PR12MB5181250E40583F3E2A8A84A8EF3F9DM4PR12MB5181namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5181.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d278e5e-34c4-4dac-547e-08dac143c94e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2022 04:43:31.0200 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vW5TZ9MuhAShsJT3Az2HQ/RGC4iAvJ5CSCKbHsbCRLexsnFKNGZx+cI1I1ajIatp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5182
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "S,
 Shirish" <Shirish.S@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_DM4PR12MB5181250E40583F3E2A8A84A8EF3F9DM4PR12MB5181namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Looks good to me, this patch is Reviewed-by: Likun Gao <Likun.Gao@amd.com<m=
ailto:Likun.Gao@amd.com>>

Regards,
Likun

From: Patel, Krunalkumar Mukeshkumar <KrunalkumarMukeshkumar.Patel@amd.com>
Sent: Tuesday, November 8, 2022 11:46 AM
To: Deucher, Alexander <Alexander.Deucher@amd.com>; Pan, Xinhui <Xinhui.Pan=
@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Gao, Likun <Likun.=
Gao@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org; S, Shirish <Shirish.S@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Add support to clock gating for sdma 5.2.7


[AMD Official Use Only - General]

+Likun, Hawking

Hi,

Can you please help with the review of the patch?

Thanks and regards
Krunal
________________________________
From: Patel, Krunalkumar Mukeshkumar <KrunalkumarMukeshkumar.Patel@amd.com<=
mailto:KrunalkumarMukeshkumar.Patel@amd.com>>
Sent: Monday, November 7, 2022 1:35:01 PM
To: Deucher, Alexander <Alexander.Deucher@amd.com<mailto:Alexander.Deucher@=
amd.com>>; Pan, Xinhui <Xinhui.Pan@amd.com<mailto:Xinhui.Pan@amd.com>>; Koe=
nig, Christian <Christian.Koenig@amd.com<mailto:Christian.Koenig@amd.com>>
Cc: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org> <am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>; S, Shir=
ish <Shirish.S@amd.com<mailto:Shirish.S@amd.com>>; Patel, Krunalkumar Mukes=
hkumar <KrunalkumarMukeshkumar.Patel@amd.com<mailto:KrunalkumarMukeshkumar.=
Patel@amd.com>>
Subject: [PATCH] drm/amdgpu: Add support to clock gating for sdma 5.2.7

With this change it will add support for clock gating for sdma 5.2.7

- Additional changes are to re-arrange the chip version sequentially.

Signed-off-by: Krunal Patel <krunalkumarmukeshkumar.patel@amd.com<mailto:kr=
unalkumarmukeshkumar.patel@amd.com>>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v5_2.c
index 809eca54fc61..404b255cb4e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1647,12 +1647,13 @@ static int sdma_v5_2_set_clockgating_state(void *ha=
ndle,

         switch (adev->ip_versions[SDMA0_HWIP][0]) {
         case IP_VERSION(5, 2, 0):
-       case IP_VERSION(5, 2, 2):
         case IP_VERSION(5, 2, 1):
+       case IP_VERSION(5, 2, 2):
+       case IP_VERSION(5, 2, 3):
         case IP_VERSION(5, 2, 4):
         case IP_VERSION(5, 2, 5):
         case IP_VERSION(5, 2, 6):
-       case IP_VERSION(5, 2, 3):
+       case IP_VERSION(5, 2, 7):
                 sdma_v5_2_update_medium_grain_clock_gating(adev,
                                 state =3D=3D AMD_CG_STATE_GATE);
                 sdma_v5_2_update_medium_grain_light_sleep(adev,
--
2.25.1

--_000_DM4PR12MB5181250E40583F3E2A8A84A8EF3F9DM4PR12MB5181namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
p.msipheaderdf3d92d6, li.msipheaderdf3d92d6, div.msipheaderdf3d92d6
	{mso-style-name:msipheaderdf3d92d6;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"msipheaderdf3d92d6" style=3D"margin:0in"><span style=3D"font-si=
ze:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">[AMD Officia=
l Use Only - General]</span><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Looks good to me, this patch is Reviewed-by: Likun G=
ao &lt;<a href=3D"mailto:Likun.Gao@amd.com">Likun.Gao@amd.com</a>&gt;<o:p><=
/o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Likun<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Patel, Krunalkumar Mukeshkumar &lt;Krun=
alkumarMukeshkumar.Patel@amd.com&gt;
<br>
<b>Sent:</b> Tuesday, November 8, 2022 11:46 AM<br>
<b>To:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Pan, Xinhu=
i &lt;Xinhui.Pan@amd.com&gt;; Koenig, Christian &lt;Christian.Koenig@amd.co=
m&gt;; Gao, Likun &lt;Likun.Gao@amd.com&gt;; Zhang, Hawking &lt;Hawking.Zha=
ng@amd.com&gt;<br>
<b>Cc:</b> amd-gfx@lists.freedesktop.org; S, Shirish &lt;Shirish.S@amd.com&=
gt;<br>
<b>Subject:</b> Re: [PATCH] drm/amdgpu: Add support to clock gating for sdm=
a 5.2.7<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p style=3D"margin:5.0pt"><span style=3D"font-size:10.0pt;font-family:&quot=
;Arial&quot;,sans-serif;color:blue">[AMD Official Use Only - General]<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div>
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"color:#212=
121">+Likun, Hawking<o:p></o:p></span></p>
</div>
<div>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</div>
<div id=3D"ms-outlook-mobile-signature">
<p class=3D"MsoNormal">Hi,<o:p></o:p></p>
</div>
<div id=3D"ms-outlook-mobile-signature">
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"color:#212=
121"><o:p>&nbsp;</o:p></span></p>
</div>
<div id=3D"ms-outlook-mobile-signature">
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"color:#212=
121">Can you please help with the review of the patch?<o:p></o:p></span></p=
>
</div>
<div id=3D"ms-outlook-mobile-signature">
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"color:#212=
121"><o:p>&nbsp;</o:p></span></p>
</div>
<div id=3D"ms-outlook-mobile-signature">
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"color:#212=
121">Thanks and regards<o:p></o:p></span></p>
</div>
<div id=3D"ms-outlook-mobile-signature">
<p class=3D"MsoNormal" style=3D"background:white"><span style=3D"color:#212=
121">Krunal<o:p></o:p></span></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> Patel, Krunalkumar Mukeshkumar &lt;<a href=3D"mailt=
o:KrunalkumarMukeshkumar.Patel@amd.com">KrunalkumarMukeshkumar.Patel@amd.co=
m</a>&gt;<br>
<b>Sent:</b> Monday, November 7, 2022 1:35:01 PM<br>
<b>To:</b> Deucher, Alexander &lt;<a href=3D"mailto:Alexander.Deucher@amd.c=
om">Alexander.Deucher@amd.com</a>&gt;; Pan, Xinhui &lt;<a href=3D"mailto:Xi=
nhui.Pan@amd.com">Xinhui.Pan@amd.com</a>&gt;; Koenig, Christian &lt;<a href=
=3D"mailto:Christian.Koenig@amd.com">Christian.Koenig@amd.com</a>&gt;<br>
<b>Cc:</b> <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.f=
reedesktop.org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a>&gt;; S, Shirish &lt;<a href=3D"mailto:Shiris=
h.S@amd.com">Shirish.S@amd.com</a>&gt;; Patel, Krunalkumar
 Mukeshkumar &lt;<a href=3D"mailto:KrunalkumarMukeshkumar.Patel@amd.com">Kr=
unalkumarMukeshkumar.Patel@amd.com</a>&gt;<br>
<b>Subject:</b> [PATCH] drm/amdgpu: Add support to clock gating for sdma 5.=
2.7</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">With this change it w=
ill add support for clock gating for sdma 5.2.7<br>
<br>
- Additional changes are to re-arrange the chip version sequentially.<br>
<br>
Signed-off-by: Krunal Patel &lt;<a href=3D"mailto:krunalkumarmukeshkumar.pa=
tel@amd.com">krunalkumarmukeshkumar.patel@amd.com</a>&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 5 +++--<br>
&nbsp;1 file changed, 3 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/a=
mdgpu/sdma_v5_2.c<br>
index 809eca54fc61..404b255cb4e0 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c<br>
@@ -1647,12 +1647,13 @@ static int sdma_v5_2_set_clockgating_state(void *ha=
ndle,<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; switch (adev-&gt;ip_versio=
ns[SDMA0_HWIP][0]) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(5, 2, 0):<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(5, 2, 2):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(5, 2, 1):<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(5, 2, 2):<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(5, 2, 3):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(5, 2, 4):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(5, 2, 5):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(5, 2, 6):<=
br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(5, 2, 3):<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(5, 2, 7):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; sdma_v5_2_update_medium_grain_clock_gating(adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state =3D=3D AMD_CG_STATE_GATE);=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; sdma_v5_2_update_medium_grain_light_sleep(adev,<br>
-- <br>
2.25.1<o:p></o:p></p>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_DM4PR12MB5181250E40583F3E2A8A84A8EF3F9DM4PR12MB5181namp_--
