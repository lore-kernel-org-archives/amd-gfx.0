Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 571CFC4707B
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jan 2024 05:29:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D633B10E13D;
	Thu, 18 Jan 2024 05:29:37 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3245E10E13D
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jan 2024 05:29:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pt7FvwqnPRKpopjmba7rkzWOnkk9fog8etxPnMK1A3DDuNnV+s33urXukfAx6+9Aj/92nT2fE8F6tguvqsjjnWMJzLO+J8nJsuXQmMmjGcILG5jxLJd8YlmvvyXQ2v+bw0uJs1v0FRocAWxmPRMLqK75OYsn1zXUEmA7L+U6eO8m5g6fzspZcr0HOAksGTLFtzuFC8iTMtjQEbSjMHxv8/dsL8TZk7LRFH/5IWrSqilniMxtKwOw3ndZfQkAmK3A1vEqxqrKfUsHtmAHaxHP4OsYvgAiyH6HmwnT5lZe9rin9JP6pLO+aYSVQAhbXBB2XVpDZWZ6bq/bNuSn61PitA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r7hyLOxty1UStkJlEWsSjdJ/w2aHGIP4sCWJGzWjEQk=;
 b=EEmnWQk+WHOwQrn8lpWiWKToAssuO3lGHaW+Nq2MUjBj8D6RDT+sTKOSFXmfsqVo9nzn+QWaz16+cvCriqk1enwTxjmPi3USKWeImKhGaSR7ipQxwlV8NMp798M+YCIC8i4ISEi8w4oJ2LiCohDRB22DX7Tr6jV87di+Lkafbv4uOrnPgl91fP9Rqazgk8W7YAIPi/2t4+IGzVh9sesGmjK9OnmHtSitaEvQ/aQlDXzzegHMnKrttQCkFGm6nCiHGaZdhpgVQBurgaxnJCKn9Sw0LXpfs1s/RbGYXFUH8vFDdqIRO7yx8pwaHga9Ix8/HD0C65cKVlqoDKZYIhq8RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r7hyLOxty1UStkJlEWsSjdJ/w2aHGIP4sCWJGzWjEQk=;
 b=kSghyisDZqIpwucHi8p1LFUJpGlM4SnNMcxSi0WFo7dj3SyXig2inqhh2fvkqdHFuclsSm5w8wwkN9/92MMKwQqpxGtdWklAvISDzBPqAl+GR3Z+gfJZxz41vjY6Qo6tQOVQvlEQrhHUAbSJLKzLhbgje+pY2wdLWpje/i/BGtY=
Received: from CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 by CH2PR12MB5516.namprd12.prod.outlook.com (2603:10b6:610:6b::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26; Thu, 18 Jan
 2024 05:29:31 +0000
Received: from CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::2c41:8d9b:d594:6865]) by CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::2c41:8d9b:d594:6865%6]) with mapi id 15.20.7202.024; Thu, 18 Jan 2024
 05:29:31 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 3/5] drm/amdgpu: Use asynchronous polling to handle
 umc_v12_0 poisoning
Thread-Topic: [PATCH 3/5] drm/amdgpu: Use asynchronous polling to handle
 umc_v12_0 poisoning
