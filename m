Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D28A8C7EE23
	for <amd-gfx@archiver.kernel.org>; Thu, 11 May 2023 02:06:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99D1610E186;
	Thu, 11 May 2023 02:06:35 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C382710E186
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 May 2023 02:06:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N8F05TJ5GoSwIeDEIdGTp8zwriOXipiiczIHvPS4Djef1ynsFbxbd7b3DBxbC+VyKUStYPKNL47tuFCYD/Hqy42s3pMRBOsLvlEN8bXqeva4Ar0QLxIxbAgQ8QSLzfkVF6IYPNNnyojXEUEBixzdDBosFcFYtItbM9zM2b1jSDsmURjsR8jozpsRRpHOkdiuUp+JQy61kAp0wy8hjVLiSm8rZuhEWjJjUz3JQr80IdZIQWynwn5lxmlbj93tVIKLW0umWHOIonrxaytrJRgS85tLUEqeZ6prOJRDL8drh9Bwpdf1YXFlnb9XN7SsgXjDXfMwdzztPz7ZBBhGR8TLCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UWFAb68JUDNST11zxB+CqjPNKbk6BbYzy/fH6Kn//s8=;
 b=De/hQk3e0WI95uk6nLkh1uV6jdM4IJY8qyTvt2lFJ2hk2vimBYShjxqsnlPZSXUpYloW106A+1N34ZFOcwavSdUNbHnpiMcfkXknUH6VWDfMqWQ6UDtoiiili2Fnkm1c2uYkxT7GGwu5mSxd4B+5gTo0wufV4qNQiI35aqwQTZs4vswWyHW6opEl3YTmLS/VJ6QL6DjYcCAdVT0nlBDKIQgcRMUM9dl6k3nA2x7ZsFextncyn3CAxO42yQUQmb17jf2TiObu2kXlGpmMftXfkomG+MsPhrQgtnkf12Hjscz12xHGDIeN1sFlDuaoW6FA8SPShnTcMHkOHPCzzCKWyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UWFAb68JUDNST11zxB+CqjPNKbk6BbYzy/fH6Kn//s8=;
 b=Ot7AU4edFM89dTFF0q42R1HA4kFHVp1orTyVqrylz4Hch8TQl23LtUXtqbicyHPd+Rzcg+/0AyLAiFO21gXjAdX4Uztm/WhLRRwAVicCA7Rnx+Um0LsOpoHUshVE/VhMupBaZGmPdKnxIPNuA3Pw8UvB890V6aXra42UVTIaYKM=
