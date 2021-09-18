Return-Path: <SRS0=x7R6=OI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17F73C433F5
	for <amd-gfx@archiver.kernel.org>; Sat, 18 Sep 2021 09:32:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C733661212
	for <amd-gfx@archiver.kernel.org>; Sat, 18 Sep 2021 09:32:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C733661212
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 483CA6E064;
	Sat, 18 Sep 2021 09:32:27 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB5D96E064
 for <amd-gfx@lists.freedesktop.org>; Sat, 18 Sep 2021 09:32:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D5iuRw95v7f+af85Ui7A3X34zKejrfU0ZvUjpAKoV3n1ujqm0MWHcNeTSHjEYNXqpjNwTCeDoSSKpSVTYqmVbfP/Dz0a5DsmjFEuAzehjsywL+ChAoKIFKSaLu0ymkI0Nk6S9hmrcYH538hpQc03S7pGcwROTeTYoTqvbQ46AygILoLJfq01HilMKcbEWDHqEyWyqh38HdXS1qf/ygI1WW6Sfn54343pH/Qlv8X50MkrUxIOO4ObrV8h7E+e8dWxwwnmZbMykh6FphrPVGLV4Di0yeDe3ul07cxbqUge5F9URBq2qTmDWRTsyjVXSgRw2ImBMVvph6RXP7doX2/U2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=AkdUE7kFIoD4noYtae1cJ9UFTt10/dobbKRK/r1Wjok=;
 b=bELGkPew5GNRcu1bPotKKN2BCOJG8JZFAhHemaAGmdBrBqu54AswkPoI9LK8bdukV/P5uL2inDuNxf4xTFkPeEE8Qr0iX/k3fLHhIpabytVFdTrbZuR6TevbJSdvM/9So+yey7lkdAUTYqjf7MvfPX8dMjTE21tYJBaxP7nTBS8TimGNsppucHDxaWQklOSkIoNzREPSQY4h97+WzmhaIbL9HQtJKhCyOxfjV19A58lhAqxs869iSC7DrfqjhwZdKL3UzGkMrm+M8TaUePuJKM6UCRqATVsyBmLorPVykvFIJzZ5BT/8l6lE7A35jpMVOzLY7lsI8DFmPtMqBI0waQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AkdUE7kFIoD4noYtae1cJ9UFTt10/dobbKRK/r1Wjok=;
 b=WO0sXebjbjQyDZADj+KTl55sZWmudD7998BgpZfaii6XMSqQZGI2qDLqYFV0/GksDIDEYa4G4csz4NmsJaXwj/dJhq0SiUy+IftvFtU3K69V0spw/Bm/vBkf9O6i7wkhQ1Xpz3UQnf6yLYnKXUjhSRnZimf7GtVZ+totEBf267Y=