Thread-Index: AQHaSFT6B9zku1ReLkynpX1GrevUtbDd5x2AgAD3DCCAAAyjAIAAIVHQ
Date: Thu, 18 Jan 2024 05:29:30 +0000
Message-ID: <CH2PR12MB42154DC81B1A7D5CDC00FB80FC712@CH2PR12MB4215.namprd12.prod.outlook.com>
References: <20240116082034.1739848-1-YiPeng.Chai@amd.com>
 <20240116082034.1739848-3-YiPeng.Chai@amd.com>
 <BN9PR12MB5257AD82E9E43586C082320CFC722@BN9PR12MB5257.namprd12.prod.outlook.com>
 <CH2PR12MB42155CF07B811857D84D73AAFC712@CH2PR12MB4215.namprd12.prod.outlook.com>
 <PH7PR12MB8796D3F264A2DA76C899DFE1B0712@PH7PR12MB8796.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB8796D3F264A2DA76C899DFE1B0712@PH7PR12MB8796.namprd12.prod.outlook.com>
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
x-ms-traffictypediagnostic: CH2PR12MB4215:EE_|CH2PR12MB5516:EE_
x-ms-office365-filtering-correlation-id: 0f5ee441-e5ee-4dec-0b1f-08dc17e67269
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bP4aLUR5mLug0yxWpYYGCYa+iPcfsPKQnlgh3XTu1j7gvOCOLIbJgalD8dchQyxHFnKSnPtTkBctkdX7DXZwwRn073vVcKcbim0HP6mdcbacL8kqtkUn/NHUZRh4SS7C0wVw42umUNkCnj3+zgwm7/DDhoMFKgj+pwots+EA9BU92/4us3MxYa65Il8LvhSsnKKA3OTnVZrSkAs5S+ngYIX0HIUIfD5qxmg+QdOZzUIuIaPgsm40Q4ezEho3k0vujZ5c962LHDVHuFKzRiA456eIRbgJ8Sm8l/V2gf/cHFUTEe4ZrBrsYJJVOHG+SjM6f2hDSUB8Gpth4dEJhDT+MgdNqICnIgDHYBO+CDKSYhj1aWsnPSVLw8YB4qPwI5OCa5YmdCAdG2eYmIwVy+L3tN7lmly35c2nJqBOux7cbDpSszBDHtSmNHJZTXwmvtSC7fOCpTsJaeWloypra6jezDcXzEkt0+BX/SURPtnURm4aljqkAvNfdGs2uSYo0UEP8PIY9P2YUybtIwcVOb92gW+TlonZrq78GtLQxo5lqttYX63a8xkh3TPCj+IBqiAqDkTLcC7kbMPfApS4tomT6bnkemRW2aPKCDp9mgVRqhPhv2vGRwrvbIa2BnAe8sHr
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4215.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(136003)(396003)(346002)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(55016003)(71200400001)(478600001)(6506007)(7696005)(9686003)(86362001)(26005)(122000001)(38100700002)(38070700009)(83380400001)(76116006)(4326008)(41300700001)(30864003)(33656002)(5660300002)(966005)(2906002)(8936002)(66946007)(52536014)(66556008)(110136005)(8676002)(64756008)(66476007)(66446008)(316002)(54906003)(559001)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?28HDZc/FWsTbIkYdrhVkvM0kSznv55rRkxLe8GLhSoHrUfMSUU7R71noclaQ?=
 =?us-ascii?Q?ipirlM3Xuqh4EkQbSPp0dlFGpsRmESOxiJ7hjP0aXBQddhpzsED1fy2HZpX0?=
 =?us-ascii?Q?G1mqXTQIjpJ84bw5wFxZz0iOpNugJqBf+rhyfLaHlEj+8itBCVrbpLC3mNqH?=
 =?us-ascii?Q?x1b+9eKEkVbpYM5xggb+oyuUh/fkjw7SnsbTpUQy9QYFDpSC6H/F5bwqkO1M?=
 =?us-ascii?Q?+qeXMunBS64M4vyMvY+mzWvTOnhEv/yBuSeaV3LpjeVisLqpLwJTXo0oyB4C?=
 =?us-ascii?Q?6mpckZvcSvlNIp5hSzdoMyGgxGOMjsCvrKGqmCFvX1Gb3CNlditUotGLK8UC?=
 =?us-ascii?Q?1to7hyWEH7Gzu1jzlacCuldnTfz8KexpdJ8ZP4WhUEVnz4Jk2FtU9IDQ1Mo/?=
 =?us-ascii?Q?hPc4LNSpyq1KpAB68zuooJ/R331fYar26qWHFBct85NY8mH2IYphOk94wqsO?=
 =?us-ascii?Q?srxJfWCsvvSmYjwC6/bkdNDkkmHl7qfXjQe0GM/YFtqdzd79FBUdzJswt0Gp?=
 =?us-ascii?Q?fRx5i6Pix2nqutGAs0lYNxn3/kAWy/IWf7vdY25YcX527hnDnK6RJUf7dQfM?=
 =?us-ascii?Q?uUMVnaN7rvffRFxK0MsSUcak4saeB4geDx7or/0/z7qGyIANJ+6ZG0Ye/u4M?=
 =?us-ascii?Q?OfOI3OQA7k7HSq3/eRet01uV5pIh/UM/7UmCI0yRqyhXMifAM/aJuU8G39fo?=
 =?us-ascii?Q?zt5puPXNTyte3LEGghhjDbmAZoTpD+OCaXTUV+vrTatPaSC5S2rjMXRD/2jm?=
 =?us-ascii?Q?UXq/B6A7iB7UQWzgAVcW47D+wQDAfWNp8TQtePafRTIdTJ8ITADR7QY4sNFZ?=
 =?us-ascii?Q?8FHgADsr8iv/HTdaSQSBk4wAx0mh5N7qDa0hYf5mVBLq2itnql02hIL+J0Rd?=
 =?us-ascii?Q?dknlpOHXy2+xvkl78BeRg1wq9GOiUeaq5xBvUYV06hP7jWAwMJqaLkiucyjW?=
 =?us-ascii?Q?dOliC8VRDCuLD22s/1Q16HG22F5/Y9zz4M+Pi0USsyImTJpNfnNK6NFuHkFo?=
 =?us-ascii?Q?6ZwupJjbPEXVK6aGwUU21HiKkr9QXnVm2qOkptZvRyAfCtctEFNdsURYaN2p?=
 =?us-ascii?Q?RuCDujf2J6aTvGB0iLMOo/UQfYAWSojf6fEtJhVSyQcF2mAqxOY7uoGyxywK?=
 =?us-ascii?Q?U8tURTVLMtct4Y6IgP2/o+KJBNxMPtU7D+xH28OvCPGbOSd9Q+naAW/IqaVJ?=
 =?us-ascii?Q?0/VcjcOL30Pnh0g+yhMaOERSZI+YLF9mqIzrgAfHNcZciBy+trqh3/Uw7Gk4?=
 =?us-ascii?Q?JfPuQPMo0S0aV4nJnxuXt71mhyi32+2XAg8jo6FUuthfFGg4D7ee/HhzP5vb?=
 =?us-ascii?Q?y34XX/DDppEhIbkjbMRtrcG0Uhm+eIRrDX4j7zkuNEDkJ4zoOuctb3K/A/Ne?=
 =?us-ascii?Q?bWTyPunUId7l+6sNq+6QZcNExYUQIXpZl/51A+ZpcStBkICwO/ZDc6TWJx8i?=
 =?us-ascii?Q?0NgypobMZj2s687DiEZlnQMjQeQmBxvHMdTEXQuXJshcw2UyybhstUyfAIhY?=
 =?us-ascii?Q?dRU4rURR7Qt+a/NWwAy8pKAWobZ2xe6E6Y6H7CBoU4LCPzqYxNg7Eepo92qi?=
 =?us-ascii?Q?FMNzw7n+RIz1ywiU3Nk=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CH2PR12MB42154DC81B1A7D5CDC00FB80FC712CH2PR12MB4215namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4215.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f5ee441-e5ee-4dec-0b1f-08dc17e67269
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jan 2024 05:29:30.8654 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SQXoZJn01ulDIcMzyTSKKg/c0iFHwOYBfs18uV0QOAP/pK1OjaTfA0igZVivhk/v1g5XlL5tyP89vc4BSJFwKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5516
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

