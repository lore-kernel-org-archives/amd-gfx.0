Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42FBBC47258
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jan 2024 03:23:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A28410E120;
	Thu, 18 Jan 2024 03:23:51 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2061.outbound.protection.outlook.com [40.107.100.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CCEE10E120
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jan 2024 03:23:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kb/VWcx+kUQC6PqVTA4OD9KXHSqgD8Zqhsd4YEyjWJRLA/bhVV9jYkjEWKAnaRgWCJfeklZH3fdV86FPZmciAOjp+eqNDfh7YRR94JMACJtYuPTtwa1YlQwmOMwlZwOZ2tU3i1CTKWrZQsQWwWSuyyP1aXwnvGKCX89coc0b2kylTLyQFZOuiauvmTApQg21O6xeK7lWyo1KHFbBYBZg5CXV5Jp+ckVsXAj4luTFw2FtGdbJBAppraybRBE+IlEW+vse13/BZIEL+6+wVmBEIuN5rdZBTJP4VtjE9irTb02FI+81k7oiPllRX94F4mPP++dAsXu+WH9S4IcVBGmFBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=phUVPMnpXboskT3Y5jdEH+jiYzd91rLWgkTj0cPeGHE=;
 b=UlJZkVKOL81S8e34tOv+2xMIs/s7W1TUB8EbOeVSd9ir+5+iay7tjwPOoBN+DwGOE3X6vI8zGxoulWPZUQR7c+oQ8J2RWuOvTDHENH7JNEF/8de3Zox3ZpBM+QIuP5dw4DJ4Ki+T415mEXruUArM8Iq+E9ULVL+Xjb8w2tEL6bx7z0aMBmmz9VS1olHONCY4QOacqG3HG/xMutGM/Lbb1fr4L3ikSsfdKR6SHvVh4xz0vysU+pNfegEDjw8dyt1SgPrxXk7nFO1OiZk+FX9nfQapdnXEADHSvqlW9cOPJIa33GVRqnIIePDqvKE9X3JNWoDQACAxoe7cdfzCgKLsLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=phUVPMnpXboskT3Y5jdEH+jiYzd91rLWgkTj0cPeGHE=;
 b=y3VQwTBt4Xvm7BCE2DXSV15z9Zuydy1tSpnhFfyKGl+acEo9fcp6vuCan1L+wJNGXGtwpGc4ofbSm5yfGdVUNSJGBaggiY0SEjJDd75q9N2F5ijniJ3iHpNxhL3R0VD0Jxms6lV7jOVgKvTl26Z5xsH7CojnEjQFcB3jOzgyZQU=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by PH7PR12MB7260.namprd12.prod.outlook.com (2603:10b6:510:208::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Thu, 18 Jan
 2024 03:23:40 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::5866:efa0:7f40:cd66]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::5866:efa0:7f40:cd66%3]) with mapi id 15.20.7202.020; Thu, 18 Jan 2024
 03:23:40 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/5] drm/amdgpu: Use asynchronous polling to handle
 umc_v12_0 poisoning
Thread-Topic: [PATCH 3/5] drm/amdgpu: Use asynchronous polling to handle
 umc_v12_0 poisoning
Thread-Index: AQHaSFT6xdFUUM2/mEKpGnudKHsH2rDd5x2AgAD+0YCAAAPXsA==
Date: Thu, 18 Jan 2024 03:23:40 +0000
Message-ID: <PH7PR12MB8796D3F264A2DA76C899DFE1B0712@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20240116082034.1739848-1-YiPeng.Chai@amd.com>
 <20240116082034.1739848-3-YiPeng.Chai@amd.com>
 <BN9PR12MB5257AD82E9E43586C082320CFC722@BN9PR12MB5257.namprd12.prod.outlook.com>
 <CH2PR12MB42155CF07B811857D84D73AAFC712@CH2PR12MB4215.namprd12.prod.outlook.com>
