Return-Path: <SRS0=jKCf=HV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA53BC433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Feb 2021 22:29:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58C7A64DA1
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Feb 2021 22:29:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58C7A64DA1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 057F46EC3F;
	Fri, 19 Feb 2021 22:29:43 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700070.outbound.protection.outlook.com [40.107.70.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76AD46EC3F
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Feb 2021 22:29:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T9mWehlqh8B2KPQ1CqmTS+MiNAM2NZ1VPi8fELF6TTs9kpJVyWOfhn63MRj4ecH/ojmQDRzR+rYFET1zl0caDz90LZF1lUwNchs0rQI6renu3uWuDa9wDqCbBmSjEiSirTpdExgbAZYVs2IBR8+B/eOYeld8d5Iom0G02xBRTz1t3Rx3zvw9eTpfMxukbpoW9vUVW0EHM10219f60URcbT44MaKICbIFmETxzvwq6meQztpGQueRE4wVLUn5ZdtzWvKah8XQcHUOthZbqV0T5nR/Cjh5cetN1Es5IZRL5fW76qXhGZr2TLyOyA9+mfZQ3z5cpd/Mwe1aa9tcMYoEXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UrPvEbyDPTS4FgskDlLr+wcw87BlV8q0aVlP47ZVy/c=;
 b=RVDXaV/ESbn1uwHbNwOYDiYbAwoBFlMI25SfXDBayPc205F1LzQzAa+ajxVaZ04GtnrFQdp8sihYR6Cxy26wPbheGbPC1JUNxyx8iQvbfg93D5GDTHscC+R6KwnEnXOWvbt/h4pLR7dwk6L3yvWT2Y312Pn/phYidWIUjn9AA/poaEd6ftMRtqyKVR9eCZc8F0KEe/11Ll+MYqs6mU7oHJ/W64yVlaBNqfJJSFJMlmh1BekNGJwfZLOjv78CIPPiqjvUmTq5zqF16cbsVStt2BsSUdA32IKD3XxnZfg834riTO/X6enfS6hCcx2YhLz4nxMtk1xArxVN7l16fzDYDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UrPvEbyDPTS4FgskDlLr+wcw87BlV8q0aVlP47ZVy/c=;
 b=gkHsUY5/KP/XlAeHyRFE6KTt7Ertfw59QQmQuTtAyqUyfKai6JvFq7M496hBnMqKI2jVwufRoVg51x7j8/PhSB3tHRxMCg5xKkhDb35UPqEOZgdQJBoM6AkCIvqv7uviIbRH1d4IuXwUK5zvUCnfcKLR6VH+FdhsWsdHDHWP2/U=
Received: from DM6PR12MB3529.namprd12.prod.outlook.com (2603:10b6:5:15d::18)
 by DM6PR12MB3065.namprd12.prod.outlook.com (2603:10b6:5:3c::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.29; Fri, 19 Feb
 2021 22:29:40 +0000
Received: from DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::b537:b8eb:7115:78df]) by DM6PR12MB3529.namprd12.prod.outlook.com
 ([fe80::b537:b8eb:7115:78df%7]) with mapi id 15.20.3846.042; Fri, 19 Feb 2021
 22:29:39 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "R, Bindu" <Bindu.R@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 00/13] DC Patches FEB 22, 2021
