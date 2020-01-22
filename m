Return-Path: <SRS0=N3S+=3L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287B4C2D0DB
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2020 16:12:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF075206A2
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2020 16:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nC7QK264"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF075206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF15F6F5CB;
	Wed, 22 Jan 2020 16:11:59 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DE416F5CB
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jan 2020 16:11:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kNofAyVyfS66kMj/VkADLv1QOQuDhDLmWXWYxypI5TM2Ep8BG3rMW44UpnxQactuDNjnww/VfTHW/jq70EynY/fk7VELSz2mKLPzpBnGa9s0OZuVb0fyTx2U/C2ZaihJysed4l4w1RUkMzGoD+9L/qBApGBwU/Nmu7M+Y+3Awj3eiDhDT9vUsa2PeXN0DK0cEWm6o1NAY65k17/1JuFWmdbcgJEH57e3sYSc7qN26sdALYZWF+8gg4v42luMmDP3sKRu1Qn4lunWehzBzNpRyO+s5bPPfm9fiUo8t59WpcPp9VC0zhbMgZgykQuJD9yvYiFau1EIAdGpE9dRoLkbpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=im1vu5l96Cn/60E0LR3hS0m41UW5O9k2EjitHUwQELI=;
 b=OFZciB6Z+InXm4NVxMkKEfdnIskaRYnDB8cx84guTj9LAQCNcxfzhjCdCWNxrUUfYxeWLSJJuerg+lKj8I7GNSboT/soLtlcXDLqGQSnvHp2zGzU1kNlpPii54UK1p3jHTU6EwGE5sTVzg/DUpdBnjofE6XRBQOTkhwEHt1CjwuXlyQVP3h+t+PVdfRENAarkQxl2HvNjz9hhgSSga2KB6FqMEFhsqZArPnY7ZFwgjAMs+wsETHJhdqXrmFHBjfI1KwK7dKKZEZ4LppTpXXm4dTcj3gOlBu4/+7j4Wi/1817WT6GH6KdlITa7D33iTRhw02p9QEUgKfyLexzNc3BTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=im1vu5l96Cn/60E0LR3hS0m41UW5O9k2EjitHUwQELI=;
 b=nC7QK264GgrCs0s74XYBjqwKcB26IURmXCuCoeaim6fAhhl2rSzrUy1kveVUKkbneBpJs5My69IDIa0yxI8AKqvilbS+dxMzge4KU9fMAkrhTDj48q43MW85OHcsBJlM/tMJw5fN0gtucKYAB27ZV+l99z0FFVU/OU72uIIukt4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Harry.Wentland@amd.com; 
Received: from BN6PR1201MB0228.namprd12.prod.outlook.com (10.174.115.135) by
 BN6PR1201MB0148.namprd12.prod.outlook.com (10.174.114.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Wed, 22 Jan 2020 16:11:57 +0000
Received: from BN6PR1201MB0228.namprd12.prod.outlook.com
 ([fe80::d8c9:e17c:33f1:6d2]) by BN6PR1201MB0228.namprd12.prod.outlook.com
 ([fe80::d8c9:e17c:33f1:6d2%3]) with mapi id 15.20.2644.028; Wed, 22 Jan 2020
 16:11:57 +0000
Subject: Re: [PATCH 0/5] HDCP SRM interface
To: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20200116202945.21801-1-Bhawanpreet.Lakha@amd.com>
From: Harry Wentland <hwentlan@amd.com>
Autocrypt: addr=hwentlan@amd.com; keydata=
 mQENBFhb4C8BCADhHHUNoBQ7K7LupCP0FsUb443Vuqq+dH0uo4A3lnPkMF6FJmGcJ9Sbx1C6
 cd4PbVAaTFZUEmjqfpm+wCRBe11eF55hW3GJ273wvfH69Q/zmAxwO8yk+i5ZWWl8Hns5h69K
 D9QURHLpXxrcwnfHFah0DwV23TrD1KGB7vowCZyJOw93U/GzAlXKESy0FM7ZOYIJH83X7qhh
 Q9KX94iTEYTeH86Wy8hwHtqM6ySviwEz0g+UegpG8ebbz0w3b5QmdKCAg+eZTmBekP5o77YE
 BKqR+Miiwo9+tzm2N5GiF9HDeI2pVe/egOLa5UcmsgdF4Y5FKoMnBbAHNaA6Fev8PHlNABEB
 AAG0J0hhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPokBNwQTAQgAIQUC
 WFvgLwIbAwULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgAAKCRAtWBXJjBS24xUlCAC9MqAlIbZO
 /a37s41h+MQ+D20C6/hVErWO+RA06nA+jFDPUWrDJKYdn6EDQWdLY3ATeAq3X8GIeOTXGrPD
 b2OXD6kOViW/RNvlXdrIsnIDacdr39aoAlY1b+bhTzZVz4pto4l+K1PZb5jlMgTk/ks9HesL
 RfYVq5wOy3qIpocdjdlXnSUKn0WOkGBBd8Nv3o0OI18tiJ1S/QwLBBfZoVvfGinoB2p4j/wO
 kJxpi3F9TaOtLGcdrgfghg31Fb48DP+6kodZ4ircerp4hyAp0U2iKtsrQ/sVWR4mbe3eTfcn
 YjBxGd2JOVdNQZa2VTNf9GshIDMD8IIQK6jN0LfY8Py2uQENBFhb4C8BCAC/0KWY3pIbU2cy
 i7GMj3gqB6h0jGqRuMpMRoSNDoAUIuSh17w+bawuOF6XZPdK3D4lC9cOXMwP3aP9tTJOori2
 8vMH8KW9jp9lAYnGWYhSqLdjzIACquMqi96EBtawJDct1e9pVgp+d4JXHlgIrl11ITJo8rCP
 dEqjro2bCBWxijsIncdCzMjf57+nR7u86SBtGSFcXKapS7YJeWcvM6MzFYgIkxHxxBDvBBvm
 U2/mAXiL72kwmlV1BNrabQxX2UnIb3xt3UovYJehrnDUMdYjxJgSPRBx27wQ/D05xAlhkmmL
 FJ01ZYc412CRCC6gjgFPfUi2y7YJTrQHS79WSyANABEBAAGJAR8EGAEIAAkFAlhb4C8CGwwA
 CgkQLVgVyYwUtuM72Qf+J6JOQ/27pWf5Ulde9GS0BigA1kV9CNfIq396TgvQzeyixHMvgPdq
 Z36x89zZi0otjMZv6ypIdEg5co1Bvz0wFaKbCiNbTjpnA1VAbQVLSFjCZLQiu0vc+BZ1yKDV
 T5ASJ97G4XvQNO+XXGY55MrmhoNqMaeIa/3Jas54fPVd5olcnUAyDty29/VWXNllUq38iBCX
 /0tTF7oav1lzPGfeW2c6B700FFZMTR4YBVSGE8jPIzu2Fj0E8EkDmsgS+nibqSvWXfo1v231
 410h35CjbYDlYQO7Z1YD7asqbaOnF0As+rckyRMweQ9CxZn5+YBijtPJA3x5ldbCfQ9rWiTu XQ==
Message-ID: <55a3fd2d-c2ed-4af0-543e-9850118b722a@amd.com>
Date: Wed, 22 Jan 2020 11:11:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200116202945.21801-1-Bhawanpreet.Lakha@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0053.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::30) To BN6PR1201MB0228.namprd12.prod.outlook.com
 (2603:10b6:405:57::7)
