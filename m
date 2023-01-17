Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66EE2C46467
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Jan 2023 00:56:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B860710E0E6;
	Tue, 17 Jan 2023 00:56:48 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2083.outbound.protection.outlook.com [40.107.237.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE37510E0E6
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Jan 2023 00:56:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VIqubcbRWlE++EzmmSpE8ceFDbinc9E4ux5ZYqLxh/BY/AcspzxQSwOg3TISf5XvmoirFLoxagDy5ddwDCbzFY1R9XyOvkVpSx7OSo6C7Yl62KwRR0abuc7O3FgbhfYrG0w7pRLp+lCV8Ou89zMrG9Of2lToV9oOuvyyFfEzLhdgRIYADXLRIu9FYZ3BulIUWpnPFDIHOS9BNgDIO4pY5ybL0wwB33QBFYewuc7bzXoo5dL30axmymr0WWC05ORyuSbAwSpRXSCs0+zwMtLI+iLxGDHvF1JT5zRdOU+DZKbhfb3itXAC64wknkkpLDPl3aMkEZG7Ms04/Fxl0+H8bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0t510HOSVmHCj9MuXAFX098c9/OcvE+/l7pc5rOtm34=;
 b=YtwYdhZjEMjcsu6GtRZaowyos4NNh/ot0wTi3O9mxH6xLZ04iS+wRH2Vog8+g1Rxm2ic1M13bBBUFOU2Kb95CmwG3i/CmCmuv+PyAyRtEAYJ5m2ZrtxQtuLomSlXNnG3A9kbMxj5O2sRPa6Tj4Pfx0uS6khZkBZvH+pQ8QptpXn8knhIagWxJSDEcjkxf8XaDK/O3jMQwKI63280qb5n5TCTx20slPKD2Bq2jMMy16hiOdNXQsmWsPcKBrnltv5gJOGdDJlXzq78LfuzR6Ier2LCce1gMuVa5IkQ8B2El4fD0txFgcdS5b/WhhbwkYA4koRqw7kmvFG9swEjxX9+vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0t510HOSVmHCj9MuXAFX098c9/OcvE+/l7pc5rOtm34=;
 b=u/xQ5p8F5TrIit1Iv1pPfthlGJhvFjwL4Ry8Kgrgx0lnsyfxje38t9NQcngDxRuheJu3WlKvZhQFlaX938vlGB+2F6lK26eHem54Z3EAEPFMK7c6D1075bqhw2Uh19jrW4RfP7DUgeqVDUZz3HUAb6zmKnVI/myU2fj6T94y2Y0=
Received: from BL1PR12MB5237.namprd12.prod.outlook.com (2603:10b6:208:30b::18)
 by IA0PR12MB7554.namprd12.prod.outlook.com (2603:10b6:208:43e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.22; Tue, 17 Jan
 2023 00:56:41 +0000
Received: from BL1PR12MB5237.namprd12.prod.outlook.com
 ([fe80::956e:e4cf:6a8d:3f13]) by BL1PR12MB5237.namprd12.prod.outlook.com
 ([fe80::956e:e4cf:6a8d:3f13%7]) with mapi id 15.20.5986.023; Tue, 17 Jan 2023
 00:56:41 +0000
From: "Liu, Aaron" <Aaron.Liu@amd.com>
To: "Yu, Lang" <Lang.Yu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: correct MEC number for gfx11 APUs
Thread-Topic: [PATCH 2/2] drm/amdgpu: correct MEC number for gfx11 APUs
Thread-Index: AQHZKYN/fza1yFjQXkC2DcWBofkHd66hyfNQ
Date: Tue, 17 Jan 2023 00:56:41 +0000
Message-ID: <BL1PR12MB5237E3B9B97AC50BF066C212F0C69@BL1PR12MB5237.namprd12.prod.outlook.com>
References: <20230116082025.2188409-1-Lang.Yu@amd.com>
 <20230116082025.2188409-2-Lang.Yu@amd.com>
In-Reply-To: <20230116082025.2188409-2-Lang.Yu@amd.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=d66372c4-597b-4324-96fd-880a8fde130a;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-01-17T00:56:10Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5237:EE_|IA0PR12MB7554:EE_
x-ms-office365-filtering-correlation-id: 097140db-53cc-4da2-3059-08daf825b242
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HyMCXGIvvGTPAAKzM0YB7YzsPVbddqo1JoK4PD6952gF2Wjm5yG8en2xqbrE1hREE7gHyoafKlW3Tb1Ngsu65YChQ0NF9oBmpn7NVrXrt4FqQTxYgfwG1F3mXxk3rqlaAoB8/ASToMfOVkZERV/TvgrbWJASRDWbHPxlHapIiZcJwq1hSotELzMf3jltMslW74g3BVFkFG7U32iYXcrp2+OQ1V7lpHCq3353rmbCt06pJxTbTPQzQhagl1vYjjerTI7dQfKj/kuLmyTBYTf0vY8DJcloOmiz7biMVEvkZTCbruBAHkfHNSTb8DXq127Pq0tx1MVnHiesczztrWdWwJ7cCTxtPaDxKOsPgKnXbnxqSlswfhpNWemz2O83XMLP4iL1g1/nghp5f4wlTgu6GyOv0lwZF/HxkUgBVcDun+zcl8vVpj7R5vsjbdmVwrq4I4VqlijS5K55dw184OD/avCNz9zSa0A+aFqhQzuU59KxEQPjAE9sIswTHj7N2UEtwWMvZ9cDyucqrsPXeWnq3/FlaO9Kqr5Z5NkbRlQZkhHIYqp3yOMjp9JvPeOZ+yVdJ+sQtTFs+zJvUt1oxlCRNQosAQc9gmc8J8xKPIQXcEw4Qj1tr+EBVZ0slPwv0h2k3LYqhndGabZuDbfgk6x2H0h0i04WrKg+pxHePnomgOISX4dOD+Ejo6CKcrB965owVgXd+gxNttGuxgNk2E26fQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5237.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(346002)(136003)(39860400002)(396003)(376002)(451199015)(38100700002)(33656002)(38070700005)(55016003)(86362001)(186003)(7696005)(66556008)(4326008)(8676002)(9686003)(64756008)(66476007)(66446008)(26005)(478600001)(110136005)(76116006)(66946007)(71200400001)(54906003)(316002)(53546011)(122000001)(6506007)(52536014)(41300700001)(8936002)(83380400001)(2906002)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LPe7nrElONAVk9v4BBGvEQ+JUL5KlH2mf9yeQJzUPk5mFZ+tuj5oxvd5ccuq?=
 =?us-ascii?Q?TOCnczhv9liB3d4y/Gjr7GS/5roW79q2cV/2QNuE+ylQ/5mpOBo2Pf5BX/SC?=
 =?us-ascii?Q?eAZ2Ql29OHm+l5d1bVjX3g7c2RtfkfJkOfgveeg7FEyLw6YZwvIqVEVifBVn?=
 =?us-ascii?Q?YWAA0BjO+20tmxO4JF247n8tz87KuDliJjWsBznsliabz5HQ63OiyyIBbl/E?=
 =?us-ascii?Q?/1fvviReYjVzwrsk/ejYSP8HgMEqaN0KwqQA28Ou6saoqZCF8FVT9lkN+t8u?=
 =?us-ascii?Q?e9R/TSuGHYuigkPv/G4uS7MxdWYEWJrFGZmDGDCY6lcCz+1ubYnhiCPVXy2i?=
 =?us-ascii?Q?2G6gUWGBQrQONFqSsVKlbhwD3yzKxjwrxdD3GZkoM9Tyu7bhor97Qi6KQN9A?=
 =?us-ascii?Q?+vbEBjwwTC/oChOhOme0Ean1obf4t3iG90rXq7AGndHkG2trj82ieQ6FYIHS?=
 =?us-ascii?Q?sSAacHm8ADN9dCYz3Ulto8IgMzGpxfCgYzsaDBOiuc3LSHcHEZw5ovy59Et5?=
 =?us-ascii?Q?JjhLXn7F13Z6c4uQIoBYUsvUGr6rZhrRscUuIISadis3BA0knW5FCIA5WZCr?=
 =?us-ascii?Q?lWsRZLI436qyFxaZhA9O5XVUygajFrvlWf8e+9vboNdTA2eLJEQNsrG7n6QZ?=
 =?us-ascii?Q?syYZAH2a3f257eAhQRqRmJnhF8L5hZX43PrzvgnMcX5hNrneiXwHLjsAhoQm?=
 =?us-ascii?Q?2Cy7oRWcqA7PzFHWkfxo5xcg0B0LMsZql1zpzU2u7i9ExA1LxHa6KOgFQcoE?=
 =?us-ascii?Q?tlI/T39tF1rNVJTAnlJWeMV4yfT257oMZBINQ8KYA+yYyQfHNnTPxbg/iFMh?=
 =?us-ascii?Q?Bsz4vc7l30gIgiLaYaSBkeUxpxDC4kG/jE0HURBUd9/KuDw47gPeEHVtbgGk?=
 =?us-ascii?Q?bIP3MYQGZjybVSGVdx2FXSaqGzxXc+fuEraZnXK9OCDylER7SgTbqQKrBzhN?=
 =?us-ascii?Q?0OId2qFvCXJVGpBzFWlmc8xlZXRR4dzCBBQjz8KhOHEd/piCJKzeYda2tb0q?=
 =?us-ascii?Q?qwP7FzbulWe/vOGTMMSjwCDwV42d5iPKQZitS0+cM4Kr3uTfWtxI5wp6CaEf?=
 =?us-ascii?Q?8O6YQIpAOGt+3wcMCViU4FDYbMYI9aGp//gpOFkBdknLfGhfiL2B/6ZN7JyD?=
 =?us-ascii?Q?T4kb4TcvGkUiwp5ictn1X3YYDnzaVOPofMYm5uw/AKtwe9kKbWjJ8hkIw3E+?=
 =?us-ascii?Q?Sthwj+cuTqNJlK43a2f7+XgPIfCe1CcaTSE/cTxjSCtq8WhuLwMwPaoLkmMK?=
 =?us-ascii?Q?iCymPawkL/kpYf5yIFgrT98KdUN5tbbtYCd+dqME2hQnrQj9X1x+fkvEHEmD?=
 =?us-ascii?Q?BjxXtvkqlMyXTVtaYblLGDHEzLlXZYN6YzjfDE7ezwrYWnsod0CC1T4XJ0Bw?=
 =?us-ascii?Q?GC8VVqqM4K/ZITBYpdNv0uBVumRd4xfaGeqwl2CbJCHQBa3XSOqcwKrrRAqf?=
 =?us-ascii?Q?tORn9fb6kOL5jYVGbZYkuSlv4cd9NjKY+cd1+oSbZF1qv/b/KdJmNMwSWfhE?=
 =?us-ascii?Q?DMiGioNGZh/XlIqoImb1NQQsirgS8H2CfawZT4hGXg+KNSW0prulUhEBxO5T?=
 =?us-ascii?Q?n5mJGiVKjAvh+gFGAfU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5237.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 097140db-53cc-4da2-3059-08daf825b242
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 00:56:41.3882 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UdnhtYP5naCO9VAnhG52pS0p9mbOcjx4d4nTnMAZWoUq6ckaKsGGITo4E7hC18ly
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7554
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
Cc: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "Yu, Lang" <Lang.Yu@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Du,
 Xiaojian" <Xiaojian.Du@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

The series is
Reviewed-by: Aaron Liu <aaron.liu@amd.com>

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Lang Y=
u
> Sent: Monday, January 16, 2023 4:20 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Yifan <Yifan1.Zhang@amd.com>; Yu, Lang <Lang.Yu@amd.com>;
> Koenig, Christian <Christian.Koenig@amd.com>; Du, Xiaojian
> <Xiaojian.Du@amd.com>
> Subject: [PATCH 2/2] drm/amdgpu: correct MEC number for gfx11 APUs
>
> There is only one MEC on these APUs.
>
> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 985fe704203e..dd4e0f337f46 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -1251,10 +1251,8 @@ static int gfx_v11_0_sw_init(void *handle)
>
>       switch (adev->ip_versions[GC_HWIP][0]) {
>       case IP_VERSION(11, 0, 0):
> -     case IP_VERSION(11, 0, 1):
>       case IP_VERSION(11, 0, 2):
>       case IP_VERSION(11, 0, 3):
> -     case IP_VERSION(11, 0, 4):
>               adev->gfx.me.num_me =3D 1;
>               adev->gfx.me.num_pipe_per_me =3D 1;
>               adev->gfx.me.num_queue_per_pipe =3D 1;
> @@ -1262,6 +1260,15 @@ static int gfx_v11_0_sw_init(void *handle)
>               adev->gfx.mec.num_pipe_per_mec =3D 4;
>               adev->gfx.mec.num_queue_per_pipe =3D 4;
>               break;
> +     case IP_VERSION(11, 0, 1):
> +     case IP_VERSION(11, 0, 4):
> +             adev->gfx.me.num_me =3D 1;
> +             adev->gfx.me.num_pipe_per_me =3D 1;
> +             adev->gfx.me.num_queue_per_pipe =3D 1;
> +             adev->gfx.mec.num_mec =3D 1;
> +             adev->gfx.mec.num_pipe_per_mec =3D 4;
> +             adev->gfx.mec.num_queue_per_pipe =3D 4;
> +             break;
>       default:
>               adev->gfx.me.num_me =3D 1;
>               adev->gfx.me.num_pipe_per_me =3D 1;
> --
> 2.25.1