Thread-Topic: [PATCH 00/13] DC Patches FEB 22, 2021
Thread-Index: AQHXBwzisob4T4sRkkeVg0ytq+A8iapgDuZg
Date: Fri, 19 Feb 2021 22:29:39 +0000
Message-ID: <DM6PR12MB35292DD65DA8F79A06A0E6949C849@DM6PR12MB3529.namprd12.prod.outlook.com>
References: <20210219221612.1713328-1-bindu.r@amd.com>
In-Reply-To: <20210219221612.1713328-1-bindu.r@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-02-19T22:29:37Z; 
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=a9a1a806-4948-4e78-aeff-3ada24f07e00;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [174.95.64.64]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 861487ec-f67a-4049-2920-08d8d525d8ac
x-ms-traffictypediagnostic: DM6PR12MB3065:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3065D5454EE7CF881D8DF1BF9C849@DM6PR12MB3065.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jNNIBdYUoUntBpPmByZ5MGZYZT/RFQkvMCd9ZSJamzi31VMZIchlpKCGkWqiMN1sd7/j8bP7+puf4/bcbktxHE9Y2N6TxU9dZWr0uh6RLME8iHivuf14VIKJTFWm+f0+eMd6QcVk2h4BXQdNNFUs4l6EGL3TxWsS+kbeHKuC/0/OQphz9S5Tp74oOXbjR69ysHYt0VkNOT7zou/1EX9gMz8VC8N4YMswCCF+vOoT3jRatp5dotCDaNY6KSJWPLsqM2TVTkuKgqf7Mo2xxXuwWalwQztUtjtT2Gn4DEgySuvjIJBexEN7zEf1oZgT2/gQNu6huq9X3dMC7SjDr9v7s52nYaQXDrw75uTtGTA9TK0kV89OBUcSLmznf5c7dT/Qul6PdpUm9ek+WhlqmKsKkie8j95nbezUUMzjpqYPd8DAzNqj8JeWKsUaShEeTKMjmiXLIhoxfxsxEpvRAoas7ZbSuu8x11jAXb5y7cy1Fcv6pSs7+rO6tANiz5kOwL07zMrTThAWT0JcNSklqWGJMG6Dgw87CWmZH6l0BP9pNIE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3529.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(136003)(366004)(376002)(346002)(4326008)(66556008)(66446008)(55016002)(86362001)(64756008)(53546011)(966005)(33656002)(66946007)(316002)(76116006)(9686003)(2906002)(71200400001)(7696005)(8936002)(45080400002)(8676002)(110136005)(186003)(52536014)(66476007)(6506007)(54906003)(478600001)(83380400001)(5660300002)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?MrDM/kxW976IulZRCuZ/9rJ0HpSQdMKJ/nDw+NS2rlpsDpK0tdwNfa0qyT?=
 =?iso-8859-1?Q?+n5fbOcsd4aiVSkHdmP8cHRO8RhMKH8tw1/hFlBq/Jgy1I9hsajPjoBW9Z?=
 =?iso-8859-1?Q?aZFJQlPXQ217diBWV4pGr6ZC9qJMAYbVSdHUkiM5mnVbnejUQTXLfoSGju?=
 =?iso-8859-1?Q?7wePDp0hlFG71V5BW1fU5KIoI/9FagBfU3ogo6qWW8QkCj2nRUu5hjtGvU?=
 =?iso-8859-1?Q?ZpDDhr9Q39cYW/zZY2Y1eZdQoHIY+C9Q4GONLfNM+ivfEGwXw2eTSY+fB/?=
 =?iso-8859-1?Q?fd3puZxXLGjyV4El37BAeIugbemiW/wxuf0pQvdF3lbtyMKInjiULh9AIO?=
 =?iso-8859-1?Q?TcDtBSJhRC5ryL8Wx7lwUvnE7odI3q67bJkiTkHBkYKoYuiJhh3DRedJW9?=
 =?iso-8859-1?Q?AK3I5YYfiyXLjRMmy7fnrcONEVVSlpEFarK1fVP+QyQcBFDQ8zkOCWfeVQ?=
 =?iso-8859-1?Q?ONao4ZAL7wiNmNQuAVsFT5KIkS1QbIijXeyu+cExyI1s1YOotQq0fcS2Ab?=
 =?iso-8859-1?Q?EO8ohReDNbvqTPlFyiBvCIACAXZqqy/yXP5+fPgJQCSdV6nRinHi7c0vCB?=
 =?iso-8859-1?Q?lGzlExYpJNDXzXbvebKG8iBi5yYp3l6/lH1gzKga7fWQfMmMKmtA7+VXmx?=
 =?iso-8859-1?Q?WkwV+ZHFLGJf6L9OMgbult1P4Cl1tJdfQMfxUfnS8hJuHj2//ljoykYrLk?=
 =?iso-8859-1?Q?Pjnd0QLV7BqSGvtIksyBYn03kyiWZD6P4WfHonz9c+OLegoznskkcnj9z3?=
 =?iso-8859-1?Q?OdjzqVceS2jeAtpT0vtsY3mnE9g7LO5q9K16e1Wzak+tgtd73MHchaEU7k?=
 =?iso-8859-1?Q?9Fn26oXwJaNFOgTBNdCKvqyuiOneyQlSu0s0T/aKKyphM7mlOEJhNkr2a5?=
 =?iso-8859-1?Q?H4Dbor5JoV622pXwIdad5v831ZK0Z0YVAd2sbMiWY9MwF0gN7R1rFpK8mF?=
 =?iso-8859-1?Q?1qGjrHoXU5VDZaSfKb6mrHB05JSTNDYJW/nDMQzoeWOvQRdHvRE6UFJ+LM?=
 =?iso-8859-1?Q?r2Yizu3saZdjkeiZ7CNCR0n3rvG/4w9fiP8prFcW5Bnnb8AP8IGZ5DRITa?=
 =?iso-8859-1?Q?9xbE+6T+ymDrbDowXxTCDsvFpYjB81Hh8AFjNjJhyujdHPr+8peFTaVpnU?=
 =?iso-8859-1?Q?tyuzGSBsjVtZSR25kN1Yo4oRzrPbBd7eZKLVyKTvCVb75XTzMyRgw6YKOi?=
 =?iso-8859-1?Q?NH0Nj8ztcj6kjphr5FPIwJFDGlACYc51LQ5dNTtX0k6uStfyw3AHh410OH?=
 =?iso-8859-1?Q?fRI8riHuQ9drGnaw31pJcPBV1wxKQIrLQjDEfPljO+rksZPLTnANeQOxcS?=
 =?iso-8859-1?Q?aWK7+IkXLaQ1D/P6UQ2Z5Vn8Vtx0TN1LgMQQxRIoBMXt7Vw=3D?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3529.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 861487ec-f67a-4049-2920-08d8d525d8ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2021 22:29:39.7243 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OvzxaOPGKEQ6bIDgb0IiX2EmlOufYGg1KOwUzmse9TSGSiaIDYsIGTaNVYFUuuPA2IWCyWtIrhaXh0HwyFzwVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3065
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
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Jacob, Anson" <Anson.Jacob@amd.com>,
 "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "R, Bindu" <Bindu.R@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Public Use]

