Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F36D3C47082
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 14:29:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B164B61028
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 14:29:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B164B61028
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B91F6E167;
	Wed, 26 May 2021 14:29:20 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C6536E167
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 14:29:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IISjlIAqU4TBK6GmJfW4JDmfPl5uFNG42//CIsha+bZa2HVHfdDjx8MMYtOJ1YqKozO/79ZTgwaUkMl58mx2Xqemd7iue0jx3hDy0+IYNRef2pVzeQGrsxlTRZAGh+pQYRwcLdrObWRFzE/kX6lFFW92pCMLVthbjTbjVLhR54zTfw1sHjn4webGX+yhPsOGg1eYHVRlwNjZ/iDvujZIb31f0SI2vTsLV6JAEbD/HNdpZ3wVHRnqDq5+ZhrdwxcPJ/3bneH7/POjZkV878pgaupjJPyCWXy5r34Sh0jv6SlTEQGfw1leGIaR8cU6ZeT+ZSpDz2bE+1D6OW8/j/Kvfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8zSzwnA9SD0WKNS/qYaER7gRVvK2AcnM9hNIXnhzmpk=;
 b=SWfBLpKGFJcrt0g685N8n/O9E20GnLmBFM3lx0sFAaGLJVbNpbvBYiIztH/TXDdAL6dyjuMVcz9Swy20FtoGTVsO+KX6PKVlJIfZENmdVcZs8qnO5UbpN7PqzPUrr0zOocIc+02cbT2eIJy5feo8wJ81WvTyGEmIdL4dGt6qKitiizcfcZr0drkb+e2CDAgv5fOLRFgoYDsoBjNhAyWDrOBVf/MqLBu0wae6ZPIEaRsrJPwG3tq3LL50vYAMokJuMblikuxV0yZ8qB9lCak+5w6NSEf/dG+/gXIplAWB/XH9Q6WPZmJzneppC2R7oypFfB1kHdB6Fg6wH7SI/EYoAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8zSzwnA9SD0WKNS/qYaER7gRVvK2AcnM9hNIXnhzmpk=;
 b=hJutwMc3z0dN52jtnPrOYSdWUHBMc7Yx1xlS89z4mCJAcvtEs+i9h/1Yca66Vm7Pf1AuM83zX0Mq+M6f+gpH67gX9c++U1+gqTD43jDWeYSSyIHzhWv3/6/a4j/tD5uftzwjX6NDeoJtT2SUFdBskEH7shoTVd4u2m5ZTBYyJOo=
Received: from DM6PR12MB3529.namprd12.prod.outlook.com (2603:10b6:5:15d::18)
 by DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Wed, 26 May
 2021 14:29:18 +0000
Received: from DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::ec3f:1d46:bab5:bf57]) by DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::ec3f:1d46:bab5:bf57%7]) with mapi id 15.20.4150.027; Wed, 26 May 2021
 14:29:18 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Zhuo, Qingqing" <Qingqing.Zhuo@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 00/15] DC Patches May 24th, 2021
