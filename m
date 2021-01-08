Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA7BC433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 22:52:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 071A723A80
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 22:52:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 071A723A80
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 947206E187;
	Fri,  8 Jan 2021 22:52:06 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC0276E187
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jan 2021 22:52:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y3Ewo5qP5HjlPjBZ+UFWLWb4uUOBCfsY53fvZ028qidX+0/MwofyDHk/U6lnl4riAE1giK5uVyVrerF9oXD7WkKWrbSNpekvt+TAA5WM0WqWFaZIDVYN3CO8aNNB6zl+baOBV0w+7toCsLfbyELGzOdn72PY/xrYVxyQ59PtgJHoi6pn68AQMN3NUawLY6GY7lSuICzRU1E5yKzjFl9tYQVDitIRJPJfiUPSYvd43m7C56TmwaogfZlOqNt89M1fbEVR3OP+9jpIw0IcYNCnrdRaNOfPiV2VbAcwJC546G1QdGQh3irokliHlsjnS7ODXrLS8l3qL4KlzDY/aXglrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7x15liBabjEVV0g+Q/kiTzym9H7bORHGqeE3lHFWPw=;
 b=GpDmTc6N4OpARN4U846F81xrs6SQkFjAnL+CAd0hPzJaNk3rshu16CrfZJRqwSE/HGzAG/5WpedLflMTAh2bTQKFXAOsfR7gfq1ssudSyXL/65rKUFDzLR6gPGra27gwQv81zelsaxqEmFuJz06ZsNhT6ewk9pGFSrE587zCIT/TjOWnEOolFrZR/HG3n09bLevf/l8kiccQI/bgkI5yciNdNvTFlzEUguRJXkIZZbZ26s1npR5lycg4mDeM4xFrGk5oHKP9KyhcaCKTOWFOYJxKxBtj4GlYNl5FKyT6sfZZOUfvfTZSdGN6b7/yAlHnuC1xzdgJq1zqGIJfEGPLJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7x15liBabjEVV0g+Q/kiTzym9H7bORHGqeE3lHFWPw=;
 b=pseM27ZdSVJrcsnvoqqcPZX/BFu+l+kJjxM/62abO4/bqhhryCECRUW6xr/4NJAjgfh0ORs3uHc5rfqmpxaILwoFYcucFvPQ5ngJg6TRQrLVzuP3eq8Fcx28+VHGk7nJyeBK9HK9NSkumri4ow8XGEDKUox+HIkbnfdvXmKDP3M=
Received: from BN7PR12MB2833.namprd12.prod.outlook.com (2603:10b6:408:27::14)
 by BN8PR12MB3073.namprd12.prod.outlook.com (2603:10b6:408:66::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Fri, 8 Jan
 2021 22:52:02 +0000
Received: from BN7PR12MB2833.namprd12.prod.outlook.com
 ([fe80::bd76:59f1:7d81:1f7c]) by BN7PR12MB2833.namprd12.prod.outlook.com
 ([fe80::bd76:59f1:7d81:1f7c%6]) with mapi id 15.20.3721.024; Fri, 8 Jan 2021
 22:52:02 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 00/21] DC Patches January 08, 2021
Thread-Topic: [PATCH 00/21] DC Patches January 08, 2021
Thread-Index: AQHW5ghQkQDSpJAi/0W+QmggrY3hyKoeSomAgAAFqAA=
Date: Fri, 8 Jan 2021 22:52:02 +0000
Message-ID: <BN7PR12MB2833C12CD30A6191C77B5EFC9CAE0@BN7PR12MB2833.namprd12.prod.outlook.com>
References: <20210108215007.851249-1-Rodrigo.Siqueira@amd.com>
 <20210108221207.i5olrzm2ip4bdbbn@outlook.office365.com>