In-Reply-To: <CH2PR12MB42155CF07B811857D84D73AAFC712@CH2PR12MB4215.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=7042d7fa-7e6f-48c5-8149-7ac607d94b99;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-01-17T11:24:04Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|PH7PR12MB7260:EE_
x-ms-office365-filtering-correlation-id: 309f3f00-6bf2-479a-08f0-08dc17d4ddef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7LRZFYyXnpHI5aT/n+aDPzCeJDZjUUTrk+BODVmPEtBSI5oacuKc+41p2wJs53DPo3L/wRsgmOAZ2B1XEBTJUobN4f22zh+ujGMYEzFk1qCxEiUZn9NVINb+eNzGMe36ejKqUrX7Yz1kdgTa+nCdxI2lUMw3dmAOHfNdqyiXETCjO56ASgmqIxQqtzn0bvP+Lk+jlsXIqVK59BbB4pj9jF7jCDWkdS4XlmCLtA0E17b61IGM3wLXreEGc5Z2u5d8xYg62xpPdKWtrSFukntaqAEoZnHtHBS77w9szEk2DDwd2TwXrclJB81fHhi6fPkVlk+CG01sJ5YjVeZqN44hPprXovT0R1eEXzq/TJpY5xUuYRdUvQfzkBZgAOKTBzSoKAP5oEy5v0Yf/tfGMYMfcmFLlC0AmGRgKURZ9axStP66XY1FqGrhFVWi7XRIDgnTwf3mLNeid33+DcyNHSRJK6+ja3iH8gyVEHjZqx21ZY14In8MOqgvEsx+4vRnmdO1Kjz7DJJwgg9SGzaYVmyYoWId87OovCuzo2f5jXjMN2U64ZkxfQf9elF/d9p02X8Kxk2L9ASOt63Gg6MoSduRMrmEfHaeYmwxzJL1vI0J8iIZ/8KI9Vf6cifGo67v57tX
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(346002)(136003)(366004)(39860400002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(5660300002)(2906002)(8676002)(66476007)(4326008)(8936002)(30864003)(52536014)(316002)(110136005)(66446008)(76116006)(66946007)(55016003)(64756008)(66556008)(54906003)(478600001)(6506007)(7696005)(71200400001)(966005)(9686003)(83380400001)(26005)(41300700001)(38070700009)(122000001)(33656002)(38100700002)(86362001)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7r8yD60HFEkWK6oZGSycLvso/kUGSakIWchE4kVVA4TJaEg98RBGxA1LRv0J?=
 =?us-ascii?Q?jeEpSzcSMxU05XcSLwbGB1d+BrppHgV/0jBdNYW1HXMbojDfLY/E9YdcZ9Sa?=
 =?us-ascii?Q?rjTWAwfy3Lk2Tdjk2BXqp3LWKp5w4moBytfIYlpCUGQ/vQ7MITb+mf5Mj8xU?=
 =?us-ascii?Q?lXBA2nvQbchbRclq2Pb8zopiaxAIuMcLjQ6ZWQH/8LrkHGtIHCFBNG1/R4yv?=
 =?us-ascii?Q?sn4AaLEFGjdkES2Czg+rYa26t5oxO4AvuYUIyWuVduYn1ZKPIZdNDA9tmEDt?=
 =?us-ascii?Q?He/rAREgRqIQpIiLi6/wEhAnUqU0DlRBNJbpOu3yjnKJiBsTRKfng2GEl0S8?=
 =?us-ascii?Q?WG/2DkA+Not7PLckIQpg2A1ELtOkKdJId7gjsgjG+5AzIRNugqbkd5CGVrMh?=
 =?us-ascii?Q?iOSlNL9gdg94+HWbezdGjzYwlmzwoWiSrcFw/iukdUgjyon8y8hP5gBFaIFG?=
 =?us-ascii?Q?1LTVvUKOHXaL362DBOCUVMBfiTw3Doyc02myA+Rg2N6/1JsKgL6dlY6Exnfu?=
 =?us-ascii?Q?KQ93oCsPh/X3oet7fAlfbtMxNHCr9glyHCIltyrc5GpMsD7QOdnD65MdqxkI?=
 =?us-ascii?Q?m4UChmBjbUJufU/bw49me/pLn0m0oGRehjeDO3/dQTNEKMjpY9XCY6E/GKGD?=
 =?us-ascii?Q?SRzUsIDVc/f1qb924owQt/Jz+tPawNOBaDgNatqDPzbiECwecOD5WhoC5fM3?=
 =?us-ascii?Q?vymIjcGLGrvcDQpIziMyaflDDHWhwLAVn3i04j4OqPaLqk9p1X4i+az8GKdK?=
 =?us-ascii?Q?Yu9reY26GWV85IJ+JBB/GUBUbUAzgrjzFjAXpst+tTv3pvjvFAOmTKJWG0Yu?=
 =?us-ascii?Q?EXXw0ZybTn+FeRFeOpKLUk4uMeV7k2UhUeuLI2HmOVTE0tCaRv1hFr1t2sr9?=
 =?us-ascii?Q?KAMAvI2N7u5ABPfNfo4+xT0ZtYmLDskjCNlIdSy0h9IOFYC+ay3GJ0U0xswV?=
 =?us-ascii?Q?GcG1SSKYIkj/qb/9580e89czxABS8XM5MkQgJ0+V+Z/1Y38ygNWYyi2qdiZP?=
 =?us-ascii?Q?xa204jqdrLA3fA6hDR016J36nKrhealbNOqYkdTBWFs4UQxx8Zt86I2TRYH7?=
 =?us-ascii?Q?5j+A883RcF28CzdMBCtGJO5U1fOSRXKRq9FOIwGO4Em4Zmo2cHnRtepKe7d6?=
 =?us-ascii?Q?SvkHTSbHfnC7Pmz9pJQBLrPF9jG2WFo0OHOS5HtIkSrrGD3UfFYJTZm0H3iZ?=
 =?us-ascii?Q?E9ZPtk2m9a7aFedfgwyWfK3r3THoT/F9cd7GKiV/iNtz6dl+aU7X9425LFZc?=
 =?us-ascii?Q?Fy/L/RLOoBrjzH8Ns6LBTm6Yjg9KifHPS7XA1Ij/VZ+W37SyBqwtclxJmrrm?=
 =?us-ascii?Q?Bm3GH28HpFwnAX/a1h6RvCvfdQKUEetWunhTFRZpqPqm7EhGfPh4NeppoWy+?=
 =?us-ascii?Q?Fh2Lfc4aSqjn9md6qYlEgdi7z8ZlaGGlMTgsZ/TFOI+G6sskvIrthWqsZqgY?=
 =?us-ascii?Q?8vHvHz6Itr1MElBzCX0GALApnB6hwh0hnu6CLSC+ExiAbrpwMyHpFXFJQks4?=
 =?us-ascii?Q?Ti9vH41K//qerbK6Q4j7IPv1KlrHJklckfEh+qMeIo1eb9gSPXyly2Y0LsUz?=
 =?us-ascii?Q?C4cM8m1C5MxLdPirEpo=3D?=
Content-Type: multipart/alternative;
 boundary="_000_PH7PR12MB8796D3F264A2DA76C899DFE1B0712PH7PR12MB8796namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 309f3f00-6bf2-479a-08f0-08dc17d4ddef
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2024 03:23:40.3635 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A44G5P3QQb4MaJiklrfHp1hHWZ6LAWrEFpyyUeUtMS5HTiZaM4Dra3gYlTRIBJeO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7260
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
Cc: "Li, Candice" <Candice.Li@amd.com>, "Yang, Stanley" <Stanley.Yang@amd.com>,
 "Wang, Yang\(Kevin\)" <KevinYang.Wang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_PH7PR12MB8796D3F264A2DA76C899DFE1B0712PH7PR12MB8796namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]


      _____________________________________________
      From: Chai, Thomas <YiPeng.Chai@amd.com>
      Sent: Thursday, January 18, 2024 11:06 AM
      To: Zhang, Hawking <Hawking.Zhang@amd.com>; amd-gfx@lists.freedesktop=
.org
      Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>;=
 Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Yang, Stanley <Stanley.Yang@am=
d.com>
      Subject: RE: [PATCH 3/5] drm/amdgpu: Use asynchronous polling to hand=