Hi all,

This week this patchset was tested on a HP Envy 360, with Ryzen 5 4500U, on=
 the following display types (via usb-c to dp/dvi/hdmi/vga):
4k 60z, 1440p 144hz, 1680*1050 60hz, internal eDP 1080p 60hz

Tested on a Reference AMD RX6800 on the following display types (via DP):
4k60 60hz, 1440p 144hz, 1680x1050 60hz.

Also using a MST hub at 2x 4k 30hz on both systems.


Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>

Thank you,

Dan Wheeler
Technologist=A0=A0|=A0=A0AMD
SW Display
O=A0+(1) 905-882-2600 ext. 74665
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
Facebook=A0|=A0=A0Twitter=A0|=A0=A0amd.com=A0=A0


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Bindu Ra=
mamurthy
Sent: February 19, 2021 5:16 PM
To: amd-gfx@lists.freedesktop.org
Cc: Brol, Eryk <Eryk.Brol@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>=
; Wentland, Harry <Harry.Wentland@amd.com>; Zhuo, Qingqing <Qingqing.Zhuo@a=
md.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Jacob, Anson <Anson.=
Jacob@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Lakha, Bhawan=
preet <Bhawanpreet.Lakha@amd.com>; R, Bindu <Bindu.R@amd.com>
Subject: [PATCH 00/13] DC Patches FEB 22, 2021


