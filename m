Return-Path: <SRS0=qtCw=7K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34AC5C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2020 14:25:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5872207D3
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2020 14:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nEIhKagf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5872207D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A41E46E58A;
	Thu, 28 May 2020 14:25:56 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E0F66E581
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2020 14:25:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QSgju64mnhurQb7Zk+iLjE/qeyl8ybegRlFvhG0J8qB/Iy+9ORNAUEDrW4O83ri4CZI7UvvApfHLeVvQOh53+5elzu8Wsx/G65cbWb0W2VVUJLRkUAyat+QveaI3UXa/xoSOc+raKL2n54Ne416x9a8/7CV4xuEIVpSaF+rf59HjdUWfi0m0Hw811pBZVHCmk/1gXiXum+IdK4pUcGTgknfFCnkEwry5R3XJnxCQYAzrQkGupQjSdTrC6keTG2z8FlnflwQPqNNdCosQ8g2kVcmErrVyuWcn24rkHb/M39EwSHolwJymyF4xeg1+CKv9qMGFRF+313zh8gh1qkmN4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hjy5J2Oe3fXzMZmSKAJu+O5BHxHjeSrJvBr443jGzyc=;
 b=fpc030FfX4SbNol1j+9+etlEvuS1yq7Bm24C/gQE36zILl1IgNXcK/SRX1LORzEZHSraGhCNf5/usgeMa/UVdqnh2F96zQJWTtQWtOOca28DMzPzDk0Cw6ixAnj5KD3npvSsVMdF1JjVt6AHCkndBq1oiyO7VTKFwOgQg4D9M7Pauynd6YtY5ae4bkn2rsKjpwF6gCNufXlW/NrEHS8SyqWIe2Rn6Zgf9JB4nIiYPoqWqT2CU3m7dmaBhR2YlvwTEme/4qSzMuAFW69dRtOE/08aS7PchBHg3tMWEjuyBLWcZMfpaVDwGIaEgPDlbTSNviWtx57bDojK9yYf4ff/Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hjy5J2Oe3fXzMZmSKAJu+O5BHxHjeSrJvBr443jGzyc=;
 b=nEIhKagfYJmwI0WCoMrgUAEqm8SEyg2vLv/PfiDftleuDUvJK49f88TekFXQPGsoShnLxcZbSLqouhbxMZe4Wf7rWSLxKagaE+Wxa96rClzP5al3zD/ofhxlc/sMC1Mq9Shw2m9kYk7PxFLWN+vwPtKiymv5W6UlqQxJfP74CB0=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11)
 by MW3PR12MB4427.namprd12.prod.outlook.com (2603:10b6:303:52::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Thu, 28 May
 2020 14:25:53 +0000
Received: from MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::31b7:9b4e:3f37:5e97]) by MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::31b7:9b4e:3f37:5e97%6]) with mapi id 15.20.3045.018; Thu, 28 May 2020
 14:25:53 +0000
Subject: Re: [PATCH] Revert "drm/amd/display: disable dcn20 abm feature for
 bring up"
To: Alexander Monakov <amonakov@ispras.ru>
References: <20200528134807.5665-1-harry.wentland@amd.com>
 <alpine.LNX.2.20.13.2005281652440.18802@monopod.intra.ispras.ru>
 <fc597b5e-147c-2a90-d7c7-bd5b01cdcfd2@amd.com>
 <alpine.LNX.2.20.13.2005281710560.18802@monopod.intra.ispras.ru>
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
Message-ID: <689818e1-fbd4-9549-bc30-f88f05b6d65b@amd.com>
Date: Thu, 28 May 2020 10:26:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <alpine.LNX.2.20.13.2005281710560.18802@monopod.intra.ispras.ru>
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0146.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::25) To MW3PR12MB4379.namprd12.prod.outlook.com
 (2603:10b6:303:5e::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.20] (99.254.88.27) by
 YT1PR01CA0146.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.17 via Frontend Transport; Thu, 28 May 2020 14:25:52 +0000