le umc_v12_0 poisoning


      [AMD Official Use Only - General]






      -----------------
      Best Regards,
      Thomas


      _____________________________________________
      From: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.=
com>>
      Sent: Wednesday, January 17, 2024 7:54 PM
      To: Chai, Thomas <YiPeng.Chai@amd.com<mailto:YiPeng.Chai@amd.com>>; a=
md-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
      Cc: Zhou1, Tao <Tao.Zhou1@amd.com<mailto:Tao.Zhou1@amd.com>>; Li, Can=
dice <Candice.Li@amd.com<mailto:Candice.Li@amd.com>>; Wang, Yang(Kevin) <Ke=
vinYang.Wang@amd.com<mailto:KevinYang.Wang@amd.com>>; Yang, Stanley <Stanle=
y.Yang@amd.com<mailto:Stanley.Yang@amd.com>>
      Subject: RE: [PATCH 3/5] drm/amdgpu: Use asynchronous polling to hand=
le umc_v12_0 poisoning


      [AMD Official Use Only - General]



      Please check my comments inline

      Regards,
      Hawking

      -----Original Message-----
      From: Chai, Thomas <YiPeng.Chai@amd.com<mailto:YiPeng.Chai@amd.com>>
      Sent: Tuesday, January 16, 2024 16:21
      To: amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.or=
g>
      Cc: Chai, Thomas <YiPeng.Chai@amd.com<mailto:YiPeng.Chai@amd.com>>; Z=
hang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.com>>; Zhou1,=
 Tao <Tao.Zhou1@amd.com<mailto:Tao.Zhou1@amd.com>>; Li, Candice <Candice.Li=
@amd.com<mailto:Candice.Li@amd.com>>; Wang, Yang(Kevin) <KevinYang.Wang@amd=
.com<mailto:KevinYang.Wang@amd.com>>; Yang, Stanley <Stanley.Yang@amd.com<m=
ailto:Stanley.Yang@amd.com>>; Chai, Thomas <YiPeng.Chai@amd.com<mailto:YiPe=
ng.Chai@amd.com>>
      Subject: [PATCH 3/5] drm/amdgpu: Use asynchronous polling to handle u=
mc_v12_0 poisoning

      Use asynchronous polling to handle umc_v12_0 poisoning.

      Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com<mailto:YiPeng.Chai@am=
d.com>>
      ---
       drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c |   5 +
       drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 143 +++++++++++++++++++---=
