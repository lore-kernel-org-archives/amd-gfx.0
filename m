Return-Path: <SRS0=mGSI=DF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 917BAC4741F
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2020 14:26:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A4B82075A
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2020 14:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mZROiGTu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A4B82075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD2D389FC0;
	Mon, 28 Sep 2020 14:26:51 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 410A589FC0
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2020 14:26:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VDuBAG0MNXVkp6Baglbrk0iR62gg3dLlHhLZxUoeLEWnWzkEEumK4thT4g+nBjjwEbwVDM95pTejYPzHNGMw7LasPdB+J3HbuURZtrugSnuWUICtoHXC/euF3V+psw2XrXem/OQCZGMIomjxAqftJNCbXuss9wzy6a0ns+l9UHjjJ/u23BgK0yGnjFZhibeCdQNM3nQK9MMDLZRsxt/BaLCGKAebs8Iow06P0N2lgJ/OYuemxslvvz0ta0NxKFrLSEF0x7Y7vu1BtDBnWSUYalYhOPwq5Hotxd7cEw6wJ5vag5Jdt6/9+hh1ELw4KB1EO1x3m3uhXqiOvpm+h43L3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xeMvMwL2M7f4c+3498/KKFMJ7A8eg8bFLt0SEoyWs9U=;
 b=LGwKDqWlEE1Pnf1iANBBNTSyBTx4UCbJzLj3npr6InH/LGhH8oOWGpese3l55c7YIPjHlvUqmlLyKj+ZVsfxXMs9IDhkfm319h0lrX116JP8OQs3R6qX4Df/hXivvnAJU2HyO+qmpjwv46N+iqGLQUTU0P7X6SKnC2k9FFmPNlzsc4ZhzIlp6EulLQK7JRPK6Q5iit7e6Pj959M0KO4e7jUjBN3i9AMcrIFVkMuoJYx/h+2SmOwPDL3Sy6fEKCe0jymxYRN6rvvfnDghkwE/mymH2uJ+7TcWt0YJHcuCUFjmp1pqKNf3Ue5W6VKV7qzRxvcAhSemU3WN4nqg/kqHzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xeMvMwL2M7f4c+3498/KKFMJ7A8eg8bFLt0SEoyWs9U=;
 b=mZROiGTuMS4L5yNzWeLrh135oMQHlyR9xXYkCQ4NM04JoqNvBBgZsF450yIx5bwMo2n4PI0JzOb8SgIAiqEPrExUPoAnMd+KHoOW0cCmeoPZon7IwKo1D6CirfMkWbeNzUEpYaEA+e+wkKE0c5onYEEXdzir3RMClzFrveDSIk0=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11)
 by MW3PR12MB4556.namprd12.prod.outlook.com (2603:10b6:303:52::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Mon, 28 Sep
 2020 14:26:46 +0000
Received: from MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::5dc0:bafc:6040:a8fe]) by MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::5dc0:bafc:6040:a8fe%2]) with mapi id 15.20.3412.029; Mon, 28 Sep 2020
 14:26:46 +0000
Subject: Re: [PATCH] drm/amdgpu/dc: Pixel encoding DRM property and module
 parameter
To: Alex Deucher <alexdeucher@gmail.com>, James Ettle <james@ettle.org.uk>
References: <7cc7d590-f713-2060-6bac-37bed0df618a@ettle.org.uk>
 <CADnq5_OEzoEP93+MsGN1tspy0OrxVTkujKUhs+6LryVApvERkw@mail.gmail.com>
 <286845a3-4903-c169-aa36-1eb986492ea3@ettle.org.uk>
 <CADnq5_O8Wzddr3LryTuQ5Jqc5yt51wqkxv6zbSbr0_RBSQCA4g@mail.gmail.com>
