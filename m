Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 956E9C7EE37
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jun 2023 19:59:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C30689DA5;
	Tue,  6 Jun 2023 19:59:19 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::611])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1027889DA5
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jun 2023 19:59:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HscUahLd0VvLpXLJufNi7/9rGmtEUBYn2hOzAQR6SfP31Snakj72F2F3hecQBQDCxoDuTh+LHo/sPGU6Y4HURqCYRd2KVg23dO8DsN190WSMObgeGgFxBXq2Y2+WQJPMdk9IP+OsfxQ1f6nkGjMOATTFf5LEfXHrgd8JEoZLLb4b6dOR81jIbdgqqrri4sowVOyrC8GYNqGSSnnAf+uzQOZb3Qnpeta7GUm2fL1Fqtcd+JlLxHDv86Ox1ESpIdCcIIbXAVzsPpZM7hT8DUzWoTOOzH9+7GLsKPLNKde32Kjc0PR25kSaU/L+G1svEH89IgQK4vTQKiQn+Oht5oKewg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5EgcObYTJshoL63jTKhZhK/SUGrQp9nNSfwSgnwMDVE=;
 b=K/C7+2/6t+eWI2ToaLpAA7EaNqRxKpSuktbOw0xGCXZ/RDDbHbctZA64J6RfMycvWxaGC36C1O2furicuCPxTyayMbItSek3BiXT5lSNFh7P7PAkiRALw1XeBb96bH5P3+u4hIohbLMyxZ9eG8muco1np2xLjQ1FAXTB5hSVFevsCWhtnl52QfZ4hXA7X1BFOnAIzbV7ewNXNaNp92202rPj8xpecnFn8B+aWfqHpuxnTUqA4IQpgHIKB7J+1iMTi9QFXKuKlsed2ZfmuQfyau2UvX6tk7O5Ifd9hYOrg7wrStPGwkrgX80MnH3XJ6cQ1RtR+79AKnRbnmk2QmfcsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5EgcObYTJshoL63jTKhZhK/SUGrQp9nNSfwSgnwMDVE=;
 b=IHxgWwBxACYlEQvYDBpfs/uAkA7PkAQcyvm6eal7EYHzNw0vFE8maRQZxwRwShT5/6zF+07Zy9jmp0gVRxA8lj2errxBWn05hq5X+E2KYYB8qkKr74Cp64iWq0fanNpJz22IsekSL9/2pcSQc23tSMxnGjSUAQjTxskJgGOcJ8k=
