Return-Path: <SRS0=qtCw=7K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F459C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2020 14:07:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 379CC20721
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2020 14:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VL20Kliw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 379CC20721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C67EE6E581;
	Thu, 28 May 2020 14:07:03 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDA366E57E
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2020 14:07:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oAP6DDD1x9bxYs3iZArcJanrRCNCf8ZgFpeLKzpWdV1DqlGAleJXSnpRV188nojewCPoLYzF1RRALZnpKSCCqa/Vbvtr1bhp+efZKuKWC7gaGM7RYyhoVY6877Jp2iMl/GTWlxKt3p67J0qXb32BHbheW6BT4jxcVso/gJt79T9MHkSNvypEd2wkrqOReefcykMf+CjxMkOdgvUEAY1q7NgziyFdfCtSPAQyyc2JMNXWhWw58v6Y2mlkomIWU6u2G44Ze+g9c4HgoPDkP5l4gRCXZBMAcnM/qlwiL7JpMDxAs6DEQzam1AGCcpJnz7PyL8nX5mxxTgo+nc2hwrDl7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ebAYddjRsnSc6oFEcqCiNCjAphrlYnQZslKgRB8+17Y=;
 b=YtYMFw+IfnYYJZERkoFxBkloG5RQMv/YSwuweu2A4ZP+p0Ql2v4bxWoxYhuxT9WSc84FnaHx5b+9m4yEktVReyj7epVy0L5DXLKc++TGPPrpnOG0AYOyrKc7uhndIG806IQHbHaQmg+vJSkJDqvczRDy19GoUrBvDLNI0ZHmgE5ci+l1cGf9L8+EQDheVkOvuqzUhKEyGv9423zZe3fKqGsVdLtcravHEDHZl4kaYGnr0YZYN+jdv+l8WG3/wODXShIkRww4N0/JHFfM5AM4ZzGkpPCVdhVLSy3C18sWU60heKIt7zKkrziluWjh/W1rt5uBkIwBa6LWnEq52YU76w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ebAYddjRsnSc6oFEcqCiNCjAphrlYnQZslKgRB8+17Y=;
 b=VL20KliwCMlQt5WXnGeedYqzYE87938AoxA0mqoOZQluTQevcExnhlgWHtEI/maKYghFIZDkeaebD39ngXx9u4TQLQh4kIe8mQB2yP8IUdin0xJxa2MIFY/+iWSvHnB/1GU8+5hOPAda0twD0cE/QRCP205xFGZtrZ9SodNxG1Y=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11)
 by MW3PR12MB4361.namprd12.prod.outlook.com (2603:10b6:303:5a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Thu, 28 May
 2020 14:06:58 +0000
Received: from MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::31b7:9b4e:3f37:5e97]) by MW3PR12MB4379.namprd12.prod.outlook.com
 ([fe80::31b7:9b4e:3f37:5e97%6]) with mapi id 15.20.3045.018; Thu, 28 May 2020
 14:06:57 +0000
Subject: Re: [PATCH] Revert "drm/amd/display: disable dcn20 abm feature for
 bring up"
To: Alexander Monakov <amonakov@ispras.ru>,
 Harry Wentland <harry.wentland@amd.com>