Received: from BY5PR12MB3873.namprd12.prod.outlook.com (2603:10b6:a03:1a3::18)
 by PH0PR12MB8152.namprd12.prod.outlook.com (2603:10b6:510:292::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Thu, 11 May
 2023 02:06:29 +0000
Received: from BY5PR12MB3873.namprd12.prod.outlook.com
 ([fe80::2cf0:f3b6:c424:b9e7]) by BY5PR12MB3873.namprd12.prod.outlook.com
 ([fe80::2cf0:f3b6:c424:b9e7%3]) with mapi id 15.20.6363.033; Thu, 11 May 2023
 02:06:29 +0000
From: "Huang, Tim" <Tim.Huang@amd.com>
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: change gfx 11.0.4 external_id range
Thread-Topic: [PATCH] drm/amdgpu: change gfx 11.0.4 external_id range
Thread-Index: AQHZgxrQNDdImdxul06FqhGIthXBRK9UU+fQ
Date: Thu, 11 May 2023 02:06:29 +0000
Message-ID: <BY5PR12MB387313262D90DA8064D38655F6749@BY5PR12MB3873.namprd12.prod.outlook.com>
References: <20230510083730.1919231-1-yifan1.zhang@amd.com>
In-Reply-To: <20230510083730.1919231-1-yifan1.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=3f7af540-ad34-46d3-8eee-a4c68727977e;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-05-11T02:05:27Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB3873:EE_|PH0PR12MB8152:EE_
x-ms-office365-filtering-correlation-id: b5f7ec4f-5197-436b-83f8-08db51c45581
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LnI/iuFJnNivd+osvyGS9laZxFZppCxDmBW5a83DhwPF42QsqYfs9Q+aCo09MhPqQbA2eg5RTdNimmG120kmgBw0DIfJXHtNpz/4jajyj14l05O80t4WU3MWDFebA1YIvow9SOw5i4CEjXgYxPR9DvRd6gAqFE9FhiLdmDs0NEzlclym+BayCO2vf3IEzqiIslwk7M2v9Chcc/kAlfmVqTkqkuMQTR0JKsflpUMppQN34HsYOsx03x0fl/nOr0G70PAB7I1yObByFfEtaTaGooEmnfN+FdFgjJ503F374rNJu40Z1eOIGuRtLkf+qshp445zoeelwLVReO1v7btd5JOqoxaHB6lPCdMReVlLWtJT6/4QfBhQU8HTmY5f7eACL/FMzIuQGMiXV91tjPLLlsCTxJ5QyKYj8c+cwgXhc8s3Wp8RJj/knCUNILGjftSS5uuEsT+7k28sSgzGpR1luGjO3+U7Vcbkye8MrvWOgg7Pp5SvVmjUd1ti5s03Ywjy4MUJ8qQGKzS6pfilxD/2Dnn3CR1ntxmBoiM8pKEQJmMU0Qf9Umvz6fiFaQ/IN3zRYtLT2M3/ORwGESBSlPejEznUSeuW5+mGGqSdrqcuWg9uC8yqwidXVaR3m8A2lypn
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(366004)(136003)(346002)(396003)(39860400002)(451199021)(5660300002)(54906003)(110136005)(52536014)(8936002)(8676002)(7696005)(41300700001)(71200400001)(316002)(26005)(53546011)(478600001)(64756008)(66556008)(76116006)(9686003)(66946007)(6506007)(4326008)(66446008)(66476007)(2906002)(83380400001)(186003)(122000001)(55016003)(86362001)(38070700005)(33656002)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?231XOikuVC1l50uCFq9C8nmVXBNA2QYXmenDDupZ2eL4ya8s4m+Ta7N/K5Ux?=
 =?us-ascii?Q?vJrLQ4AgRf6DiLGjyRFz5Eq/hJGems07rGIBEUkoT0inPgmgtuKCp/A+dqdl?=
 =?us-ascii?Q?vN+r7a8z7T9cek5oFBmAuoSlzRpIMF/H1MFZSrjKEEql+mBTaOjNRoAQZzBI?=
 =?us-ascii?Q?IiaIpeJ7qcvtpwIfgwvg7rdYcbFEIs+IC0ebPPctzGtQmvU6D7hrD48tr24B?=
 =?us-ascii?Q?AWAcU4q4cjdm+65wvUtqzq2nDEmiXoC12LlXLu8ZVdDHAcZx+LzKrH9tawpT?=
 =?us-ascii?Q?pWzj8VMaAYgbFtlMeSFLR3ZmmFzqE116u6k3QU+plwqlMmkWb3+ui11IVQse?=
 =?us-ascii?Q?bdPFTuMweTdk416Kna4YDj9oS7WZLTeQs1mtrdhgnmuI/xyc/fGz5w+T3N4y?=
 =?us-ascii?Q?pcKzL2ou6I+L29LDv0Oy//sih8rdKSkl5/qJ+5AatxjBlteLlfqAT1WcX361?=
 =?us-ascii?Q?Gmzmf1ykDDobql5QUt8mkVU+nCAX6GdUQX2ze40EcdkH1T0SNhKnh+YL8GrL?=
 =?us-ascii?Q?mpaFi21SS0SsWBWhVOFVN1OoyADC7MO10XOOrT4s7cyLBvFUXt0z6CXS+Jsx?=
 =?us-ascii?Q?9xfzlKnek+uZcEY7AaMOGPorbJjlCkVfFuV2FKDxZdmBCWzj4wQAhtRAf8mY?=
 =?us-ascii?Q?CGyl5nhxowQjVv9o/lfnRDrC1+l4uFwbFsBAAyMJQU6SK+jFliLKs2f+YYmz?=
 =?us-ascii?Q?JLfQsJJjKnPHKCDJ69l5CLDndtEqF3Lcp6HPc3R5HIkNmK6MWIcVZLNL9PO5?=
 =?us-ascii?Q?LR3Dj0LS+wiLY2O5Wdsp9QyCeKIuhEJ+6R0lg76vPvJHlOdrj2ZclsBLpRJ+?=
 =?us-ascii?Q?HCBePwmIyo/NBbgWDmTCC2Cut0g4unEGRHRmh0EWAD51loOK2GtUVPCSQYz5?=
 =?us-ascii?Q?akSEyWCxJPT9GF5lz1SOAA8CUxmiTIGQSZ2mrpTKK0FU4RN9kqlODrwj2gWH?=
 =?us-ascii?Q?biyO45hUeslpYpT0LwO2UoYHMc1xs4Iact4kivbzKlguu1hxhQO9rC+tjqeb?=
 =?us-ascii?Q?J6y3tRzJmCKPDx6/JC27FQtTbQnblVyFaHpfe6tYgxMEZc6iWzskqZVnROjU?=
 =?us-ascii?Q?TCdik04pdyh91dsv7afkx51bdD809eFsyvK7nAr3RNIl8utADtPWnGIkAD1r?=
 =?us-ascii?Q?xraJ1WSBn9xYZiJ1aAxrO4kJZ0/F+2To8/D9AkubN9klOFKxnl+Zo5ACnJOI?=
 =?us-ascii?Q?3a0P2e3u4wRUYb2ifzYJeP9bg+6nma5bq8DfORN34zUBDBiwIVuNVEnn+J/u?=
 =?us-ascii?Q?Hn5Q6r8ptb/5KURIFfxi3rbsjYlVFApyYB5dDae/70QJloZ1i5T3gUwczDPL?=
 =?us-ascii?Q?618wswBH4ZzMa0+Icwweno4fs3EaWWS5e+ybbXtPO7AfYZ9jPCd6jfJYAHfP?=
 =?us-ascii?Q?XO8zTyLXVMXOc+3JS4JuSphdzhxBWv+ouOkBh9OlJdxXZ5Jpj1+XmkfC55+R?=
 =?us-ascii?Q?q9lp8eeW4Nmazqo0tkxjVncjaOOj/uOzUSAfZQ/IDzfHOTzaNBdNdvEHKgG4?=
 =?us-ascii?Q?bew3k7i/z0iksuk3Q1BVp7Sh/8PmI6wLn0yPRg+LId1u10sOWti1wauuWafL?=
 =?us-ascii?Q?RAI0mh1aHbkfdGIH5Uk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5f7ec4f-5197-436b-83f8-08db51c45581
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2023 02:06:29.2560 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GBg6tcgdbg54vFpXuqXTJpOkotS4JVpvS3y+WZk2o6CvbdjuE4J8uwrUpL1iAjMfB/O6zeLi9eajEvtDk3KlQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8152
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Mohan Marimuthu,
 Yogesh" <Yogesh.Mohanmarimuthu@amd.com>, "Limonciello,
 Mario" <Mario.Limonciello@amd.com>, "Du, Xiaojian" <Xiaojian.Du@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

This patch is

Reviewed-by: Tim Huang <Tim.Huang@amd.com>

Best Regards,
Tim Huang



-----Original Message-----
From: Zhang, Yifan <Yifan1.Zhang@amd.com>
Sent: Wednesday, May 10, 2023 4:38 PM
To: amd-gfx@lists.freedesktop.org
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Huang, Tim <Tim.Huang@a=
md.com>; Du, Xiaojian <Xiaojian.Du@amd.com>; Limonciello, Mario <Mario.Limo=
nciello@amd.com>; Mohan Marimuthu, Yogesh <Yogesh.Mohanmarimuthu@amd.com>; =
Zhang, Yifan <Yifan1.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: change gfx 11.0.4 external_id range

gfx 11.0.4 range starts from 0x80.

Fixes: 311d52367d0a ("drm/amdgpu: add soc21 common ip block support for GC =
11.0.4")

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgp=
u/soc21.c
index 0f82b8e83acb..6bff936a6e55 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -711,7 +711,7 @@ static int soc21_common_early_init(void *handle)
                        AMD_PG_SUPPORT_VCN_DPG |
                        AMD_PG_SUPPORT_GFX_PG |
                        AMD_PG_SUPPORT_JPEG;
-               adev->external_rev_id =3D adev->rev_id + 0x1;
+               adev->external_rev_id =3D adev->rev_id + 0x80;
                break;

        default:
--
2.37.3

