Return-Path: <SRS0=nWm5=BC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74534C433E3
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2020 14:19:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12AB420709
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jul 2020 14:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="p4m1tEjT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12AB420709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B76EF898D9;
	Thu, 23 Jul 2020 14:19:34 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35092898D9
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jul 2020 14:19:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GArMxHepThtauj7lcx+26HdcAyu3YW2JVvhEcNQ8hz22Dh2WhGcFfYCEvSuTcf2PF3ZOVqwNrAsDyHd1uKaHbo5o8s14HHqyqsrZ9QHP0qtUh5krnAgNZlZ4Vk8X5TUFJNh4rnUiA2XyidC1YEhsSYk3wsrXRCyWFams2U7fquDU44T4eEqXtEEDIWqzJf6D1PnOa/zcHNyuZKXdPDX4EaU25C4ictZHoc8HEs2RneQ5ewdcJQ2Z2vgyraTKHbpma0il23LPi1OXgbFw2bXaQ7fPmWWb3ecHEWSxR17UAMHFx60WrAeXS8oWmmMYjAWqZqZIwrB6CRTV6FnDM+CixQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W4U+AlJwYPK2nXCa9GQSQaLhe01g4AynLbAUyQJgQJE=;
 b=SfqMuStWf85j/zRDv6RLMyRxMKiHLr+dSi6VfGOlWrjM3+cOFTOc9vkZngvFVy72HWcwLbxVWC1ZyrkrgAhhfDQ6xSYP+JCcU5cnH9iJwFIhl/ZhDvqVOinehwB8nBcqhhGaxEE66pBcdmZWL+ldlfhKyAblKBKlEMJ8H12DZUpkwtJN1LuaL0VEphZSur0sLk4tC7UzkuoczwOUGhh8tyDMlTFVWRKcNhXwMQdCPres6gefE4mFwaMFde8iIXFULJcAd+iJl1G0EDdh8TcruBi28hpLsxkM30vQ+6Qk2Yd/8rEOMI5tujKDpvtMSQpM0OVivTUc4DgfL+bq7NAzIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W4U+AlJwYPK2nXCa9GQSQaLhe01g4AynLbAUyQJgQJE=;
 b=p4m1tEjTbPogHrnpyD7ywEaTJzDHqoZnytt2xpdYE47jdwQzc+dYAMZ1CJU9GF83PaDqYLgRHirJzwVGbVKKen0JfHaI9hH5GRImkq0mjySK2mWOi75jngylJb5GSKFtgcncHueV+CBFUiWkbNzpygYhB2hQ3933YacF73k9pW0=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM5PR12MB2375.namprd12.prod.outlook.com (2603:10b6:4:b3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20; Thu, 23 Jul
 2020 14:19:33 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::e14d:37fb:a0ca:aa81]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::e14d:37fb:a0ca:aa81%7]) with mapi id 15.20.3216.023; Thu, 23 Jul 2020
 14:19:32 +0000
Subject: Re: [PATCH] drm/amdgpu: do not disable SMU on vm reboot
To: Alex Deucher <alexdeucher@gmail.com>, "Quan, Evan" <Evan.Quan@amd.com>
References: <20200710145047.52383-1-nirmoy.das@amd.com>
 <DM6PR12MB2619AD3F3A4ACB3221558162E47E0@DM6PR12MB2619.namprd12.prod.outlook.com>
 <CADnq5_P6Za6B3SStz-REdyDdarOtPPw7qTHdRGFn_14gohnkgw@mail.gmail.com>