References: <20200528134807.5665-1-harry.wentland@amd.com>
 <alpine.LNX.2.20.13.2005281652440.18802@monopod.intra.ispras.ru>
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
Message-ID: <fc597b5e-147c-2a90-d7c7-bd5b01cdcfd2@amd.com>
Date: Thu, 28 May 2020 10:07:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
In-Reply-To: <alpine.LNX.2.20.13.2005281652440.18802@monopod.intra.ispras.ru>
Content-Language: en-US
X-ClientProxiedBy: BN6PR08CA0061.namprd08.prod.outlook.com
 (2603:10b6:404:b9::23) To MW3PR12MB4379.namprd12.prod.outlook.com
 (2603:10b6:303:5e::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.7.175] (165.204.84.11) by
 BN6PR08CA0061.namprd08.prod.outlook.com (2603:10b6:404:b9::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3045.19 via Frontend Transport; Thu, 28 May 2020 14:06:56 +0000
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 279d3c00-0021-4318-2927-08d803106234
X-MS-TrafficTypeDiagnostic: MW3PR12MB4361:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW3PR12MB4361EE29AFFE9CEB0A6744868C8E0@MW3PR12MB4361.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:489;
X-Forefront-PRVS: 0417A3FFD2
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yXmYb7NNWnwapcLKsL/mr2lbOznCwFWBmsHqmc+n2BuvZy35HvknOoM+aeyk6N+E0qmLDbktqcrO6mqQdW75ahBF/ejM9sjOYUXaiXLcWG1Zfq6vuNpR9TjHxqlQbY00tKqtXx5dhx6DGnFkQKw/8SFJdCj3V5pH0Fyjfa2iIHAlwINbHmdWc9NVD5wJNI9qdFuDbua7XKKhH5fAMjeTF3CEp4QCnbp3X86NR5yAf1Xd2AuyqeXqbQ91P2emcQBsOjeUbxS/sjDDpqC4Mdgqt4GvVFliC33sTLl69+nNwGHBWvvNziCPBNB1F45feWW2W+dHjgNUzQjdPZME6Lfl5kUKLVRL2prUiKCvuCozKZnwLhZneH/7sK7b4FK4CaDV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR12MB4379.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(376002)(346002)(366004)(136003)(396003)(26005)(52116002)(54906003)(6666004)(16576012)(110136005)(478600001)(66556008)(66476007)(2616005)(5660300002)(36756003)(956004)(66946007)(8676002)(53546011)(186003)(16526019)(83380400001)(31686004)(4326008)(31696002)(2906002)(8936002)(6636002)(6486002)(316002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: mMu8Cllj0n2VU3nYVPn5WFnR3oTA9kR8jKx1veY7AHD9zP5kH0sWsMoG+lvo8BUn+LPhE0Ha76ciwW8jK/tswLW2Krh1Kd6huhJu4npagzctplUQliQf6PX6bRHuSDOh5zTe1sAJ1v+T4XLU+0V5PYh7VmN59MH19tpw1jowkNUZ1NxykXakYKabWRD2FYdmN3n3LZOV49WkZRmHN9pp/ZUIr9TgKayqJhsUe85/x0+Scax2fXQXcjhUWycIx2SUxdzbR8y2qD8M+/PT4gG1SYgQJRHX1dWNDsfrQvarl7+VRgw3lkJwd0ZNFnuF8rmtAD7KWPIShNQPoMyd6o+Whv0xwnlxbBvSmWDzfIx+e7Xft4ZSQ+Tt8alLgQ+VKH3zdXOXwiAMJa2yJx+d8vSZR8hdjkSfWnniq7oRpL0d0HPPqyBOEvId7gTT+szy134kvTdPIXgZqHsbrzG/0S5w4fIws2K8lxj2SI8HWoF43oA=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 279d3c00-0021-4318-2927-08d803106234
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2020 14:06:57.6752 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cM8O/x6Akam0RtF8l6T4H9LKpF3ta2Y+bEB2y0SaMDORWJODO8EHUL+Reikhubv87SgWilL9I0fGpafwn5xSBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4361
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
Cc: Anthony Koo <Anthony.Koo@amd.com>, Hersen Wu <hersenxs.wu@amd.com>,
 amd-gfx@lists.freedesktop.org, Michael Chiu <Michael.Chiu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-05-28 9:54 a.m., Alexander Monakov wrote:
> 
> 
> On Thu, 28 May 2020, Harry Wentland wrote:
> 
>> This reverts commit 96cb7cf13d8530099c256c053648ad576588c387.
>>
>> This change was used for DCN2 bringup and is no longer desired.
>> In fact it breaks backlight on DCN2 systems.
> 
> Reported-and-tested-by: Alexander Monakov <amonakov@ispras.ru>
> 

Thanks, Alex.

Just to confirm, this fixes the backlight issue you were seeing?

Harry

> Thanks.
> 
>> Cc: Alexander Monakov <amonakov@ispras.ru>
>> Cc: Hersen Wu <hersenxs.wu@amd.com>
>> Cc: Anthony Koo <Anthony.Koo@amd.com>
>> Cc: Michael Chiu <Michael.Chiu@amd.com>
>> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
>> ---
>>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 11 ++++-------
>>  1 file changed, 4 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index ddc979e3eebe..acd4874e0743 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -1356,7 +1356,7 @@ static int dm_late_init(void *handle)
>>  	unsigned int linear_lut[16];
>>  	int i;
>>  	struct dmcu *dmcu = NULL;
>> -	bool ret = false;
>> +	bool ret;
>>  
>>  	if (!adev->dm.fw_dmcu)
>>  		return detect_mst_link_for_all_connectors(adev->ddev);
>> @@ -1377,13 +1377,10 @@ static int dm_late_init(void *handle)
>>  	 */
>>  	params.min_abm_backlight = 0x28F;
>>  
>> -	/* todo will enable for navi10 */
>> -	if (adev->asic_type <= CHIP_RAVEN) {
>> -		ret = dmcu_load_iram(dmcu, params);
>> +	ret = dmcu_load_iram(dmcu, params);
>>  
>> -		if (!ret)
>> -			return -EINVAL;
>> -	}
>> +	if (!ret)
>> +		return -EINVAL;
>>  
>>  	return detect_mst_link_for_all_connectors(adev->ddev);
>>  }
>>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