--_000_CH2PR12MB42154DC81B1A7D5CDC00FB80FC712CH2PR12MB4215namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]


-----------------
Best Regards,
Thomas


_____________________________________________
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Thursday, January 18, 2024 11:24 AM
To: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking <Hawking.Zhang@amd.c=
om>; amd-gfx@lists.freedesktop.org
Cc: Li, Candice <Candice.Li@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd=
.com>; Yang, Stanley <Stanley.Yang@amd.com>
Subject: RE: [PATCH 3/5] drm/amdgpu: Use asynchronous polling to handle umc=
_v12_0 poisoning


[AMD Official Use Only - General]





      _____________________________________________
      From: Chai, Thomas <YiPeng.Chai@amd.com<mailto:YiPeng.Chai@amd.com>>
      Sent: Thursday, January 18, 2024 11:06 AM
      To: Zhang, Hawking <Hawking.Zhang@amd.com<mailto:Hawking.Zhang@amd.co=
m>>; amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
      Cc: Zhou1, Tao <Tao.Zhou1@amd.com<mailto:Tao.Zhou1@amd.com>>; Li, Can=
dice <Candice.Li@amd.com<mailto:Candice.Li@amd.com>>; Wang, Yang(Kevin) <Ke=
vinYang.Wang@amd.com<mailto:KevinYang.Wang@amd.com>>; Yang, Stanley <Stanle=
y.Yang@amd.com<mailto:Stanley.Yang@amd.com>>
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
      > [thomas] This "gpu reset" code is not belong to page retirement ran=
ge,  but reuse old code.  About how to reset gpu, we can do it with  anothe=
r patch in  future.

               >[Tao] in fact, the condition "if (!entry)" is for poison mo=
de. If poison isn't supported, only umc ue error needs page retirement, it =
will be called in related cb interface and the entry would not be null.

        [thomas] "if (!entry)" is useful for the umc version less than v12 =
in  umc poison handler.


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


--_000_CH2PR12MB42154DC81B1A7D5CDC00FB80FC712CH2PR12MB4215namp_
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
<a name=3D"_MailEndCompose"></a>
<div><font face=3D"DengXian" size=3D"2"><span style=3D"font-size:11pt;">&nb=
sp;</span></font></div>
<div><font face=3D"DengXian" size=3D"2"><span style=3D"font-size:11pt;">&nb=
sp;</span></font></div>
<div><font face=3D"Times New Roman" size=3D"2"><span style=3D"font-size:11p=
t;">&nbsp;</span></font></div>
<div><font face=3D"DengXian" size=3D"2"><span style=3D"font-size:11pt;">---=
--------------</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Best=
 Regards,</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">Thom=