This DC patchset brings improvements in multiple areas. In summary, we high=
light:
* Firmware release 0.0.53.
* Addition of interrupts for DCN2.1
* Refractor debugfs entries for connectors.
* Enable display audio when seamless booting with an external monitor over =
DP.
* Fixes for System hang after multiple hotplug, timing synchronization for =
displays, disable seamless boot for DP.


Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.53

Anthony Wang (2):
  drm/amd/display: disable seamless boot for DP MST
  drm/amd/display: enable audio on DP seamless boot

Aric Cyr (3):
  drm/amd/display: Don't optimize bandwidth before disabling planes
  drm/amd/display: reduce scope for local var

  drm/amd/display: 3.2.124
       This version brings along following fixes:
       - Fix system hang after multiple hotplug.
       - Don't optimize bandwidth before disabling planes.
       - Report timing synchronizable when DP streams time frame difference=
 is less than 0.05 percent.
       - move trace buffer to uncached memory.
       - enable audio on DP seamless boot. =

       - Disable seamless boot for DP MST.


Eric Bernstein (1):
  drm/amd/display: Remove Assert from dcn10_get_dig_frontend

Eryk Brol (1):
  drm/amd/display: Check for DSC support instead of ASIC revision

Qingqing Zhuo (1):
  drm/amd/display: Fix system hang after multiple hotplugs

Rodrigo Siqueira (1):
  drm/amd/display: Add vupdate_no_lock interrupts for DCN2.1

Stylon Wang (1):
  drm/amd/display: Refactor debugfs entries for all connectors

Vladimir Stempen (1):
  drm/amd/display: Synchronize displays with different timings

Yongqiang Sun (1):
  drm/amd/display: move trace buffer to uncached memory.

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  82 +++++--  .../gpu/drm/a=
md/display/amdgpu_dm/amdgpu_dm.h |  27 +++  .../amd/display/amdgpu_dm/amdgp=
u_dm_debugfs.c |  22 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  39 ++-
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  10 +  .../gpu/drm/amd/dis=
play/dc/core/dc_resource.c |  43 ++++
 drivers/gpu/drm/amd/display/dc/dc.h           |   5 +-
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |   1 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   3 +
 .../drm/amd/display/dc/dce/dce_clock_source.c |  52 +++-  .../amd/display/=
dc/dcn10/dcn10_hw_sequencer.c | 225 ++++++++++++++++++
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.h |   5 +
 .../amd/display/dc/dcn10/dcn10_link_encoder.c |   1 -
 .../gpu/drm/amd/display/dc/dcn10/dcn10_optc.h |   2 +
 .../display/dc/dcn10/dcn10_stream_encoder.c   |   1 -
 .../gpu/drm/amd/display/dc/dcn20/dcn20_init.c |   1 +
 .../gpu/drm/amd/display/dc/dcn20/dcn20_optc.c | 123 ++++++++++
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |   8 +-
 .../dc/dcn30/dcn30_dio_stream_encoder.c       |   1 -
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    |   2 +
 .../gpu/drm/amd/display/dc/inc/clock_source.h |   5 +
 .../amd/display/dc/inc/hw/timing_generator.h  |  12 +
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |   3 +
 drivers/gpu/drm/amd/display/dc/inc/resource.h |   4 +
 .../display/dc/irq/dcn21/irq_service_dcn21.c  |  22 ++
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   4 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.c |   7 +
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.h |   7 +
 .../gpu/drm/amd/display/dmub/src/dmub_dcn30.c |   7 +
 29 files changed, 676 insertions(+), 48 deletions(-)

--
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D04%7C01%7Cdaniel.w=
heeler%40amd.com%7Cc87256f9100c4509f11508d8d5240403%7C3dd8961fe4884e608e11a=
82d994e183d%7C0%7C0%7C637493697957037816%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC=
4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=
=3DITJMWXnsrp%2FG8PAsy%2FxjOftNx6IXuHDhVvnGuwC6dJk%3D&amp;reserved=3D0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