Thread-Topic: [PATCH 00/15] DC Patches May 24th, 2021
Thread-Index: AQHXTmfpxtgku0IP1EmeH6ugMQi1P6r12fXQ
Date: Wed, 26 May 2021 14:29:17 +0000
Message-ID: <DM6PR12MB3529D78473FEA07357A10AC09C249@DM6PR12MB3529.namprd12.prod.outlook.com>
References: <20210521173646.1140586-1-qingqing.zhuo@amd.com>
In-Reply-To: <20210521173646.1140586-1-qingqing.zhuo@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-05-26T14:29:15Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=e838b9b3-0e7a-4683-91fe-23a2195456dc;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [174.95.34.193]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7ed2e82a-3f81-49d0-8a93-08d92052a52d
x-ms-traffictypediagnostic: DM6PR12MB4202:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB4202451433A615BAA64B3AC19C249@DM6PR12MB4202.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iyP7JknGNCp1MafO6xOyjvEZHGfNE5hgNS/UiDrcj8+dV6pLVJSDA6RZfW4tK3evctjGQigumkZ6Zy0H8q+QtjyKRJlOWjkoLAj6pUaXg5SW84f57083Ncb1tVPlcO92eJ7l47g4OEtOUQAP+aXXBKgTCIF5LL3p/E5AdWemDQaUdNb3NEMCWJH5YcuuSzoD7yhF726d+RJ5SuzoHyJr7FVRzGxUXuzhGL2RFycf5iQPZL8pV2Qb3Vm0nccgI8JdGEf6M01KiwuW/NQm5WiLqqXsyeTIt8cbp1Mm45zeeHc7x3VCM/0yCkF/gJGVzXLJ9j1KVIgjN7zT6vLF6emDlUC9RGbi/zMwKHLyZTHAq0xKBleCdocSE64l+gkGoAWX2v2nKKgLB5sdu0o/Z/FrqIgbR9RKFyPU4NqRboaLFPB3qVv1zSLce44UFSrInB0bWLok7WRa9wvmguufTvKwqNyXuguDLa2F6yk+EEAp8BVhReazexodYReYyzqy923tW4w4M7T+aUfSMms++ERjqmFMYwxL1b7NPWnQWz3jLmzJSdRQoqT9mrdOZ4mbM1eKi7lDhSKA5rn3XQZF0Vys0bS85jg4+Df+1vhd+xg/6e0FQhTRe7jA1jD9w4VFD0Y/MdnaUwA6IF44Vm+gOdeU0w==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3529.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(39850400004)(346002)(396003)(366004)(71200400001)(186003)(66446008)(64756008)(66556008)(76116006)(66946007)(110136005)(54906003)(316002)(7696005)(66476007)(966005)(52536014)(38100700002)(2906002)(86362001)(6506007)(53546011)(122000001)(55016002)(5660300002)(45080400002)(26005)(9686003)(478600001)(4326008)(33656002)(83380400001)(8676002)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?bhsjqK+eM1iY7FJuxbY2hA2mnCuYJFrRIvhMSSsU4lBCVFbHyV12AqeQO5?=
 =?iso-8859-1?Q?uW0y6TSVk3nASSM0TdKSulEvPjqCrlMDWMD+lcc/QiS3QMvtSsYfcgmJjo?=
 =?iso-8859-1?Q?k+Wak8gnsZmd12ByEgiATbIIlpDTI942w9mkl8n8AuzCFRSr+TvcN76q4Z?=
 =?iso-8859-1?Q?3wtuXhuR0U1Rgbus65PSav6XYR74BrV21tjaMWTZeWKmo9OYF9haeeQx0N?=
 =?iso-8859-1?Q?fW4TBnQdStmXitcibrUTZnmfrtfT9nIlTpIgP0dtC6Z8HfpaENxlJqQF7V?=
 =?iso-8859-1?Q?rEdgrpdhYeV1yj4i44hTrisqUaeDW1fWRJem3o2Goif9j7ESqSNGqKkAnQ?=
 =?iso-8859-1?Q?CvKaMK40gegm8ohJI6lwpvmBrD+OOt6u1LNZG0btL2zyqoyi9Mm20Lq7wf?=
 =?iso-8859-1?Q?ZX571dYjRnVr7ZGex2JmM9uIKlDz3KmJiQ7Y6EycUNDlrM6AfDaxAeIgXr?=
 =?iso-8859-1?Q?/fzctstPPNLvd9p+Vu0IblC61YmBKII7dkk9/zApLwS4r/q9n0SS4J3l+L?=
 =?iso-8859-1?Q?xs2gBKze+U4UkFJ/SBHZ/6YqaF0cC6fBdPWLH4y85CoZMIeIlfLon8LnR5?=
 =?iso-8859-1?Q?S4XgP9y+wntIk757J8bp7TRrTLlgwvVa6bmwzPzzrZ7T0KYAqebyQo3uIN?=
 =?iso-8859-1?Q?rX72tvKtBvmy/cpGcDMguo8zZY2VOioO/6skbNXAL/uBNOaQye28boeBMk?=
 =?iso-8859-1?Q?Goi/S2kzL+A9IChH2NwiCoAynRZyPOUcnnT6Iu/wWn3aNClpgmOI8TgjSs?=
 =?iso-8859-1?Q?nim//F0mx+F+m4+rOl9XkHdAI/Mh7+Mbb2c771ov69XGZZq/bLxQ/H/V4/?=
 =?iso-8859-1?Q?PFbyp0vFOO1rl8jNN917OrYXEwCGJWSHSE/WGPIFgRl+ZnRk8SqmMN+kYN?=
 =?iso-8859-1?Q?ZKiQeJzHm2L/oqa/0b+NYptCiKeItonxEJDXRuoUaXlVS65op7KJYH5qS4?=
 =?iso-8859-1?Q?8khhklRWh9Njdt4kkNQ95UXpLVRzxD2Rq2x3aMzfom1rDBwdXJZdpsh7Rt?=
 =?iso-8859-1?Q?7rUwK9Ps6oKZRQpLABN+0u/AaI4qxUL7UY8xrqzpCArz3LDit0qk3eRdnz?=
 =?iso-8859-1?Q?ss7Nbgu1w5WULxx1/AflasD6ijvhd2pQV9aNISDKLAOovf+UW6iv9kFNTb?=
 =?iso-8859-1?Q?vMRK/U6w8YT8mE44Wyk55miWIGYhJpYMD7JjITmYh4Fu4hLe1VdSErNVH9?=
 =?iso-8859-1?Q?IjmGn5oy6/qjcofDkqYLxRyBiaupKrGvaw6bd13GOfMAOlHWat/IJdfIU2?=
 =?iso-8859-1?Q?+Acy8xtnRPKOS7EiH+xEvRHk5uFMfhxoAF/DdGZLjLDtRYD495k/xhdBk6?=
 =?iso-8859-1?Q?Cz6pQ+O0wcIJoq7pMJQf/AkQFDht/Hd+kLplGRs6afQeKY8=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3529.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ed2e82a-3f81-49d0-8a93-08d92052a52d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2021 14:29:17.7209 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gcBDYjsYSxrTimflcRZGXeJIJYInHGPUp6vrrSvUdAQAqlvwC60QbbT08ukSVzNthDOjzZBSRnog83SyiD2urg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4202
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
Cc: "Brol, Eryk" <Eryk.Brol@amd.com>, "Li,
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Zhuo, 
 Qingqing" <Qingqing.Zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li, Roman" <Roman.Li@amd.com>, "Jacob,
 Anson" <Anson.Jacob@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
 "Wentland, Harry" <Harry.Wentland@amd.com>, "R, Bindu" <Bindu.R@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Done.