as</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;</span></font></div>
<div><font face=3D"Times New Roman" size=3D"2"><span style=3D"font-size:11p=
t;">&nbsp;</span></font></div>
<div><font face=3D"DengXian" size=3D"2"><span style=3D"font-size:11pt;">___=
__________________________________________<br>

<b>From:</b> Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt; <br>

<b>Sent:</b> Thursday, January 18, 2024 11:24 AM<br>

<b>To:</b> Chai, Thomas &lt;YiPeng.Chai@amd.com&gt;; Zhang, Hawking &lt;Haw=
king.Zhang@amd.com&gt;; amd-gfx@lists.freedesktop.org<br>

<b>Cc:</b> Li, Candice &lt;Candice.Li@amd.com&gt;; Wang, Yang(Kevin) &lt;Ke=
vinYang.Wang@amd.com&gt;; Yang, Stanley &lt;Stanley.Yang@amd.com&gt;<br>

<b>Subject:</b> RE: [PATCH 3/5] drm/amdgpu: Use asynchronous polling to han=
dle umc_v12_0 poisoning</span></font></div>
<div><font face=3D"Times New Roman" size=3D"2"><span style=3D"font-size:11p=
t;">&nbsp;</span></font></div>
<div><font face=3D"Times New Roman" size=3D"2"><span style=3D"font-size:11p=
t;">&nbsp;</span></font></div>
<div style=3D"padding-right:5pt;padding-left:5pt;"><font face=3D"Arial" col=
or=3D"blue">[AMD Official Use Only - General]<br>

</font></div>
<div><font face=3D"Times New Roman" size=3D"2"><span style=3D"font-size:11p=
t;"><br>

</span></font></div>
<div><font face=3D"Times New Roman" size=3D"2"><span style=3D"font-size:11p=
t;">&nbsp;</span></font></div>
<div><font face=3D"Times New Roman" size=3D"2"><span style=3D"font-size:11p=
t;">&nbsp;</span></font></div>
<div style=3D"padding-left:36pt;"><font face=3D"DengXian" size=3D"2"><span =
style=3D"font-size:11pt;">_____________________________________________<br>

<b>From:</b> Chai, Thomas &lt;<a href=3D"mailto:YiPeng.Chai@amd.com"><font =
color=3D"#0563C1"><u>YiPeng.Chai@amd.com</u></font></a>&gt;
<br>

<b>Sent:</b> Thursday, January 18, 2024 11:06 AM<br>

<b>To:</b> Zhang, Hawking &lt;<a href=3D"mailto:Hawking.Zhang@amd.com"><fon=
t color=3D"#0563C1"><u>Hawking.Zhang@amd.com</u></font></a>&gt;; <a href=3D=
"mailto:amd-gfx@lists.freedesktop.org"><font color=3D"#0563C1"><u>amd-gfx@l=
ists.freedesktop.org</u></font></a><br>

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
tyle=3D"font-size:11pt;">&gt; [thomas] This &#8220;gpu reset&#8221; code is=
 not belong to page retirement range,&nbsp; but reuse old code.&nbsp; About=
 how to reset gpu, we can do it with&nbsp; another patch in&nbsp; future.</=
span></font></div>
<div><font face=3D"Times New Roman" size=3D"2"><span style=3D"font-size:11p=
t;">&nbsp;</span></font></div>
<div><font face=3D"Calibri" size=3D"2"><span style=3D"font-size:11pt;">&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; &gt;[Tao] in fact, the condition &#8220;if (!entry)&#8221; is for poi=
son mode. If poison isn&#8217;t supported, only umc ue error needs page ret=
irement, it will be called in related cb interface and
the entry would not be null.</span></font></div>
<div><font face=3D"Times New Roman" size=3D"2"><span style=3D"font-size:11p=
t;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </span></font></div>
<div><font face=3D"Times New Roman" size=3D"2"><span style=3D"font-size:11p=
t;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <font face=3D"Calibri">[thom=
as] </font><font face=3D"Calibri">&#8220;</font><font face=3D"Calibri">if (=
!entry)</font><font face=3D"Calibri">&#8221;</font><font face=3D"Calibri"> =
is useful f</font><font face=3D"Calibri">or
the umc version less than v12</font><font face=3D"Calibri"> in&nbsp; umc po=
ison handler.</font><font face=3D"Calibri">&nbsp; </font></span></font></di=
v>
<div><font face=3D"Times New Roman" size=3D"2"><span style=3D"font-size:11p=
t;">&nbsp;</span></font></div>
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

--_000_CH2PR12MB42154DC81B1A7D5CDC00FB80FC712CH2PR12MB4215namp_--