MIME-Version: 1.0
Received: from [10.4.33.74] (165.204.55.251) by
 YTOPR0101CA0053.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18 via Frontend
 Transport; Wed, 22 Jan 2020 16:11:56 +0000
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f4d7c0b4-892c-42ab-7ba5-08d79f55cdd6
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0148:|BN6PR1201MB0148:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0148CFACAA7F6DC3B27E8D0D8C0C0@BN6PR1201MB0148.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 029097202E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(396003)(39860400002)(346002)(376002)(366004)(199004)(189003)(81166006)(16576012)(36756003)(52116002)(81156014)(316002)(31696002)(6486002)(186003)(26005)(2906002)(31686004)(4326008)(8936002)(2616005)(8676002)(5660300002)(16526019)(53546011)(956004)(478600001)(66946007)(66556008)(66476007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR1201MB0148;
 H:BN6PR1201MB0228.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iix1lF6fQ0+tke03flyl6gLBMJIGh7Z6nMEAzeub5x/HdUjQVhKgapoe63qpHR0VBkETL23/RhqLPc5X0WxnGqxZUL4keYISatV3H3NmyZqx4Ep3txerLsur/vNC9HQgrB49MQJH4aL9oJ8VVv0lmV9nsUMIr8UFyRmGWYiWqZrBxCdK06JexRKapV/GQVnSdcjHbpUI0YVzChhFA2YnglD/gGFREg4b6gI+30DuKo43vUiEiI2RIwCak/Pzoq2EqFNH/V3NBE0LotzIBGRXRcbAJqWmSjxtklNbu7xhtiGOnbZnPSZXLoCR5aVMyQEyQNbm8jUxmp191sFEfchjvxBn9R2bjcv49PqQxrnGdBIbwtb0o0BW29OIYqiaYCcKBg03hzrPWUapDE1Bjb9+oNLauiadmSvoZp0UExW5zTVWSy/lR8wt2bHEhgMPvaUB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4d7c0b4-892c-42ab-7ba5-08d79f55cdd6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2020 16:11:57.2845 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EjkqO0A9nsdzkzXrUk9lS+mKEVZq1cYSRLmmZ5BQ6jkXHhEec1x20DIpaice7x1eZ4T0KyaWdwgnHh9ZgAJhnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0148
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
Cc: harry.wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-01-16 3:29 p.m., Bhawanpreet Lakha wrote:
> These patches adds support for SRM loading. By providing an interface to the
> usermode
> 
> SRM has to be persistent and since the kernel cannot directly write to system
> storage we need to provide an interface so that the usermode can do it for us
> 

We'll want to elaborate a bit more on why and how this is done. As
mentioned on my patch 2 comments I recommend to do this there as the
cover letter is lost after merge.

Harry

> 
> Bhawanpreet Lakha (5):
>   drm/amd/display: Pass amdgpu_device instead of psp_context
>   drm/amd/display: update psp interface header
>   drm/amd/display: Add sysfs interface for set/get srm
>   drm/amd/display: Load srm before enabling HDCP
>   drm/amd/display: call psp set/get interfaces
> 
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   2 +-
>  .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    | 182 +++++++++++++++++-
>  .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.h    |   9 +-
>  .../drm/amd/display/modules/hdcp/hdcp_psp.h   |  26 ++-
>  4 files changed, 212 insertions(+), 7 deletions(-)
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