Received: from PH7PR12MB5902.namprd12.prod.outlook.com (2603:10b6:510:1d6::8)
 by BL1PR12MB5995.namprd12.prod.outlook.com (2603:10b6:208:39b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 19:59:13 +0000
Received: from PH7PR12MB5902.namprd12.prod.outlook.com
 ([fe80::b008:94f:6747:8ca4]) by PH7PR12MB5902.namprd12.prod.outlook.com
 ([fe80::b008:94f:6747:8ca4%4]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 19:59:13 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Yang, Philip" <Philip.Yang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Increase hmm range get pages timeout
Thread-Topic: [PATCH] drm/amdgpu: Increase hmm range get pages timeout
Thread-Index: AQHZmLE0hUdQheHxcUGNY7m4xyPm169+MSSw
Date: Tue, 6 Jun 2023 19:59:13 +0000
Message-ID: <PH7PR12MB5902D0D6E3C6A6BE1A1478128552A@PH7PR12MB5902.namprd12.prod.outlook.com>
References: <20230606195717.32605-1-Philip.Yang@amd.com>
In-Reply-To: <20230606195717.32605-1-Philip.Yang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=8026df69-999d-4450-a809-f716cd19914d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-06-06T19:58:29Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5902:EE_|BL1PR12MB5995:EE_
x-ms-office365-filtering-correlation-id: 97be550d-fd69-4bae-e432-08db66c8805e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6i8JCRnNCWcBGv1/i6WQ/X2vp7Oj9Xqji22cUvfQIlA6nNtgriXPJ9OyHqPvYnnQAyoM7wHS0z+lJrJ188I6dpbSi8Ys1PO1xX2xIfCjyhMK9XOXVYsl+mCZTvhJjl2q6HnL+pN+rNURnB89aydADxWxpJdpzqnRWWz6XA+qKqfl0baqt2jRPrIL7A1a0PbZ0iiGh3ZVGgAiNIuYMur8bZhvf48fVKsMvC4y2bOMZXUNgitRUs5in8VcsRCj0TRikRnDxNrzzfjYJ5V/Yh1yCpEIK0SZDEZs3Ag8azW3+dYhyqlvHRadlIF29+sIVryu//eDbHTucEGlVYgB0MgKtDfOqscopXWhy+clH+01e2kEqnUcf8B8oK8w+g468GiyGdUSkDkzpI0zgALBeci2eySny2rwApBkWDnc8osf9REdTNwC2j5n/UmJPeq89v0lpCLnNwK00IUTQWmyVg/1cSII9AhS36FVAdr/bQJoRHiv7keNVp33EbUXOenoLdiP+FCg8KDGRvdO0OeTbNSnlBnVB0MyKx52iVbvXDMGVkpdOJAC0JJErAFLXkaST+i83IUTIhFAZpUfhEHduf8OQY2eC8f5afM5aypEaef4iQa/vKR+Io+9BcYBsHj7+RpJ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5902.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(136003)(346002)(39860400002)(366004)(451199021)(38070700005)(2906002)(33656002)(86362001)(52536014)(5660300002)(55016003)(71200400001)(83380400001)(53546011)(9686003)(26005)(6506007)(478600001)(316002)(7696005)(54906003)(110136005)(186003)(64756008)(38100700002)(41300700001)(76116006)(66446008)(66946007)(4326008)(66476007)(122000001)(66556008)(8676002)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?i2y/tgXEZagzEXAfxmu9cRmStL8gbKIIIvXTQF6VeFfVN0V/fOQ+D5aIE31Z?=
 =?us-ascii?Q?NbOAhAaZNg2O2tWHvn4rq9jsazv2AHMakvpOPcaRZ5v3Vb9w0iZMbUsBv51B?=
 =?us-ascii?Q?BC+fX0yyrjjQJIGmtIyOIRCJLM3Hg8cnWTEz6R3K9QAjZxa5SD+ZIBi89u8A?=
 =?us-ascii?Q?uwScW0gJIadXOxm7e5sECVZaUPLYZ29q+OxAFzNXoRai6cXOWXCRglRP/Wmo?=
 =?us-ascii?Q?PKHTbz7UiAAnUD7QipPr8TiahP1jQNrcN3gSx2BtZ+YK9mOFErT+tEXu1XzB?=
 =?us-ascii?Q?MSFrqCjYoR/LlqnAxSEAH/1iDU5gzat6MMELQXpwigVZZC+rFWfQB+kVJB0/?=
 =?us-ascii?Q?g2eD3YT7OmXl48ELyNtCUNcL06nByArIU1Zujo94jhhIVhapH6knqTdGIVYF?=
 =?us-ascii?Q?5lriLkXknH5A9kAqtR3ntrP0P4xrIJvnb/Ibi6lGQ0nxEeNYl7Q3UVGe8ZsG?=
 =?us-ascii?Q?hh7z7rvpPYnUta7N6AW1XEJu/tfsdAqhcE+9ENF9wLwvSwqpDZc1lFJuV8ZO?=
 =?us-ascii?Q?nfBdTRrbNYTBu7sXIM9wOsPKRFM9wRjxBPD5Tb52pRVmWgjXYne0D0KFmThy?=
 =?us-ascii?Q?FaxSEdaGhYXNR/Wx63a7jhkJIGd1Kzjr7btvoVXOZBxf/B9J7uxKkJQRbA5m?=
 =?us-ascii?Q?5pcGj5WeFIe/z8+04MHBi6NRaFSgWtP69WHJTbqacdub87xi1/S7G2WgXexa?=
 =?us-ascii?Q?6Mqq4x//BtR8mPajjFicCMijwrAMddM/sVJhoQzKFy0lUNqNN8My5y169Qef?=
 =?us-ascii?Q?Ukc3d7T2dZKORjM5y/29pi+bsLvb3YyajogOm5cbAjKJ+TkJ71VyL9tCKN9L?=
 =?us-ascii?Q?P27FhfaEp0v3M06/9o7p0siExudwmOa/dlxBlcDYi/XnCUO8tcmDzDTkjFYK?=
 =?us-ascii?Q?9iJfmMFY9M58Izvu6gxOiagSF2pGotgFn9Lj3HgvlUzaI79t4I3TjJ4ShpMW?=
 =?us-ascii?Q?QS5qfm2oAN9msqjR/zIBLrGrdJBFwwPWp36CmvBdGiXBrcY8b8fcdmO48YOp?=
 =?us-ascii?Q?jJqYowNS21dpsnAhCdlxLtfZ+Y33rNHCnhTNHct/6hLvdJ6BHEywAMwMM7OL?=
 =?us-ascii?Q?zxNJcNCkGQcOeKkcI4NrLRFvvWUMba2T0La3Wr3iHh+I/R8f97tz0Nb58lNq?=
 =?us-ascii?Q?OCaEPPSUSjmUbfiinGFYwp/nQcPgDQwGXejs2ZrAq8Cst/0/ZaVa+uw/fKI2?=
 =?us-ascii?Q?yj3knNIhHZ8TqmeqTcAYDrF8tVWZSfxu6vqxQWjGC+qctavkmfCtEdklheGt?=
 =?us-ascii?Q?xoWy2+utBaFWyAv3ed9WpG1jbWz0lI5xKm6Blux2oUdz8OZZrvS8tQjX0Sad?=
 =?us-ascii?Q?p6HvqsOlRV0XWSieVfHkgMxX0woDynsUKF0OYwQGYaQHqjiERrcjselhRian?=
 =?us-ascii?Q?amB1lk9rQXeE0wPd3h+xgyYxPybtLJkPqwqUAAhWu19v7vJCXS5kJ3SeAN8A?=
 =?us-ascii?Q?BB5XjRMSbZ7ePU2KIPf5JnRjfXO6fSqD4p22bDl+bPtSd/cu7SQ5J4INKo5I?=
 =?us-ascii?Q?Vi38LzgRSjXK2wwZoyNrrq4bR3Wr4AGtR3c/pDUN7Dp6Nz8xXYZ0FhqViu/f?=
 =?us-ascii?Q?Bccy9Vt56rMs4QGHsgY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5902.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97be550d-fd69-4bae-e432-08db66c8805e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2023 19:59:13.5910 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X/MqIQGv3LxUXyThAA2iKcmRbLTUjQDvqCQJSKsWi0kO05URVWfb+V3Ognk4fbHh5SXdEEWlWaG3InKx3fU9Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5995
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
Cc: "Yang, Philip" <Philip.Yang@amd.com>, "Kuehling,
 Felix" <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Philip
> Yang
> Sent: Tuesday, June 6, 2023 3:57 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Yang, Philip <Philip.Yang@amd.com>; Kuehling, Felix
> <Felix.Kuehling@amd.com>
> Subject: [PATCH] drm/amdgpu: Increase hmm range get pages timeout
>
> If hmm_range_fault returns -EBUSY, we should call hmm_range_fault again
> to validate the remaining pages. On one system with NUMA auto balancing
> enabled, hmm_range_fault takes 6 seconds for 1GB range because CPU
> migrate the range one page at a time. To be safe, increase timeout value
> to 1 second for 128MB range.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> index 2dadcfe43d03..f7efa582f3ed 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
> @@ -190,8 +190,8 @@ int amdgpu_hmm_range_get_pages(struct
> mmu_interval_notifier *notifier,
>               pr_debug("hmm range: start =3D 0x%lx, end =3D 0x%lx",
>                       hmm_range->start, hmm_range->end);
>
> -             /* Assuming 512MB takes maxmium 1 second to fault page
> address */
> -             timeout =3D max((hmm_range->end - hmm_range->start) >> 29,
> 1UL);
> +             /* Assuming 128MB takes maxmium 1 second to fault page
> address */

Since we're changing the line anyways, can we fix maxmium->maximum ?

 Kent

> +             timeout =3D max((hmm_range->end - hmm_range->start) >> 27,
> 1UL);
>               timeout *=3D HMM_RANGE_DEFAULT_TIMEOUT;
>               timeout =3D jiffies + msecs_to_jiffies(timeout);
>
> --
> 2.35.1