From: Harry Wentland <harry.wentland@amd.com>
Autocrypt: addr=harry.wentland@amd.com; keydata=
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
Message-ID: <967f82b1-cf5b-473b-c9b3-d9f9df588cc7@amd.com>
Date: Mon, 28 Sep 2020 10:26:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <CADnq5_O8Wzddr3LryTuQ5Jqc5yt51wqkxv6zbSbr0_RBSQCA4g@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BN8PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:408:94::22) To MW3PR12MB4379.namprd12.prod.outlook.com
 (2603:10b6:303:5e::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.4.135] (165.204.84.11) by
 BN8PR03CA0009.namprd03.prod.outlook.com (2603:10b6:408:94::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.20 via Frontend Transport; Mon, 28 Sep 2020 14:26:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 00ca5618-c52a-4d2c-85d9-08d863ba8741
X-MS-TrafficTypeDiagnostic: MW3PR12MB4556:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW3PR12MB4556D82E28F2814B2C5C72DB8C350@MW3PR12MB4556.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kQd4I9N1ul3ibExXE7cU0f0YMqhr6D5dxv++kf6gLnUaREWTzVRiOHNjHO3SfbEXOc+eG2zGXbFAzk1T/IHJwUzNs2H+QPTFkykFfKG+NXd1t92UTOiiNngKGBkUCOSYmTUXtvs2hWvNpKhXrWWfTKlyngod7YdTj+clpXHiByu1xo5YXallGcA1/0hB/sbWjcRJOe3Nyrl7P009DQRzPH9oiYF3jSIE8j03M2/IbzLXmRqVenwpuRE5opqhTzXmS0raxytWJ6UYo3YmGJi5s4KoTOVTMqE8u6N2HqMtL3PJGGuJR0KmYp10k+s0U6m0Ns5sswzH3jptYdDNYnkCJt6E+1bWEmXU7xrdNKZeFdsxUD33YMgi8cdYxrqNsKp1PQcJ28kOMaB+lHDAuMIBh6S9AplO1uPeaa48zKGawSnp7bTotXcN4uAF7znqaBds
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4379.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(366004)(396003)(346002)(39860400002)(54906003)(2906002)(4326008)(52116002)(36756003)(26005)(53546011)(6486002)(44832011)(2616005)(31696002)(16576012)(956004)(316002)(16526019)(110136005)(186003)(8676002)(8936002)(5660300002)(478600001)(86362001)(31686004)(66476007)(66556008)(66946007)(83380400001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: B4v5dQEQY13tsFbE/cJAhU7ruw9Wle59Eigw2MjVDQJoY6Pgz+Hme8Nh5INYOoKNlETgr09eQ5aJFT3n6CQNX/bNRALvy7WsJmblqbFlLDO7W9qexRSseUVGG240p8eiZ4RR+bXpMY6w61X1Hq83VqTJ+qSZ+RcL1mVEsACbw3Je65Ird/8cFh2kK7U7EHBj6EmwWyMLGx3kFvSaC2/nqEHNjgvn0mnfeEgo6PQtQJCxoHfZecgJk1pAAQXEJq4p/ClO+V/w06NRRea8GbV4fHtMx52lDtmtcdSZTDW+/9eN8noBYzzhR9r9lCrbUrVIKx06/Lzf6BGBUyplwFu4dNfo72IauofKFptSx+qeNhfEGcSq2uBxgWr6i4SZZl0JesNBR0TrMocMnn4ADySAZZh+ZepsgTyh3014MG6L2I1hCaC0eGEL9GriYzOkt5OiPu6dkfW/T4feJ+31G2ufshnWPwrVCIpxHhaOVGSitcm2dYtUfpa+YOB5giSiZgT0R1WbOxmPK1D9orOkA48846LemCpcgCTD0jOR2yTy+dXZrO6jl90+eMc1QAXpdGJ8C0h5vMOAK3l3EOJEkrpLyeZ4Psj7dLdLMfGwIZctCCHXd+ve2MVtkDywF6qMFAHvw4KOqILNpET/OJB580p4qA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00ca5618-c52a-4d2c-85d9-08d863ba8741
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4379.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2020 14:26:45.9639 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eCT8cubBFxYPg6hlqEmzSEZyshbdxgNXnhpoc8g7ENnDuf+mMOOQ/yDZoXyZ9Ia1Z1bN7P483B2ApeGwc3Uyzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4556
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
Cc: "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 Harry Wentland <hwentlan@amd.com>, "Kazlauskas,
 Nicholas" <nicholas.kazlauskas@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2020-09-25 5:18 p.m., Alex Deucher wrote:
> On Tue, Sep 22, 2020 at 4:51 PM James Ettle <james@ettle.org.uk> wrote:
>>
>> On 22/09/2020 21:33, Alex Deucher wrote:
>>>> +/**
>>>> + * DOC: pixel_encoding (string)
>>>> + * Specify the initial pixel encoding used by a connector.
>>>> + */
>>>> +static char amdgpu_pixel_encoding[MAX_INPUT];
>>>> +MODULE_PARM_DESC(pixel_encoding, "Override pixel encoding");
>>>> +module_param_string(pixel_encoding, amdgpu_pixel_encoding, sizeof(amdgpu_pixel_encoding), 0444);
>>>
>>> You can drop this part.  We don't need a module parameter if we have a
>>> kms property.
>>>
>>> Alex
>>
>> OK, but is there then an alternative means of setting the pixel encoding to be used immediately on boot or when amdgpu loads? Also are there user tools other than xrandr to change a KMS property, for Wayland and console users?
> 
> You can force some things on the kernel command line, but I don't
> recall whether that includes kms properties or not.  As for ways to
> change properties, the KMS API provides a way.  those are exposed via
> randr when using X.  When using wayland compositors, it depends on the
> compositor.
> 

I'm not aware of a way to specify KMS properties through the kernel
command line. I don't think it's possible.

For atomic userspace the userspace wants to be the authority on the KMS
config. I'm not sure there's a way to set these properties with Wayland
unless a Wayland compositor plumbs them through.

Can you summarize on a higher level what problem you're trying to solve?
I wonder if it'd be better solved with properties on a DRM level that
all drivers can follow if desired.

Harry

> Alex
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