Received: from DM6PR12MB4650.namprd12.prod.outlook.com (2603:10b6:5:1fd::27)
 by DM6PR12MB3721.namprd12.prod.outlook.com (2603:10b6:5:1c2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Sat, 18 Sep
 2021 09:32:24 +0000
Received: from DM6PR12MB4650.namprd12.prod.outlook.com
 ([fe80::b0d9:236b:a2a0:49d8]) by DM6PR12MB4650.namprd12.prod.outlook.com
 ([fe80::b0d9:236b:a2a0:49d8%7]) with mapi id 15.20.4523.018; Sat, 18 Sep 2021
 09:32:23 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Clements, John" <John.Clements@amd.com>, 
 "Yang, Stanley" <Stanley.Yang@amd.com>
Subject: Re: [PATCH 2/3] drm/amdgpu: set poison mode for RAS
Thread-Topic: [PATCH 2/3] drm/amdgpu: set poison mode for RAS
Thread-Index: AQHXrGRVNNhDwDoy8EmOfvSadxQGOaupfhUAgAAHSwQ=
Date: Sat, 18 Sep 2021 09:32:23 +0000
Message-ID: <DM6PR12MB46502029AC84D32CCE5B7CBFB0DE9@DM6PR12MB4650.namprd12.prod.outlook.com>
References: <20210918080751.23615-1-tao.zhou1@amd.com>
 <20210918080751.23615-2-tao.zhou1@amd.com>
 <BN9PR12MB5257DBA732DD7BED5FB54C1AFCDE9@BN9PR12MB5257.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB5257DBA732DD7BED5FB54C1AFCDE9@BN9PR12MB5257.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-09-18T09:32:34.921Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c1f743c7-6164-4789-0144-08d97a87389b
x-ms-traffictypediagnostic: DM6PR12MB3721:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB37214DADDCF06C997BF2E22CB0DE9@DM6PR12MB3721.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zjJ7/9OZ180WZh9zN2x0G7A6InJsMR6UiMTlj3cWluwRWVAQxn5hiG/dw2jkPwpIX9erLBFOPZFh6h7f6RcxZu1EyJmgr9D8bq9GlIylNjsOFbU5nJBDMKGHtTK2Gj5hyOCC37So6enqRVvECFxbWCYQdfLw2szne1VaH5DanxbZlCKvMQ+hoJi8eZO6GRAihfCrojnlI8RvXuF3Coqfex5bX3xKaBQSbRDeK0MAt4R31LrH8+xMTB1dmCd/QqFDXbG7w7oaJdtS6UGtS5/myW/f0H+9FU4oNW9Wze7vzKNbK+YzulsoNEsHe3tz5VKFjFqtzFliQjMR1b5ZP5HQ1sluWentsWd3YDlQPMb3aAZsQAUZjuQYMrqO3bn3T8PZaxaCLXr7JTJqYIvrOORPgi6Nbv/EP7ie0hbkKIr5zUPu3PN/eFNzSxXW2+D7tOk4iNvDlhGS1mIEP86D+Y/aR8Wn6HCR8LVMW0+iiIqHMHIumgsHV2YrQMOROwvPHR9pUIED4mUZ1kQ72ii2tORSd+LrPrDmm8YnlM6MPEZfS1zTAJrfNPA9vEui6msJ3JobvMzwrlLV+w5shz5qTYJLSovnDYsL4wYp3lw1EswefWPZd4UyJIpx3Ub9v3U41ON5x7dIuAFjRZurACJe8ocjv/gm23sztze8KQwks7cxVUNiaWNdXfn4gePl1zX+J3TtmvWwm2+AfEegwINI3hRPaA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4650.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(66446008)(83380400001)(64756008)(71200400001)(66946007)(122000001)(5660300002)(6506007)(66556008)(53546011)(66476007)(508600001)(91956017)(86362001)(6636002)(8936002)(186003)(2906002)(52536014)(19627405001)(38100700002)(55016002)(110136005)(38070700005)(33656002)(7696005)(316002)(76116006)(9686003)(8676002)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?b6WEjd6PWNEvYgTYFxxr7Jtgsm2gc8G4vrp8wmUpQcxvbRQyxMkQSvM/idrl?=
 =?us-ascii?Q?bWh90nXfClbE4q0TlSMJM2+AN07FlwOMUQZ6mxD10yeNP6LMXNs5gR3rpf3R?=
 =?us-ascii?Q?9kd2aJtNifCnZl5uSggtKkfeV0j/69g16Zp/SIQ8nXEY/VeVt0BufiJVOcKj?=
 =?us-ascii?Q?B7asrNWpvFkCu442XArY1ZnWRNlchJLRCPxZkU9GbFxY16op8J0qxUhbeibr?=
 =?us-ascii?Q?UG/njUx7ZUCSA1msNGYTXwoRVZ951J2Wh8+3jWsmliVk4v64VoWLXowR1yR1?=
 =?us-ascii?Q?Uw9Xft6DfhUBurJ44dkhEM+lqNL1H20wuncIpJVxzfH2tiqZ9IVYQfKJ2yWW?=
 =?us-ascii?Q?eT/kMkaViBjjGKiNDj7tbQus+yAlKCj28IyjCUCZ4T/XYugxnSkntvAX6DQE?=
 =?us-ascii?Q?CTt5fg3CVDIfJYIze8LbPRy5mvAKKtkHeXmGcnH/MdyfB0TuOl5zUnyXW2yW?=
 =?us-ascii?Q?XukbdBjNt7BrvBg3QL7n+hIz4wArydWKv7wYHgmZd8K2PeUOSCxyNNzvov0B?=
 =?us-ascii?Q?vCaT/0M1dyiRRChrcL8gYmAhN9EcGpYSTEN8JZKX5VsZLK+2KKpzl+fhWU6m?=
 =?us-ascii?Q?lSQafxr1sQqRSj1mptFhnkYeQmhfyWWsDigTdgfHCosRtu4rgeHbknuQbEs7?=
 =?us-ascii?Q?I2lccfMRnDbVCiVa4bURIcM05sDrtmVw53P0DSCYYFIVfkopgOxOVz3Benee?=
 =?us-ascii?Q?eOMg2B3RatOjgM5obEjKtG7Mu4sx2k9wh0nVOZl1VFCNgKEqdRQceG0EpJ/b?=
 =?us-ascii?Q?EyUHUadd6pm9hWVa2zfwdzLOWe0ew13FbDj2OkDJwlQzAEMhesIhh5AtR5uu?=
 =?us-ascii?Q?B8Q6YCNwuaCJoXm0RyLSdaE0hLvzPor8XyIlwGitx03W5Hv8SCnSVy9BRgPa?=
 =?us-ascii?Q?KZ9Hzq8URliiepxnN1C2FdGM+nBQrbojreGtTI0RXa9ZEWZUA0DaMWi2darR?=
 =?us-ascii?Q?ZpinCTBaGmYJSVTbpOB84dI2ztqo37+++dD/w/POvzQ9vhj8zlfssNK/T09B?=
 =?us-ascii?Q?uHt/vByyWMno9vRtAebwmDPKGDyUcNb1OB/rht8fA3kkxWLpUOz5oflYvL5P?=
 =?us-ascii?Q?mxWM37/7w013ZRrMo4Ob+/7wT6BNU5IV94uE+OjRq0Zxi/h3c0AQ2CSvH4gN?=
 =?us-ascii?Q?qKhI7ow2gF5iYrWuedPn/7/O7OD2ZZhX1lA17hrGn5uPzYBrJXNbrGgFjgx8?=
 =?us-ascii?Q?5M6rrAymVaAtAsxfRU3Hmxe51TxEDdQ9+LVg2ZrkxSvF+3Jr83qUl5wwmpha?=
 =?us-ascii?Q?aYBcRF/HG6oLXmc0SNUYddiqJ4MkdknZzJs9xUl9AlhXbSKpq9COTl9e2r3B?=
 =?us-ascii?Q?QsvXepRR/SU28uJP4lxxS6jL?=
Content-Type: multipart/alternative;
 boundary="_000_DM6PR12MB46502029AC84D32CCE5B7CBFB0DE9DM6PR12MB4650namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4650.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1f743c7-6164-4789-0144-08d97a87389b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2021 09:32:23.7252 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xu5BI6kqNFsqoqo+wQOzUPK8jFxjwkkWvfIR9cvT4f7l0qJoAc4TcrITh6N5vtBd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3721
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_DM6PR12MB46502029AC84D32CCE5B7CBFB0DE9DM6PR12MB4650namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Poison mode is a global setting currently, will we set it per IP block in t=
he future?
For example, set poison mode for GFX but fatal error mode for SDMA?

dgpu_mode is disabled when connected_to_cpu is 1, is irrelevant to IP block=
.

Regards,
Tao
________________________________
From: Zhang, Hawking <Hawking.Zhang@amd.com>
Sent: Saturday, September 18, 2021 4:59 PM
To: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org <amd-gfx@=
lists.freedesktop.org>; Clements, John <John.Clements@amd.com>; Yang, Stanl=
ey <Stanley.Yang@amd.com>
Subject: RE: [PATCH 2/3] drm/amdgpu: set poison mode for RAS

[AMD Official Use Only]

+       if (amdgpu_ras_is_poison_enabled(adev))
                 ras_cmd->ras_in_message.init_flags.poison_mode_en =3D 1;
-       else
+       if (!adev->gmc.xgmi.connected_to_cpu)
                 ras_cmd->ras_in_message.init_flags.dgpu_mode =3D 1;

I'd expect these flags are set in enable_feature command per IP block if ne=
eded. Instead of global setting at firmware/TA initialization phase, though=
ts?

Regards,
Hawking

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Saturday, September 18, 2021 16:08
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; =
Clements, John <John.Clements@amd.com>; Yang, Stanley <Stanley.Yang@amd.com=
>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: set poison mode for RAS

Add RAS poison mode flag and tell PSP RAS TA about the info.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c |  4 ++--  drivers/gpu/drm/amd/amd=
gpu/amdgpu_ras.c | 28 +++++++++++++++++++++++++  drivers/gpu/drm/amd/amdgpu=
/amdgpu_ras.h |  5 +++++
 3 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c
index 7d09b28889af..140b94da2f5a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1442,9 +1442,9 @@ static int psp_ras_initialize(struct psp_context *psp=
)
         ras_cmd =3D (struct ta_ras_shared_memory *)psp->ras_context.contex=
t.mem_context.shared_buf;
         memset(ras_cmd, 0, sizeof(struct ta_ras_shared_memory));

-       if (psp->adev->gmc.xgmi.connected_to_cpu)
+       if (amdgpu_ras_is_poison_enabled(adev))
                 ras_cmd->ras_in_message.init_flags.poison_mode_en =3D 1;
-       else
+       if (!adev->gmc.xgmi.connected_to_cpu)
                 ras_cmd->ras_in_message.init_flags.dgpu_mode =3D 1;

         ret =3D psp_ras_load(psp);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index b5332db4d287..7b7e54fdd785 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2180,6 +2180,7 @@ int amdgpu_ras_init(struct amdgpu_device *adev)  {
         struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
         int r;
+       bool df_poison, umc_poison;

         if (con)
                 return 0;
@@ -2249,6 +2250,23 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
                         goto release_con;
         }

+       /* Init poison mode, the default value is false */
+       if (adev->df.funcs &&
+           adev->df.funcs->query_ras_poison_mode &&
+           adev->umc.ras_funcs &&
+           adev->umc.ras_funcs->query_ras_poison_mode) {
+               df_poison =3D
+                       adev->df.funcs->query_ras_poison_mode(adev);
+               umc_poison =3D
+                       adev->umc.ras_funcs->query_ras_poison_mode(adev);
+               /* Only poison is set in both DF and UMC, we can enable it =
*/
+               if (df_poison && umc_poison)
+                       con->poison_mode_en =3D true;
+               else if (df_poison !=3D umc_poison)
+                       dev_warn(adev->dev, "Poison setting is inconsistent=
 in DF/UMC(%d:%d)!\n",
+                                       df_poison, umc_poison);
+       }
+
         if (amdgpu_ras_fs_init(adev)) {
                 r =3D -EINVAL;
                 goto release_con;
@@ -2292,6 +2310,16 @@ static int amdgpu_persistent_edc_harvesting(struct a=
mdgpu_device *adev,
         return 0;
 }

+bool amdgpu_ras_is_poison_enabled(struct amdgpu_device *adev) {
+       struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
+
+       if (!con)
+               return false;
+
+       return con->poison_mode_en;
+}
+
 /* helper function to handle common stuff in ip late init phase */  int am=
dgpu_ras_late_init(struct amdgpu_device *adev,
                          struct ras_common_if *ras_block,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.h
index 1670467c2054..044bd19b7cce 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -345,6 +345,9 @@ struct amdgpu_ras {
         /* disable ras error count harvest in recovery */
         bool disable_ras_err_cnt_harvest;

+       /* is poison mode */
+       bool poison_mode_en;
+
         /* RAS count errors delayed work */
         struct delayed_work ras_counte_delay_work;
         atomic_t ras_ue_count;
@@ -640,4 +643,6 @@ void amdgpu_release_ras_context(struct amdgpu_device *a=
dev);

 int amdgpu_persistent_edc_harvesting_supported(struct amdgpu_device *adev)=
;

+bool amdgpu_ras_is_poison_enabled(struct amdgpu_device *adev);
+
 #endif
--
2.17.1

--_000_DM6PR12MB46502029AC84D32CCE5B7CBFB0DE9DM6PR12MB4650namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Poison mode is a global setting currently, will we set it per IP block in t=
he future?</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
For example, set poison mode for GFX but fatal error mode for SDMA?</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<span style=3D"color: rgb(0, 0, 0); font-family: calibri, arial, helvetica,=
 sans-serif; font-size: 12pt; background-color: rgb(255, 255, 255); display=
: inline !important;">dgpu_mode is disabled when&nbsp;</span><span style=3D=
"color: rgb(32, 31, 30); font-family: &quot;Segoe UI&quot;, &quot;Segoe UI =
Web (West European)&quot;, &quot;Segoe UI&quot;, -apple-system, BlinkMacSys=
temFont, Roboto, &quot;Helvetica Neue&quot;, sans-serif; font-size: 14.6667=
px; background-color: rgb(255, 255, 255); display: inline !important;"><spa=
n style=3D"background-color: rgb(255, 255, 255); font-family: calibri, aria=
l, helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0); display: in=
line !important;">connected_to_cpu
 is 1, is irrelevant to IP block.</span></span><br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Tao</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Zhang, Hawking &lt;Ha=
wking.Zhang@amd.com&gt;<br>
<b>Sent:</b> Saturday, September 18, 2021 4:59 PM<br>
<b>To:</b> Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;; amd-gfx@lists.freedesktop.=
org &lt;amd-gfx@lists.freedesktop.org&gt;; Clements, John &lt;John.Clements=
@amd.com&gt;; Yang, Stanley &lt;Stanley.Yang@amd.com&gt;<br>
<b>Subject:</b> RE: [PATCH 2/3] drm/amdgpu: set poison mode for RAS</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">[AMD Official Use Only]<br>
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ras_is_poison_enabled(adev=
))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ras_cmd-&gt;ras_in_message.init_flags.poison_mode_en =
=3D 1;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;gmc.xgmi.connected_to_c=
pu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ras_cmd-&gt;ras_in_message.init_flags.dgpu_mode =3D 1=
;<br>
<br>
I'd expect these flags are set in enable_feature command per IP block if ne=
eded. Instead of global setting at firmware/TA initialization phase, though=
ts?<br>
<br>
Regards,<br>
Hawking<br>
<br>
-----Original Message-----<br>
From: Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt; <br>
Sent: Saturday, September 18, 2021 16:08<br>
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking &lt;Hawking.Zhang@amd.com=
&gt;; Clements, John &lt;John.Clements@amd.com&gt;; Yang, Stanley &lt;Stanl=
ey.Yang@amd.com&gt;<br>
Cc: Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;<br>
Subject: [PATCH 2/3] drm/amdgpu: set poison mode for RAS<br>
<br>
Add RAS poison mode flag and tell PSP RAS TA about the info.<br>
<br>
Signed-off-by: Tao Zhou &lt;tao.zhou1@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c |&nbsp; 4 ++--&nbsp; drivers/=
gpu/drm/amd/amdgpu/amdgpu_ras.c | 28 +++++++++++++++++++++++++&nbsp; driver=
s/gpu/drm/amd/amdgpu/amdgpu_ras.h |&nbsp; 5 +++++<br>
&nbsp;3 files changed, 35 insertions(+), 2 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_psp.c<br>
index 7d09b28889af..140b94da2f5a 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c<br>
@@ -1442,9 +1442,9 @@ static int psp_ras_initialize(struct psp_context *psp=
)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ras_cmd =3D (struct ta_ras=
_shared_memory *)psp-&gt;ras_context.context.mem_context.shared_buf;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(ras_cmd, 0, sizeof(=
struct ta_ras_shared_memory));<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (psp-&gt;adev-&gt;gmc.xgmi.connect=
ed_to_cpu)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ras_is_poison_enabled(adev=
))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ras_cmd-&gt;ras_in_message.init_flags.poison_mode_en =
=3D 1;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; else<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;gmc.xgmi.connected_to_c=
pu)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; ras_cmd-&gt;ras_in_message.init_flags.dgpu_mode =3D 1=
;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D psp_ras_load(psp);=
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c<br>
index b5332db4d287..7b7e54fdd785 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c<br>
@@ -2180,6 +2180,7 @@ int amdgpu_ras_init(struct amdgpu_device *adev)&nbsp;=
 {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ras *con =3D=
 amdgpu_ras_get_context(adev);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool df_poison, umc_poison;<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (con)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return 0;<br>
@@ -2249,6 +2250,23 @@ int amdgpu_ras_init(struct amdgpu_device *adev)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto =
release_con;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Init poison mode, the default valu=
e is false */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;df.funcs &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;df.f=
uncs-&gt;query_ras_poison_mode &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;umc.=
ras_funcs &amp;&amp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;umc.=
ras_funcs-&gt;query_ras_poison_mode) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; df_poison =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;df.func=
s-&gt;query_ras_poison_mode(adev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; umc_poison =3D<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;umc.ras=
_funcs-&gt;query_ras_poison_mode(adev);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; /* Only poison is set in both DF and UMC, we can enable it */<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (df_poison &amp;&amp; umc_poison)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; con-&gt;poison_m=
ode_en =3D true;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else if (df_poison !=3D umc_poison)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_warn(adev-&g=
t;dev, &quot;Poison setting is inconsistent in DF/UMC(%d:%d)!\n&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; df_poison, umc_poison);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ras_fs_init(ade=
v)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; r =3D -EINVAL;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; goto release_con;<br>
@@ -2292,6 +2310,16 @@ static int amdgpu_persistent_edc_harvesting(struct a=
mdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&nbsp;}<br>
&nbsp;<br>
+bool amdgpu_ras_is_poison_enabled(struct amdgpu_device *adev) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ras *con =3D amdgpu_ras=
_get_context(adev);<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!con)<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; return false;<br>
+<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return con-&gt;poison_mode_en;<br>
+}<br>
+<br>
&nbsp;/* helper function to handle common stuff in ip late init phase */&nb=
sp; int amdgpu_ras_late_init(struct amdgpu_device *adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 struct ras_common_if *ras_block,<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.h<br>
index 1670467c2054..044bd19b7cce 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h<br>
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h<br>
@@ -345,6 +345,9 @@ struct amdgpu_ras {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* disable ras error count=
 harvest in recovery */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool disable_ras_err_cnt_h=
arvest;<br>
&nbsp;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* is poison mode */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool poison_mode_en;<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* RAS count errors delaye=
d work */<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct delayed_work ras_co=
unte_delay_work;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_t ras_ue_count;<br>
@@ -640,4 +643,6 @@ void amdgpu_release_ras_context(struct amdgpu_device *a=
dev);<br>
&nbsp;<br>
&nbsp;int amdgpu_persistent_edc_harvesting_supported(struct amdgpu_device *=
adev);<br>
&nbsp;<br>
+bool amdgpu_ras_is_poison_enabled(struct amdgpu_device *adev);<br>
+<br>
&nbsp;#endif<br>
--<br>
2.17.1<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM6PR12MB46502029AC84D32CCE5B7CBFB0DE9DM6PR12MB4650namp_--