Hi all,
=A0
This week this patchset was tested on the following systems:

HP Envy 360, with Ryzen 5 4500U, on the following display types: eDP 1080p =
60hz, 4k 60hz  (via USB-C to DP/HDMI), 1440p 144hz (via USB-C to DP/HDMI), =
1680*1050 60hz (via USB-C to DP and then DP to DVI/VGA)
=A0
Sapphire Pulse RX5700XT on the following display types:
4k 60hz  (via DP/HDMI), 1440p 144hz (via DP/HDMI), 1680*1050 60hz (via DP t=
o DVI/VGA)
=A0
Reference AMD RX6800 on the following display types:
4k 60hz  (via DP/HDMI and USB-C to DP/HDMI), 1440p 144hz (via USB-C to DP/H=
DMI and USB-C to DP/HDMI), 1680*1050 60hz (via DP to DVI/VGA)
=A0
Included testing using a Startech DP 1.4 MST hub at 2x 4k 60hz, and 3x 1080=
p 60hz on all systems.
=A0
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>

=A0
Thank you,
=A0
Dan Wheeler
Technologist  |  AMD
SW Display
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
Facebook=A0|=A0=A0Twitter=A0|=A0=A0amd.com=A0=A0


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Qingqing=
 Zhuo
Sent: May 21, 2021 1:37 PM
To: amd-gfx@lists.freedesktop.org
Cc: Brol, Eryk <Eryk.Brol@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>=
; Wentland, Harry <Harry.Wentland@amd.com>; Zhuo, Qingqing <Qingqing.Zhuo@a=
md.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Li, Roman <Roman.Li@=
amd.com>; Jacob, Anson <Anson.Jacob@amd.com>; Pillai, Aurabindo <Aurabindo.=
Pillai@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; R, Bindu <=
Bindu.R@amd.com>
Subject: [PATCH 00/15] DC Patches May 24th, 2021