In-Reply-To: <20210108221207.i5olrzm2ip4bdbbn@outlook.office365.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-01-08T22:32:25Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=0b924272-3b14-4b0a-af14-00009cd2041f;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
dlp-product: dlpe-windows
dlp-version: 11.5.0.60
dlp-reaction: no-action
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_enabled: true
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_setdate: 2021-01-08T22:51:59Z
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_method: Privileged
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_name: Public_0
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_actionid: f8ffabc1-dc3f-474a-aa53-00005b44171c
msip_label_0d814d60-469d-470c-8cb0-58434e2bf457_contentbits: 0
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [24.235.164.84]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f317bf22-8a94-4d70-5572-08d8b428038b
x-ms-traffictypediagnostic: BN8PR12MB3073:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR12MB3073F01647937ADE5CCBE1239CAE0@BN8PR12MB3073.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YlKZTfnB8yybGi3/siEM0ZzLlUR0CLA9WUC6fbwXRnvXOZLvFoefC8bJ8zDF1KNQFG0o+350JhutVpHlYBEN1FnSWpYE8eImv44sLFKQNNgUfAprlD6wl/mDi7GhBpY6cvRky08r1G8FnVJB1kgPyB/PGCDfaUp2JWN8tY3goQqDtiwQ32gcF9L5Xv/qYWyPyNwFNsUEUlqVtkilwfMdWrfqeREiYEFutbwPmZ7n43J6sPL0hCSFDs2oRzdN4vboX1qclCIIbrtsm/9tCCGi+o+Mvcdwb56KHcJrTnhU4Z35/uWbHbqqEecTRG9M7Xr4JY1L1fUi34YbY0v+f7whGHBcaMILTVHiaiGfadWix6JQ4zsMwKy0nuZYuJfwFDUb4xH1rj6FsFd7PXdia2NtNViD2Z4RQQJ1lobPSq6ab9Msse8ES+/z+huUlEMrYo3086L9teMYjvz95H3OcAGkGQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR12MB2833.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(366004)(346002)(396003)(39860400002)(33656002)(9686003)(186003)(110136005)(316002)(66556008)(26005)(8676002)(8936002)(83380400001)(5660300002)(86362001)(4326008)(54906003)(76116006)(2906002)(66946007)(66446008)(478600001)(64756008)(71200400001)(66476007)(52536014)(6506007)(53546011)(55016002)(7696005)(966005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?zBDYNQ9lJ0leNWzJg0LCV+V27KlO2LoBei6o58O774us7U2XYGD50mvsfk?=
 =?iso-8859-1?Q?3zyzLZipqzJpniBAtJuPhBnDC10rVUOoQumONPfm93XXEKneQPI9LJrn62?=
 =?iso-8859-1?Q?YcGQ88h+umyrqDh89tBOmoylagKe88r8992NILYZP6NrPGuNwN8BCjcjX6?=
 =?iso-8859-1?Q?mBSiXlusMYVm6vEoxh7orLG5whtCVUqC0wM0mZorytYCPSAv+xiacaiqOP?=
 =?iso-8859-1?Q?kyrJlnVTXIC52p389Z1cMjQ5gZESmKPhYShrIqJqbSMKHr0lP3ig7dLSpp?=
 =?iso-8859-1?Q?1hLWKZe3QPdUYnveWIkIWAc5K7NV9K8fw5swxCPuz9ZqytJnC2HiUHRbyx?=
 =?iso-8859-1?Q?sQZldN+psTS/rJAq0OV16xFQKvSdHaIRZ3W1PBAJ9oh4VhB901JJdu7eF6?=
 =?iso-8859-1?Q?z+le3+v1N4VLKm/2RZ0kFshiNds9sGezIP9PVqN5iKz5hIom5cfb6uggDV?=
 =?iso-8859-1?Q?9OWT01qHu5f/gi0sZ+Rt2lB9oBsFnnp/UH1iCbfxd3nDXOnUjknmy/ENwn?=
 =?iso-8859-1?Q?J6tP6j1X6OCJ+4W+rqzCXKhMaz2ZmjmSxpTwAZFlXk2HhSl/p8N9JmblEB?=
 =?iso-8859-1?Q?gW5UzbeCGV8ed3t4v8ZoH9AySL+BLL8zBTiB+CTeT4AY8oKXDZP9VqgXgW?=
 =?iso-8859-1?Q?CHRkkeFR6PGlnZUNtNauuZnnNK46PFVjho5aEiR7PWgbs7Flkt6xXxWuDQ?=
 =?iso-8859-1?Q?2PAJAIrTOQ1ZNVakwllXn0D0S7lZz+J4gEV16vqJzCk/ZCJ7fAzoAEOjZw?=
 =?iso-8859-1?Q?BsBhfAjsq2yv4K4E4VhBlsrOan8ELfrWTUaC8zQ+tWiAoYLqWdO/maIlDz?=
 =?iso-8859-1?Q?JRRNIfklBUS6I0PdGYbkg/F5ibJeYRSyfvGWPoulzycCwv0fF61Lm3RYkb?=
 =?iso-8859-1?Q?7HjG8UGHDz+axi4PEIHWEfX3HW+EaqsoT89h+cVyigJfxkfCD5sSwDRh5q?=
 =?iso-8859-1?Q?l+9tjDPEMnw/T1eVG/OgEY4G9cb2bP4XBcKbLsNcjnhAoNNYuZAUrDUjVY?=
 =?iso-8859-1?Q?m0C8aQbCoTRiVe+PI=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR12MB2833.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f317bf22-8a94-4d70-5572-08d8b428038b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2021 22:52:02.2750 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qSRLq/PVoswpvfzebd7FJ7JjH8GyD//1nWt4795Bkq1W49ZXgGtp6AoCQnpBguuHCLTrdPRdqstAZKykzEfCfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3073
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
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Zhuo, Qingqing" <Qingqing.Zhuo@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
 "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "R, Bindu" <Bindu.R@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Hi all,

Ran the promotion test this week on Navi14 and a Renoir laptop (HP Envy 360=
 with Ryzen 5 4500U). Tested the laptop with it's internal 1080p display an=
d externally with USB-C to DP and HDMI to 2x 4k60 displays and 1x 1440p 144=
hz display. Also tested using an MST hub with 2x 4k30. I found nothing caus=
ing any visual impact, and did notice that this promotion did fix some prev=
ious bugs that I had seen.

Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>

Thank you,

Dan Wheeler
Technologist=A0=A0|=A0=A0AMD
SW Display

-----Original Message-----
From: Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com> =

Sent: Friday, January 8, 2021 5:12 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Pillai, Aurabin=
do <Aurabindo.Pillai@amd.com>; Zhuo, Qingqing <Qingqing.Zhuo@amd.com>; Brol=
, Eryk <Eryk.Brol@amd.com>; R, Bindu <Bindu.R@amd.com>; Li, Roman <Roman.Li=
@amd.com>; Wheeler, Daniel <Daniel.Wheeler@amd.com>
Subject: Re: [PATCH 00/21] DC Patches January 08, 2021

+Daniel

On 01/08, Rodrigo Siqueira wrote:
> Happy new year, this is the first code promotion of the year; for this =

> reason, most of the changes are related to fixes.
> =

> This DC patchset brings improvements in multiple areas. In summary, we ha=
ve:
> * Multiple fixes and code refactoring.
> * Updates on HUBP operations
> =

> Best Regards
> =

> Aric Cyr (2):
>   drm/amd/display: 3.2.117
>   drm/amd/display: 3.2.118
> =

> Bhawanpreet Lakha (1):
>   drm/amd/display: enable HUBP blank behaviour
> =

> Charlene Liu (1):
>   drm/amd/display: change SMU repsonse timeout to 2s
> =

> Chiawen Huang (1):
>   drm/amd/display: removed unnecessary check when dpp clock increasing
> =

> Jacky Liao (1):
>   drm/amd/display: Fix assert being hit with GAMCOR memory shut down
> =

> Jun Lei (1):
>   drm/amd/display: implement T12 compliance
> =

> Lewis Huang (1):
>   drm/amd/display: Separate fec debug flag and monitor patch
> =

> Li, Roman (1):
>   drm/amd/display: disable dcn10 pipe split by default
> =

> Mike Hsieh (1):
>   drm/amd/display: Remove unused P010 debug flag
> =

> Nikola Cornij (1):
>   drm/amd/display: Add a missing DCN3.01 API mapping
> =

> Qingqing Zhuo (1):
>   drm/amd/display: NULL pointer hang
> =

> Raymond Yang (1):
>   drm/amd/display: fix seamless boot stream adding algorithm
> =

> Stylon Wang (1):
>   drm/amd/display: Revert patch causing black screen
> =

> Wesley Chalmers (6):
>   drm/amd/display: Initialize stack variable
>   drm/amd/display: HUBP_IN_BLANK for DCN30
>   drm/amd/display: Remove HUBP_DISABLE from default
>   drm/amd/display: Unblank hubp based on plane visibility
>   drm/amd/display: New path for enabling DPG
>   drm/amd/display: New sequence for HUBP blank
> =

> Yu-ting Shen (1):
>   drm/amd/display: doesn't reprogram AMD OUI
> =

>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  1 -  =

> .../gpu/drm/amd/display/dc/basics/dc_common.c | 20 ++++--  =

> .../gpu/drm/amd/display/dc/basics/dc_common.h |  4 +-  =

> .../display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c  |  3 +-
>  .../display/dc/clk_mgr/dcn301/dcn301_smu.c    |  2 +-
>  drivers/gpu/drm/amd/display/dc/core/dc.c      | 12 ++++
>  drivers/gpu/drm/amd/display/dc/core/dc_link.c | 31 ++++++--  =

> .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 49 +++++++++----  =

> .../gpu/drm/amd/display/dc/core/dc_resource.c | 28 +++++---
>  drivers/gpu/drm/amd/display/dc/dc.h           |  3 +-
>  drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |  3 +
>  drivers/gpu/drm/amd/display/dc/dc_link.h      |  8 +++
>  drivers/gpu/drm/amd/display/dc/dc_stream.h    | 11 +++
>  .../display/dc/dce110/dce110_hw_sequencer.c   | 31 ++++++++
>  .../gpu/drm/amd/display/dc/dcn10/dcn10_hubp.h |  2 +-  =

> .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 36 ++++++++--  =

> .../amd/display/dc/dcn10/dcn10_hw_sequencer.h |  5 ++  =

> .../gpu/drm/amd/display/dc/dcn10/dcn10_init.c |  1 +  =

> .../gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c  |  2 +-  =

> .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.c | 11 +++  =

> .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.h |  1 +  =

> .../drm/amd/display/dc/dcn10/dcn10_resource.c |  4 +-  =

> .../gpu/drm/amd/display/dc/dcn20/dcn20_hubp.h | 22 ++++--
>  .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    | 12 +++-
>  .../gpu/drm/amd/display/dc/dcn20/dcn20_init.c |  1 +  =

> .../gpu/drm/amd/display/dc/dcn21/dcn21_init.c |  1 +
>  .../drm/amd/display/dc/dcn30/dcn30_dpp_cm.c   |  7 --
>  .../gpu/drm/amd/display/dc/dcn30/dcn30_hubp.h |  1 +
>  .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    | 70 ++++++++++++++++++-
>  .../drm/amd/display/dc/dcn30/dcn30_hwseq.h    |  4 ++
>  .../gpu/drm/amd/display/dc/dcn30/dcn30_init.c |  2 +  =

> .../gpu/drm/amd/display/dc/dcn30/dcn30_optc.c |  1 +
>  .../drm/amd/display/dc/dcn301/dcn301_init.c   |  1 +
>  .../amd/display/dc/dcn301/dcn301_resource.c   |  1 +
>  .../dc/dml/dcn30/display_mode_vba_30.c        |  2 +-
>  .../gpu/drm/amd/display/dc/inc/core_types.h   |  1 +
>  .../amd/display/dc/inc/hw/timing_generator.h  |  1 +  =

> .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |  5 ++
>  38 files changed, 332 insertions(+), 68 deletions(-)
> =

> --
> 2.25.1
> =


-- =

Rodrigo Siqueira
https://siqueira.tech
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