X-Originating-IP: [99.254.88.27]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ad40f2cb-f9ce-4533-3b8f-08d803130742
X-MS-TrafficTypeDiagnostic: MW3PR12MB4427:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW3PR12MB4427E0B614C5B8C4BCB6BDB58C8E0@MW3PR12MB4427.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-Forefront-PRVS: 0417A3FFD2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E5Hp379sRfGC5oo0QykGZ0u/z1mlIN2rD5mycd/xsDKp2VH6iPUzAC3Pi/fe/BYtg11veDakmgj6Z2eWNNeT02BKPgIZQ7BLVfbGcYSRWlFiQlNXuaMBs6nmWguga+T74mYs/ql4YToOA/MeV6TS4IcsLedNo516oKI8KZFWNMudNGyyMIwujvYfbIFfLTpIXzZKMIJIFzbTratXQIAMW83GIWHr/BRWbc9/uzlshKlFXXDtx0wvDYk0aIaj4SOkPdjooFsQSjOuq+At2TA7PUf6wC2Lp19y5gKyOj7f5yVMYsu2BRka2I6Tv+crjarZK+20imwWMpMIHjfFfhGlFsljFj11y+pzjWd0c9BBwjSq26thj0x8fPCQXBE7cvb5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4379.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(396003)(346002)(39860400002)(366004)(136003)(6486002)(8936002)(66946007)(956004)(316002)(54906003)(8676002)(16576012)(6666004)(26005)(83380400001)(53546011)(52116002)(31686004)(66556008)(4326008)(2906002)(66476007)(5660300002)(478600001)(31696002)(6916009)(16526019)(186003)(2616005)(4744005)(36756003)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: N6FYrnWQQJm0FoO2kdsDjI4yVG4kfvY0lb/hITPCCZGSxqMpV2zEmPiea/vizkVn9pYzKzCV+0lbeIJkwHIhPFQbf9aQn6GQ2C/PVubUshJfQKyp8Q+jLWG2aNkHpbPj+tABW4WUSH6H6187h+sTqBEgiJi8nLYe1xL2QAuyfKbSVtI1dQ8KJ+J069nnVMRjKicoHZvXuDXz88IyPww517eF4KkfH0doJ8YRkzGmxLTvebG8Ob42tTbbfl/IMjhEyYftHM1pdRbxB7XHYyUuyG/qpBTrKCXKU1ICg/ox1lCQKL2UhJAwXQqx3xOd9CumOqETxD8o4gzzS+mXUVHOxmQPvwylHuRsy+sE+/zRflhc1d0tOH72meys3hnfiCz2NI45aXFb6k2DLf/jFmNOlmiiWXtD3EL+bi9ZCsssfK+EmRplZnRYq8cdNXrln26YUU2ezJP4kWvFLmhMOwDqT4ZrbNhml3OezeEOmUEPgDY=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad40f2cb-f9ce-4533-3b8f-08d803130742
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2020 14:25:53.5153 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ONNpm+lEZeBdArmeAPIu8TQH/v8u3etghPfsowfcVUJ9s8nYigZVss/G0FxDjyIOi/+GdAIIk4zDLnrHyvva5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4427
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
Cc: Hersen Wu <hersenxs.wu@amd.com>, Anthony Koo <Anthony.Koo@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, amd-gfx@lists.freedesktop.org,
 Michael Chiu <Michael.Chiu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2020-05-28 10:13 a.m., Alexander Monakov wrote:
> 
> 
> On Thu, 28 May 2020, Harry Wentland wrote:
> 
>> On 2020-05-28 9:54 a.m., Alexander Monakov wrote:
>>>
>>>
>>> On Thu, 28 May 2020, Harry Wentland wrote:
>>>
>>>> This reverts commit 96cb7cf13d8530099c256c053648ad576588c387.
>>>>
>>>> This change was used for DCN2 bringup and is no longer desired.
>>>> In fact it breaks backlight on DCN2 systems.
>>>
>>> Reported-and-tested-by: Alexander Monakov <amonakov@ispras.ru>
>>>
>>
>> Thanks, Alex.
>>
>> Just to confirm, this fixes the backlight issue you were seeing?
> 
> I applied a similar fix to my kernel yesterday, and it worked fine.
> Tested by changing brightness a few times. If any problems come up,
> I'll send new reports.
> 

Thanks for the confirmation.

Harry

> Alexander
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