This DC patchset brings improvements in multiple areas.
In summary, we highlight:
    =

  - DC 3.2.137
  - Updates on DP configurations and clock recovery API
  - Improvements on DSC, link training sequence, etc.
  - Fixes on memory leak, ODM scaling, etc.

---

Alvin Lee (1):
  drm/amd/display: Implement INBOX0 usage in driver

Aric Cyr (1):
  drm/amd/display: 3.2.137

Dmytro Laktyushkin (1):
  drm/amd/display: fix odm scaling

Fangzhi Zuo (3):
  drm/amd/display: Retrieve DSC Branch Decoder Caps
  drm/amd/display: Add Log for SST DSC Determination Policy
  drm/amd/display: Refactor SST DSC Determination Policy

Jake Wang (1):
  drm/amd/display: Added support for individual control for multiple
    back-light instances.

Jimmy Kizito (2):
  drm/amd/display: Update DP link configuration.
  drm/amd/display: Expand DP module clock recovery API.

Qingqing Zhuo (1):
  Revert "drm/amd/display: Refactor and add visual confirm for HW Flip
    Queue"

Roman Li (2):
  drm/amd/display: Remove redundant safeguards for dmub-srv destroy()
  drm/amd/display: Fix potential memory leak in DMUB hw_init

Wenjing Liu (2):
  drm/amd/display: add exit training mode and update channel coding in
    LT
  drm/amd/display: isolate 8b 10b link training sequence into its own
    function

hvanzyll (1):
  drm/amd/display: disable desktop VRR when using older flip model

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 138 +++--
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  10 +-
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 307 ++++++----  .../gpu/dr=
m/amd/display/dc/core/dc_resource.c | 568 +++++++-----------
 drivers/gpu/drm/amd/display/dc/dc.h           |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |   9 +
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |   2 +
 drivers/gpu/drm/amd/display/dc/dc_link.h      |  19 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   3 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   5 -
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c |  10 +-
 .../drm/amd/display/dc/dce/dmub_hw_lock_mgr.c |   8 +
 .../drm/amd/display/dc/dce/dmub_hw_lock_mgr.h |   3 +
 .../drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c |  12 +-  .../amd/display/dc=
/dcn10/dcn10_hw_sequencer.c |  31 +-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.h |   6 -
 .../gpu/drm/amd/display/dc/dcn10/dcn10_init.c |   1 -
 .../gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c  |   5 -
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  28 +-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.h    |   5 -
 .../gpu/drm/amd/display/dc/dcn20/dcn20_init.c |   1 -
 .../gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c  |   2 +-
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |  14 +-
 .../gpu/drm/amd/display/dc/dcn21/dcn21_init.c |   1 -
 .../gpu/drm/amd/display/dc/dcn30/dcn30_init.c |   1 -
 .../gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c  |   2 +-
 .../drm/amd/display/dc/dcn301/dcn301_init.c   |   1 -
 .../amd/display/dc/dml/display_mode_structs.h |   2 +
 .../drm/amd/display/dc/dml/display_mode_vba.c |  13 +
 .../gpu/drm/amd/display/dc/inc/dc_link_dp.h   |  66 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/abm.h   |   3 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h   |   3 -
 .../gpu/drm/amd/display/dc/inc/hw/transform.h |   4 -
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |   4 -
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |   1 +
 .../amd/display/include/link_service_types.h  |   1 +
 .../amd/display/modules/freesync/freesync.c   |  29 +-
 .../amd/display/modules/power/power_helpers.c |  15 +-
 .../amd/display/modules/power/power_helpers.h |   3 +-
 39 files changed, 683 insertions(+), 655 deletions(-)

--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Cdaniel.w=
heeler%40amd.com%7C6b3d610e300c439f21d008d91c7f0ac7%7C3dd8961fe4884e608e11a=
82d994e183d%7C0%7C0%7C637572154238801749%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC=
4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=
=3D1Z3LozxAwTip83McN0wJtTVSVHgBJR6HhN87KMjMqnU%3D&amp;reserved=3D0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