From: Nirmoy <nirmodas@amd.com>
Message-ID: <1b485311-84b4-c8ce-6368-3a0534ef0fd3@amd.com>
Date: Thu, 23 Jul 2020 16:22:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
In-Reply-To: <CADnq5_P6Za6B3SStz-REdyDdarOtPPw7qTHdRGFn_14gohnkgw@mail.gmail.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR04CA0124.eurprd04.prod.outlook.com
 (2603:10a6:208:55::29) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.87] (217.86.122.24) by
 AM0PR04CA0124.eurprd04.prod.outlook.com (2603:10a6:208:55::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.23 via Frontend Transport; Thu, 23 Jul 2020 14:19:31 +0000
X-Originating-IP: [217.86.122.24]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 64ddecb4-4560-4818-d851-08d82f136b3b
X-MS-TrafficTypeDiagnostic: DM5PR12MB2375:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2375174AE7BC363623ACF2E08B760@DM5PR12MB2375.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CzVQZLq9cN78pdj855DzLcq+pIH575TwEjYXRCN+6mVqk0JizF+tzAZtevppm/YwC5QmGVR/WhyUwszH+LH6zuoKb0BmuzQGhF/oZHUEi1OIfo/JOQgnONUynRkvR20vjRc/5Wm0VNuSvDQkmbDkOZ7me8SIsbHIyfr6bXxa9g5kJj7mSmsNfU/31pSndapxr1S43M77pk9fqST4XQLoDnpfMjYpnM5u04yhEltClO6VdfE+2e44J0LvPVx1+8SKMSWQ9T3+unwML5RyjigZQSpE6uD4b7Ux70dy9mTOnZluQrB2WzUzlUbUsU/GC0xO8RsD36A+U8Qi0jGdSGSovsbgf6avJoIR92DV3VHBHsWYF4CSBiPVzA/o2ZFiF/PbSx76ozaJk0nRf0E+Cozt8y+Nabyt/7fb8ixAcuwaRXM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(136003)(396003)(366004)(39860400002)(4326008)(66476007)(66946007)(8676002)(6666004)(36756003)(2616005)(66556008)(956004)(31696002)(8936002)(31686004)(316002)(6636002)(186003)(16526019)(26005)(83380400001)(966005)(52116002)(53546011)(6486002)(5660300002)(478600001)(54906003)(110136005)(16576012)(2906002)(45080400002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: zhAJIMfeWjcKwg0/nzNlDOF88eCnSFSMJy+c2KRitmgNzbhXJbm3i9FokMzlhN4jkTQGdj+rrdUhVmkyDAZfPB6feb228+bmmLUlYfcDUnGw+O0PlHMmFDwNHb//xkwiX4SKY5Nb8FtwaDe5vKUyfcFJEfEvQlxsSyvWLKNxJdFZP270gMSusEYARC2Sd+uY2gYTSfh8ewJvBS2PCtiXaurfao/0SlULY+mejIWMEwND2JWLkQf9IBLxFzE48ItKBB8VGgD3URByIkGuxDeo+2sK7KI07WVhSEfuC6c/wYdb7vfE5vZuen0wk+xE2PHDRtL32CM2gqJw258fZLKrPdeY7eAGayiwZuJSX36PlZ4SCCIXiUPbwQmhmYL2Z/O3PAZ5yPT5gKouykeCSONLg0TI4Nx9YxJa8GRn71OAf7oUtFh4croWe56AjOaGJeWtY7JHrmbuxZPXAI9+VzzX7QjeYQyGEPkuem9ueJAW9w4=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64ddecb4-4560-4818-d851-08d82f136b3b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2020 14:19:32.7120 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nFQD/5pU8Ya7goSsW/mp+pKUCpYL5ivITavGcGur4+borEfrx/B2fthRvdxD6tt7mZhQlmB+u3W3Z06Jx+V9Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2375
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Das,
 Nirmoy" <Nirmoy.Das@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Alex,

On 7/23/20 3:59 PM, Alex Deucher wrote:
> Can you check and make sure this doesn't break polaris or some other generation?


Do you mean breaking device passthrough or normal operation ? I have a 
rx 570,

I can test on that.


Regards,

Nirmoy


>
> Alex
>
> On Wed, Jul 15, 2020 at 1:12 AM Quan, Evan <Evan.Quan@amd.com> wrote:
>> [AMD Official Use Only - Internal Distribution Only]
>>
>> Acked-by: Evan Quan <evan.quan@amd.com>
>>
>> -----Original Message-----
>> From: Nirmoy Das <nirmoy.aiemd@gmail.com>
>> Sent: Friday, July 10, 2020 10:51 PM
>> To: amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Quan, Evan <Evan.Quan@amd.com>; Das, Nirmoy <Nirmoy.Das@amd.com>
>> Subject: [PATCH] drm/amdgpu: do not disable SMU on vm reboot
>>
>> For passthrough device,  we do baco reset after 1st vm boot so
>> if we disable SMU on 1st VM shutdown baco reset will fail for
>> 2nd vm boot.
>>
>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index d1adbc45d37b..07be61ce969a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -1178,7 +1178,8 @@ amdgpu_pci_shutdown(struct pci_dev *pdev)
>>    * unfortunately we can't detect certain
>>    * hypervisors so just do this all the time.
>>    */
>> -adev->mp1_state = PP_MP1_STATE_UNLOAD;
>> +if (!amdgpu_passthrough(adev))
>> +adev->mp1_state = PP_MP1_STATE_UNLOAD;
>>   amdgpu_device_ip_suspend(adev);
>>   adev->mp1_state = PP_MP1_STATE_NONE;
>>   }
>> --
>> 2.27.0
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7CNirmoy.Das%40amd.com%7Cf4018ca31bdf481e0bba08d82f1096b8%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637311095591342103&amp;sdata=PvRVEMzHPeQnQC%2Bf7DI1Y3vnEZLnp9Af%2F07KAIQjKsM%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