--
       drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h |   3 +
       3 files changed, 120 insertions(+), 31 deletions(-)

      diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_ras.c
      index 856206e95842..44929281840e 100644
      --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
      +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
      @@ -118,6 +118,8 @@ const char *get_ras_block_str(struct ras_common_i=
f *ras_block)
       /* typical ECC bad page rate is 1 bad page per 100MB VRAM */
       #define RAS_BAD_PAGE_COVER              (100 * 1024 * 1024ULL)

      +#define MAX_UMC_POISON_POLLING_TIME_ASYNC  100  //ms
      +
       enum amdgpu_ras_retire_page_reservation {
        AMDGPU_RAS_RETIRE_PAGE_RESERVED,
        AMDGPU_RAS_RETIRE_PAGE_PENDING,
      @@ -2670,6 +2672,9 @@ static int amdgpu_ras_page_retirement_thread(vo=
id *param)
                        atomic_read(&con->page_retirement_req_cnt));

                atomic_dec(&con->page_retirement_req_cnt);
      +
      +         amdgpu_umc_poison_retire_page_polling_timeout(adev,
      +                         false, MAX_UMC_POISON_POLLING_TIME_ASYNC);
        }

        return 0;
      diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_umc.c
      index 9d1cf41cf483..2dde29cb807d 100644
      --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
      +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
      @@ -23,6 +23,7 @@

       #include "amdgpu.h"
       #include "umc_v6_7.h"
      +#define MAX_UMC_POISON_POLLING_TIME_SYNC   20  //ms

       static int amdgpu_umc_convert_error_address(struct amdgpu_device *ad=
ev,
                                    struct ras_err_data *err_data, uint64_t=
 err_addr, @@ -85,17 +86,14 @@ int amdgpu_umc_page_retirement_mca(struct am=
dgpu_device *adev,
        return ret;
       }

      -static int amdgpu_umc_do_page_retirement(struct amdgpu_device *adev,
      -         void *ras_error_status,
      -         struct amdgpu_iv_entry *entry,
      -         bool reset)
      +static void amdgpu_umc_handle_bad_pages(struct amdgpu_device *adev,
      +                 void *ras_error_status)
       {
        struct ras_err_data *err_data =3D (struct ras_err_data *)ras_error_=
status;
        struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
        int ret =3D 0;
        unsigned long err_count;
      -
      - kgd2kfd_set_sram_ecc_flag(adev->kfd.dev);
      + mutex_lock(&con->page_retirement_lock);
        ret =3D amdgpu_dpm_get_ecc_info(adev, (void *)&(con->umc_ecc));
        if (ret =3D=3D -EOPNOTSUPP) {
                if (adev->umc.ras && adev->umc.ras->ras_block.hw_ops && @@ =
-163,19 +161,86 @@ static int amdgpu_umc_do_page_retirement(struct amdgpu_d=
evice *adev,
                                con->update_channel_flag =3D false;
                        }
                }
      -
      -         if (reset) {
      -                 /* use mode-2 reset for poison consumption */
      -                 if (!entry)
      -                         con->gpu_reset_flags |=3D AMDGPU_RAS_GPU_RE=
SET_MODE2_RESET;
      -                 amdgpu_ras_reset_gpu(adev);
      -         }
        }

        kfree(err_data->err_addr);
      +
      + mutex_unlock(&con->page_retirement_lock);
      +}
      +
      +static int amdgpu_umc_do_page_retirement(struct amdgpu_device *adev,
      +         void *ras_error_status,
      +         struct amdgpu_iv_entry *entry,
      +         bool reset)
      +{
      + struct ras_err_data *err_data =3D (struct ras_err_data *)ras_error_=
status;
      + struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
      +
      + kgd2kfd_set_sram_ecc_flag(adev->kfd.dev);
      + amdgpu_umc_handle_bad_pages(adev, ras_error_status);
      +
      + if (err_data->ue_count && reset) {
      +         /* use mode-2 reset for poison consumption */
      +         if (!entry)
      +                 con->gpu_reset_flags |=3D AMDGPU_RAS_GPU_RESET_MODE=
2_RESET;

      >[Hawking]: Shall we do further check on con->poison_supported flag t=
o decide issuing mode-2 or mode-1.
      [thomas] This "gpu reset" code is not belong to page retirement range=
,  but reuse old code.  About how to reset gpu, we can do it with  another =
patch in  future.

               [Tao] in fact, the condition "if (!entry)" is for poison mod=
e. If poison isn't supported, only umc ue error needs page retirement, it w=
ill be called in related cb interface and the entry would not be null.

      +         amdgpu_ras_reset_gpu(adev);
      + }
      +
        return AMDGPU_RAS_SUCCESS;
       }

      +int amdgpu_umc_poison_retire_page_polling_timeout(struct amdgpu_devi=
ce *adev,
      +                 bool reset, uint32_t timeout_ms)
      [Hawking] int amdgpu_umc_bad_page_polling_timeout(struct amdgpu_devic=
e *adev, boot reset, uint32_t timeout_ms)
      [thomas] OK

      +{
      + struct ras_err_data err_data;
      + struct ras_common_if head =3D {
      +         .block =3D AMDGPU_RAS_BLOCK__UMC,
      + };
      + struct ras_manager *obj =3D amdgpu_ras_find_obj(adev, &head);
      + uint32_t timeout =3D timeout_ms;
      +
      + memset(&err_data, 0, sizeof(err_data));
      + amdgpu_ras_error_data_init(&err_data);
      +
      + do {
      +
      +         amdgpu_umc_handle_bad_pages(adev, &err_data);
      +
      +         if (timeout && !err_data.de_count) {
      +                 msleep(1);
      +                 timeout--;
      +         }
      +
      + } while (timeout && !err_data.de_count);
      +
      + if (!timeout)
      +         dev_warn(adev->dev, "Page retirment executed, but did not f=
ind bad
      +pages\n");

      [Hawking] dev_warn (adev->dev, "can't find bad pages\n");
      [thomas] OK

      +
      + if (err_data.de_count)
      +         dev_info(adev->dev, "Page retirment: ue:%ld, ce:%ld, de:%ld=
\n",
      +                         err_data.ue_count, err_data.ce_count, err_d=
ata.de_count);

      [Hawking] dev_info(adev->dev, "%ld new deferred hardware errors detec=
ted\n", err_data.de_count)
      [thomas] OK

      +
      + if (obj) {
      +         obj->err_data.ue_count +=3D err_data.ue_count;
      +         obj->err_data.ce_count +=3D err_data.ce_count;
      +         obj->err_data.de_count +=3D err_data.de_count;
      + }
      +
      + amdgpu_ras_error_data_fini(&err_data);
      +
      + kgd2kfd_set_sram_ecc_flag(adev->kfd.dev);
      +
      + if (reset) {
      +         struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
      +
      +         /* use mode-2 reset for poison consumption */
      +         con->gpu_reset_flags |=3D AMDGPU_RAS_GPU_RESET_MODE2_RESET;

      [Hawking]: Shall we do further check on con->poison_supported flag to=
 decide issuing mode-2 or mode-1.
      [thomas] This "gpu reset" code is not belong to page retirement range=
, but reuse old code.  About how to reset gpu, we can do it with  another p=
atch in  future.


      +         amdgpu_ras_reset_gpu(adev);
      + }
      +
      + return 0;
      +}
      +
       int amdgpu_umc_poison_handler(struct amdgpu_device *adev, bool reset=
)  {
        int ret =3D AMDGPU_RAS_SUCCESS;
      @@ -193,25 +258,41 @@ int amdgpu_umc_poison_handler(struct amdgpu_dev=
ice *adev, bool reset)
        }

        if (!amdgpu_sriov_vf(adev)) {
      -         struct ras_err_data err_data;
      -         struct ras_common_if head =3D {
      -                 .block =3D AMDGPU_RAS_BLOCK__UMC,
      -         };
      -         struct ras_manager *obj =3D amdgpu_ras_find_obj(adev, &head=
);
      -
      -         ret =3D amdgpu_ras_error_data_init(&err_data);
      -         if (ret)
      -                 return ret;
      -
      -         ret =3D amdgpu_umc_do_page_retirement(adev, &err_data, NULL=
, reset);
      -
      -         if (ret =3D=3D AMDGPU_RAS_SUCCESS && obj) {
      -                 obj->err_data.ue_count +=3D err_data.ue_count;
      -                 obj->err_data.ce_count +=3D err_data.ce_count;
      -                 obj->err_data.de_count +=3D err_data.de_count;
      -         }
      +         if (amdgpu_ip_version(adev, UMC_HWIP, 0) !=3D IP_VERSION(12=
, 0, 0)) {
      [Hawking]: if (amdgpu_ip_version(adev, UMC_HWIP, 0) < IP_VERSION(12, =
0, 0)) {
      [thomas] OK


      +                 struct ras_err_data err_data;
      +                 struct ras_common_if head =3D {
      +                         .block =3D AMDGPU_RAS_BLOCK__UMC,
      +                 };
      +                 struct ras_manager *obj =3D amdgpu_ras_find_obj(ade=
v, &head);
      +
      +                 ret =3D amdgpu_ras_error_data_init(&err_data);
      +                 if (ret)
      +                         return ret;
      +
      +                 ret =3D amdgpu_umc_do_page_retirement(adev, &err_da=
ta, NULL, reset);

      -         amdgpu_ras_error_data_fini(&err_data);
      +                 if (ret =3D=3D AMDGPU_RAS_SUCCESS && obj) {
      +                         obj->err_data.ue_count +=3D err_data.ue_cou=
nt;
      +                         obj->err_data.ce_count +=3D err_data.ce_cou=
nt;
      +                         obj->err_data.de_count +=3D err_data.de_cou=
nt;
      +                 }
      +
      +                 amdgpu_ras_error_data_fini(&err_data);
      +         } else {
      +                 if (reset) {
      +                         amdgpu_umc_poison_retire_page_polling_timeo=
ut(adev,
      +                                                 reset, MAX_UMC_POIS=
ON_POLLING_TIME_SYNC);
      +                 } else {
      +                         struct amdgpu_ras *con =3D amdgpu_ras_get_c=
ontext(adev);
      +
      +                         dev_info(adev->dev, "Page retirement pendin=
g request count: %d\n",
      +                         atomic_read(&con->page_retirement_req_cnt))=
;

      [Hawking]: might remove the printed message here.
      [thomas] OK


      +
      +                         atomic_inc(&con->page_retirement_req_cnt);
      +
      +                         wake_up(&con->page_retirement_wq);
      +                 }
      +         }
        } else {
                if (adev->virt.ops && adev->virt.ops->ras_poison_handler)
                        adev->virt.ops->ras_poison_handler(adev);
      diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_umc.h
      index 417a6726c71b..ee487adce7e4 100644
      --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
      +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
      @@ -118,4 +118,7 @@ int amdgpu_umc_page_retirement_mca(struct amdgpu_=
device *adev,

       int amdgpu_umc_loop_channels(struct amdgpu_device *adev,
                        umc_func func, void *data);
      +
      +int amdgpu_umc_poison_retire_page_polling_timeout(struct amdgpu_devi=
ce *adev,
      +                 bool reset, uint32_t timeout_ms);
       #endif
      --
      2.34.1


--_000_PH7PR12MB8796D3F264A2DA76C899DFE1B0712PH7PR12MB8796namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from rtf -->
<style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left:=
 #800000 2px solid; } --></style>
</head>
<body>
<font face=3D"Arial" size=3D"2"><span style=3D"font-size:10pt;">
<div style=3D"padding-right:5pt;padding-left:5pt;"><font color=3D"blue">[AM=
D Official Use Only - General]<br>

</font></div>
<div style=3D"margin-top:5pt;"><font face=3D"Times New Roman" size=3D"3"><s=
pan style=3D"font-size:12pt;"><br>

</span></font></div>
<div><font face=3D"Times New Roman" size=3D"2"><span style=3D"font-size:11p=
t;">&nbsp;</span></font></div>
<div><font face=3D"Times New Roman" size=3D"2"><span style=3D"font-size:11p=
t;">&nbsp;</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"DengXian" size=3D"2"><span =
style=3D"font-size:11pt;">_____________________________________________<br>

<b>From:</b> Chai, Thomas &lt;YiPeng.Chai@amd.com&gt; <br>

<b>Sent:</b> Thursday, January 18, 2024 11:06 AM<br>

<b>To:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; amd-gfx@lists.free=
desktop.org<br>

<b>Cc:</b> Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;; Li, Candice &lt;Candice.Li=
@amd.com&gt;; Wang, Yang(Kevin) &lt;KevinYang.Wang@amd.com&gt;; Yang, Stanl=
ey &lt;Stanley.Yang@amd.com&gt;<br>

<b>Subject:</b> RE: [PATCH 3/5] drm/amdgpu: Use asynchronous polling to han=
dle umc_v12_0 poisoning</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Times New Roman" size=3D"2"=
><span style=3D"font-size:11pt;">&nbsp;</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Times New Roman" size=3D"2"=
><span style=3D"font-size:11pt;">&nbsp;</span></font></div>
<div style=3D"padding-right:5pt;padding-left:41pt;"><font face=3D"Arial" co=
lor=3D"blue">[AMD Official Use Only - General]<br>

</font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Times New Roman" size=3D"2"=
><span style=3D"font-size:11pt;"><br>

</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Times New Roman" size=3D"2"=
><span style=3D"font-size:11pt;">&nbsp;</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Times New Roman" size=3D"2"=
><span style=3D"font-size:11pt;">&nbsp;</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Times New Roman" size=3D"2"=
><span style=3D"font-size:11pt;">&nbsp;</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">-----------------</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">Best Regards,</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">Thomas</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">&nbsp;</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Times New Roman" size=3D"2"=
><span style=3D"font-size:11pt;">&nbsp;</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"DengXian" size=3D"2"><span =
style=3D"font-size:11pt;">_____________________________________________<br>

<b>From:</b> Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.com"><f=
ont color=3D"#0563C1"><u>Hawking.Zhang@amd.com</u></font></a>&gt;
<br>

<b>Sent:</b> Wednesday, January 17, 2024 7:54 PM<br>

<b>To:</b> Chai, Thomas &lt;<a href=3D"mailto:YiPeng.Chai@amd.com"><font co=
lor=3D"#0563C1"><u>YiPeng.Chai@amd.com</u></font></a>&gt;; <a href=3D"mailt=
o:amd-gfx@lists.freedesktop.org"><font color=3D"#0563C1"><u>amd-gfx@lists.f=
reedesktop.org</u></font></a><br>

<b>Cc:</b> Zhou1, Tao &lt;<a href=3D"mailto:Tao.Zhou1@amd.com"><font color=
=3D"#0563C1"><u>Tao.Zhou1@amd.com</u></font></a>&gt;; Li, Candice &lt;<a hr=
ef=3D"mailto:Candice.Li@amd.com"><font color=3D"#0563C1"><u>Candice.Li@amd.=
com</u></font></a>&gt;; Wang, Yang(Kevin) &lt;<a href=3D"mailto:KevinYang.W=
ang@amd.com"><font color=3D"#0563C1"><u>KevinYang.Wang@amd.com</u></font></=
a>&gt;;
Yang, Stanley &lt;<a href=3D"mailto:Stanley.Yang@amd.com"><font color=3D"#0=
563C1"><u>Stanley.Yang@amd.com</u></font></a>&gt;<br>

<b>Subject:</b> RE: [PATCH 3/5] drm/amdgpu: Use asynchronous polling to han=
dle umc_v12_0 poisoning</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Times New Roman" size=3D"2"=
><span style=3D"font-size:11pt;">&nbsp;</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Times New Roman" size=3D"2"=
><span style=3D"font-size:11pt;">&nbsp;</span></font></div>
<div style=3D"padding-right:5pt;padding-left:41pt;"><font face=3D"Arial" co=
lor=3D"blue">[AMD Official Use Only - General]<br>

</font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Times New Roman" size=3D"2"=
><span style=3D"font-size:11pt;"><br>

</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2" color=
=3D"#2F5496"><span style=3D"font-size:11pt;">Please check my comments inlin=
e</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2" color=
=3D"#2F5496"><span style=3D"font-size:11pt;">&nbsp;</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2" color=
=3D"#2F5496"><span style=3D"font-size:11pt;">Regards,<br>

Hawking</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Times New Roman" size=3D"2"=
><span style=3D"font-size:11pt;">&nbsp;</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">-----Original Message-----<br>

From: Chai, Thomas &lt;<a href=3D"mailto:YiPeng.Chai@amd.com"><font color=
=3D"#0563C1"><u>YiPeng.Chai@amd.com</u></font></a>&gt;
<br>

Sent: Tuesday, January 16, 2024 16:21<br>

To: <a href=3D"mailto:amd-gfx@lists.freedesktop.org"><font color=3D"#0563C1=
"><u>amd-gfx@lists.freedesktop.org</u></font></a><br>

Cc: Chai, Thomas &lt;<a href=3D"mailto:YiPeng.Chai@amd.com"><font color=3D"=
#0563C1"><u>YiPeng.Chai@amd.com</u></font></a>&gt;; Zhang, Hawking &lt;<a h=
ref=3D"mailto:Hawking.Zhang@amd.com"><font color=3D"#0563C1"><u>Hawking.Zha=
ng@amd.com</u></font></a>&gt;; Zhou1, Tao &lt;<a href=3D"mailto:Tao.Zhou1@a=
md.com"><font color=3D"#0563C1"><u>Tao.Zhou1@amd.com</u></font></a>&gt;;
Li, Candice &lt;<a href=3D"mailto:Candice.Li@amd.com"><font color=3D"#0563C=
1"><u>Candice.Li@amd.com</u></font></a>&gt;; Wang, Yang(Kevin) &lt;<a href=
=3D"mailto:KevinYang.Wang@amd.com"><font color=3D"#0563C1"><u>KevinYang.Wan=
g@amd.com</u></font></a>&gt;; Yang, Stanley &lt;<a href=3D"mailto:Stanley.Y=
ang@amd.com"><font color=3D"#0563C1"><u>Stanley.Yang@amd.com</u></font></a>=
&gt;;
Chai, Thomas &lt;<a href=3D"mailto:YiPeng.Chai@amd.com"><font color=3D"#056=
3C1"><u>YiPeng.Chai@amd.com</u></font></a>&gt;<br>

Subject: [PATCH 3/5] drm/amdgpu: Use asynchronous polling to handle umc_v12=
_0 poisoning</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Times New Roman" size=3D"2"=
><span style=3D"font-size:11pt;">&nbsp;</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">Use asynchronous polling to handle umc_v12_0 poiso=
ning.</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">&nbsp;</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">Signed-off-by: YiPeng Chai &lt;<a href=3D"mailto:Y=
iPeng.Chai@amd.com">YiPeng.Chai@amd.com</a>&gt;</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">---</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;"> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c |&nbsp;&n=
bsp; 5 +</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;"> drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 143 +++=
++++++++++++++++-----</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;"> drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h |&nbsp;&n=
bsp; 3 +</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;"> 3 files changed, 120 insertions(+), 31 deletions(=
-)</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">&nbsp;</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras=
.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">index 856206e95842..44929281840e 100644</span></fo=
nt></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c</spa=
n></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c</spa=
n></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">@@ -118,6 +118,8 @@ const char *get_ras_block_str(=
struct ras_common_if *ras_block)</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;"> /* typical ECC bad page rate is 1 bad page per 10=
0MB VRAM */</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;"> #define RAS_BAD_PAGE_COVER&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (100 * 1024 * 1024U=
LL)</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">&nbsp;</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+#define MAX_UMC_POISON_POLLING_TIME_ASYNC&nbsp; 1=
00&nbsp; //ms</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;"> enum amdgpu_ras_retire_page_reservation {</span><=
/font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; A=
MDGPU_RAS_RETIRE_PAGE_RESERVED,</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; A=
MDGPU_RAS_RETIRE_PAGE_PENDING,</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">@@ -2670,6 +2672,9 @@ static int amdgpu_ras_page_r=
etirement_thread(void *param)</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; atomic_read(&amp;con-&gt;page_retirement_req_cnt));</sp=
an></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">&nbsp;</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_dec(&amp;con-&gt;page=
_retirement_req_cnt);</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_umc_poison_retire_page_polling_t=
imeout(adev,</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; false, MAX_UMC_POI=
SON_POLLING_TIME_ASYNC);</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }=
</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">&nbsp;</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r=
eturn 0;</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc=
.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">index 9d1cf41cf483..2dde29cb807d 100644</span></fo=
nt></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c</spa=
n></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c</spa=
n></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">@@ -23,6 +23,7 @@</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">&nbsp;</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;"> #include &quot;amdgpu.h&quot;</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;"> #include &quot;umc_v6_7.h&quot;</span></font></di=
v>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+#define MAX_UMC_POISON_POLLING_TIME_SYNC&nbsp;&nb=
sp; 20&nbsp; //ms</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">&nbsp;</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;"> static int amdgpu_umc_convert_error_address(struc=
t amdgpu_device *adev,</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; struct ras_err_data *err_data, uint64_t err_addr, @@ -85,1=
7 +86,14 @@ int amdgpu_umc_page_retirement_mca(struct amdgpu_device *adev,<=
/span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r=
eturn ret;</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;"> }</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">&nbsp;</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">-static int amdgpu_umc_do_page_retirement(struct a=
mdgpu_device *adev,</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *ras_error_status,</span></font></=
div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_iv_entry *entry,</span></=
font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool reset)</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+static void amdgpu_umc_handle_bad_pages(struct am=
dgpu_device *adev,</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; void *ras_error_status)</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;"> {</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s=
truct ras_err_data *err_data =3D (struct ras_err_data *)ras_error_status;</=
span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s=
truct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i=
nt ret =3D 0;</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u=
nsigned long err_count;</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">-</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kgd2kfd_set_=
sram_ecc_flag(adev-&gt;kfd.dev);</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_lock(&=
amp;con-&gt;page_retirement_lock);</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r=
et =3D amdgpu_dpm_get_ecc_info(adev, (void *)&amp;(con-&gt;umc_ecc));</span=
></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i=
f (ret =3D=3D -EOPNOTSUPP) {</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;umc.ras &amp;&a=
mp; adev-&gt;umc.ras-&gt;ras_block.hw_ops &amp;&amp; @@ -163,19 +161,86 @@ =
static int amdgpu_umc_do_page_retirement(struct amdgpu_device *adev,</span>=
</font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; con-&gt=
;update_channel_flag =3D false;</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; }</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">-</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (reset) {</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; /* use mode-2 reset for poison consumption */</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; if (!entry)</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; con-&gt;gpu_reset_=
flags |=3D AMDGPU_RAS_GPU_RESET_MODE2_RESET;</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; amdgpu_ras_reset_gpu(adev);</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }=
</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">&nbsp;</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; k=
free(err_data-&gt;err_addr);</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mutex_unlock=
(&amp;con-&gt;page_retirement_lock);</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+}</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+static int amdgpu_umc_do_page_retirement(struct a=
mdgpu_device *adev,</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *ras_error_status,</span></font></=
div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_iv_entry *entry,</span></=
font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool reset)</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+{</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ras_e=
rr_data *err_data =3D (struct ras_err_data *)ras_error_status;</span></font=
></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgp=
u_ras *con =3D amdgpu_ras_get_context(adev);</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kgd2kfd_set_=
sram_ecc_flag(adev-&gt;kfd.dev);</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_umc_h=
andle_bad_pages(adev, ras_error_status);</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (err_data=
-&gt;ue_count &amp;&amp; reset) {</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* use mode-2 reset for poison consumpt=
ion */</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!entry)</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; con-&gt;gpu_reset_flags |=3D AMDGPU_RAS_GPU_RESET_MODE2_RESET;</sp=
an></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Times New Roman" size=3D"2"=
><span style=3D"font-size:11pt;">&nbsp;</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">&gt;<font color=3D"#2F5496">[Hawking]: Shall we do=
 further check on con-&gt;poison_supported flag to decide issuing mode-2 or=
 mode-1.</font></span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">[thomas] This &#8220;gpu reset&#8221; code is not =
belong to page retirement range,&nbsp; but reuse old code.&nbsp; About how =
to reset gpu, we can do it with&nbsp; another patch in&nbsp; future.</span>=
</font></div>
<div><font face=3D"Times New Roman" size=3D"2"><span style=3D"font-size:11p=
t;">&nbsp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; [Tao] in fact, the condition &#8220;if (!entry)&#8221; is for poison =
mode. If poison isn&#8217;t supported, only umc ue error needs page retirem=
ent, it will be called in related cb interface and
the entry would not be null.</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Times New Roman" size=3D"2"=
 color=3D"#2F5496"><span style=3D"font-size:11pt;">&nbsp;</span></font></di=
v>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ras_reset_gpu(adev);</span></fon=
t></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></fo=
nt></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r=
eturn AMDGPU_RAS_SUCCESS;</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;"> }</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">&nbsp;</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+int amdgpu_umc_poison_retire_page_polling_timeout=
(struct amdgpu_device *adev,</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; bool reset, uint32_t timeout_ms)</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2" color=
=3D"#2F5496"><span style=3D"font-size:11pt;">[Hawking] int amdgpu_umc_bad_p=
age_polling_timeout(struct amdgpu_device *adev, boot reset, uint32_t timeou=
t_ms)</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">[thomas] OK</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">&nbsp;</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+{</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ras_e=
rr_data err_data;</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ras_c=
ommon_if head =3D {</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .block =3D AMDGPU_RAS_BLOCK__UMC,</span=
></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };</span></f=
ont></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ras_m=
anager *obj =3D amdgpu_ras_find_obj(adev, &amp;head);</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t tim=
eout =3D timeout_ms;</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memset(&amp;=
err_data, 0, sizeof(err_data));</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ras_e=
rror_data_init(&amp;err_data);</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; do {</span><=
/font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_umc_handle_bad_pages(adev, &amp;=
err_data);</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (timeout &amp;&amp; !err_data.de_cou=
nt) {</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; msleep(1);</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; timeout--;</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } while (tim=
eout &amp;&amp; !err_data.de_count);</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!timeout=
)</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_warn(adev-&gt;dev, &quot;Page retir=
ment executed, but did not find bad </span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+pages\n&quot;);</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Times New Roman" size=3D"2"=
><span style=3D"font-size:11pt;">&nbsp;</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2" color=
=3D"#2F5496"><span style=3D"font-size:11pt;">[Hawking] dev_warn (adev-&gt;d=
ev, &#8220;can&#8217;t find bad pages\n&#8221;);</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">[thomas] OK</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Times New Roman" size=3D"2"=
 color=3D"#2F5496"><span style=3D"font-size:11pt;">&nbsp;</span></font></di=
v>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (err_data=
.de_count)</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;dev, &quot;Page retir=
ment: ue:%ld, ce:%ld, de:%ld\n&quot;,</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err_data.ue_count,=
 err_data.ce_count, err_data.de_count);</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Times New Roman" size=3D"2"=
><span style=3D"font-size:11pt;">&nbsp;</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2" color=
=3D"#2F5496"><span style=3D"font-size:11pt;">[Hawking] dev_info(adev-&gt;de=
v, &#8220;%ld new deferred hardware errors detected\n&#8221;, err_data.de_c=
ount)</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">[thomas] OK</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">&nbsp;</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (obj) {</=
span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; obj-&gt;err_data.ue_count +=3D err_data=
.ue_count;</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; obj-&gt;err_data.ce_count +=3D err_data=
.ce_count;</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; obj-&gt;err_data.de_count +=3D err_data=
.de_count;</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></fo=
nt></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ras_e=
rror_data_fini(&amp;err_data);</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kgd2kfd_set_=
sram_ecc_flag(adev-&gt;kfd.dev);</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (reset) {=
</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ras *con =3D amdgpu_ras_g=
et_context(adev);</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* use mode-2 reset for poison consumpt=
ion */</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; con-&gt;gpu_reset_flags |=3D AMDGPU_RAS=
_GPU_RESET_MODE2_RESET;</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Times New Roman" size=3D"2"=
><span style=3D"font-size:11pt;">&nbsp;</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2" color=
=3D"#2F5496"><span style=3D"font-size:11pt;">[Hawking]: Shall we do further=
 check on con-&gt;poison_supported flag to decide issuing mode-2 or mode-1.=
</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">[thomas] This &#8220;gpu reset&#8221; code is not =
belong to page retirement range, but reuse old code.&nbsp; About how to res=
et gpu, we can do it with&nbsp; another patch in&nbsp; future.</span></font=
></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">&nbsp;</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">&nbsp;</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ras_reset_gpu(adev);</span></fon=
t></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></fo=
nt></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;</s=
pan></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+}</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;"> int amdgpu_umc_poison_handler(struct amdgpu_devic=
e *adev, bool reset)&nbsp; {</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i=
nt ret =3D AMDGPU_RAS_SUCCESS;</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">@@ -193,25 +258,41 @@ int amdgpu_umc_poison_handle=
r(struct amdgpu_device *adev, bool reset)</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }=
</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">&nbsp;</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i=
f (!amdgpu_sriov_vf(adev)) {</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ras_err_data err_data;</span></f=
ont></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ras_common_if head =3D {</span><=
/font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; .block =3D AMDGPU_RAS_BLOCK__UMC,</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; };</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct ras_manager *obj =3D amdgpu_ras_=
find_obj(adev, &amp;head);</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">-</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_ras_error_data_init(&amp=
;err_data);</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; return ret;</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">-</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D amdgpu_umc_do_page_retirement(a=
dev, &amp;err_data, NULL, reset);</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">-</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret =3D=3D AMDGPU_RAS_SUCCESS &amp;=
&amp; obj) {</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; obj-&gt;err_data.ue_count +=3D err_data.ue_count;</span></font></d=
iv>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; obj-&gt;err_data.ce_count +=3D err_data.ce_count;</span></font></d=
iv>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; obj-&gt;err_data.de_count +=3D err_data.de_count;</span></font></d=
iv>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_ip_version(adev, UMC_HWIP, 0=
) !=3D IP_VERSION(12, 0, 0)) {</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2" color=
=3D"#2F5496"><span style=3D"font-size:11pt;">[Hawking]: if (amdgpu_ip_versi=
on(adev, UMC_HWIP, 0) &lt; IP_VERSION(12, 0, 0)) {</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">[thomas] OK</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">&nbsp;</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">&nbsp;</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; struct ras_err_data err_data;</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; struct ras_common_if head =3D {</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .block =3D AMDGPU_=
RAS_BLOCK__UMC,</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; };</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; struct ras_manager *obj =3D amdgpu_ras_find_obj(adev, &amp;head);<=
/span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; ret =3D amdgpu_ras_error_data_init(&amp;err_data);</span></font></=
div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; if (ret)</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return ret;</span>=
</font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; ret =3D amdgpu_umc_do_page_retirement(adev, &amp;err_data, NULL, r=
eset);</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">&nbsp;</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ras_error_data_fini(&amp;err_dat=
a);</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; if (ret =3D=3D AMDGPU_RAS_SUCCESS &amp;&amp; obj) {</span></font><=
/div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; obj-&gt;err_data.u=
e_count +=3D err_data.ue_count;</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; obj-&gt;err_data.c=
e_count +=3D err_data.ce_count;</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; obj-&gt;err_data.d=
e_count +=3D err_data.de_count;</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; }</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; amdgpu_ras_error_data_fini(&amp;err_data);</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; if (reset) {</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_umc_poison_=
retire_page_polling_timeout(adev,</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; reset, MAX_UMC_POISON_PO=
LLING_TIME_SYNC);</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; } else {</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ras =
*con =3D amdgpu_ras_get_context(adev);</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_info(adev-&gt;=
dev, &quot;Page retirement pending request count: %d\n&quot;,</span></font>=
</div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_read(&amp;c=
on-&gt;page_retirement_req_cnt));</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Times New Roman" size=3D"2"=
><span style=3D"font-size:11pt;">&nbsp;</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2" color=
=3D"#2F5496"><span style=3D"font-size:11pt;">[Hawking]: might remove the pr=
inted message here.</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">[thomas] OK</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">&nbsp;</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">&nbsp;</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; atomic_inc(&amp;co=
n-&gt;page_retirement_req_cnt);</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; wake_up(&amp;con-&=
gt;page_retirement_wq);</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; }</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }=
 else {</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (adev-&gt;virt.ops &amp;&=
amp; adev-&gt;virt.ops-&gt;ras_poison_handler)</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; adev-&gt;virt.ops-&gt;ras_poison_handler(adev);</span><=
/font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc=
.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">index 417a6726c71b..ee487adce7e4 100644</span></fo=
nt></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h</spa=
n></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h</spa=
n></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">@@ -118,4 +118,7 @@ int amdgpu_umc_page_retirement=
_mca(struct amdgpu_device *adev,</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">&nbsp;</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;"> int amdgpu_umc_loop_channels(struct amdgpu_device=
 *adev,</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; umc_func func, void *data);</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+int amdgpu_umc_poison_retire_page_polling_timeout=
(struct amdgpu_device *adev,</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; bool reset, uint32_t timeout_ms);</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;"> #endif</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">--</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Calibri" size=3D"2"><span s=
tyle=3D"font-size:11pt;">2.34.1</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"Times New Roman" size=3D"2"=
><span style=3D"font-size:11pt;">&nbsp;</span></font></div>
</span></font>
</body>
</html>

--_000_PH7PR12MB8796D3F264A2DA76C899DFE1B0712PH7PR12MB8796namp_--
