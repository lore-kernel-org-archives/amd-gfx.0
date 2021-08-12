Return-Path: <SRS0=1H3f=ND=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82AE4C4338F
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Aug 2021 20:22:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 420EC60C3F
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Aug 2021 20:22:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 420EC60C3F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A99A96E471;
	Thu, 12 Aug 2021 20:22:55 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7D7A6E47B
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Aug 2021 20:22:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oeZBi0XJGKNioTvY5vSluDZvQThOSScbkau68NIuhBesSR5tPILaZdPG+nOpjkYKacT/6rck13SQYayuJAtYk70yiIOUvjZyvCK5L5jbKdB1EpObObYwc8Sb4lWJGDn8hwJqh/wNMjTDoTZByizSJGMgViAL3O+7eRUxdh7J/AcEEZG0KfP8EaxBLlpITFoc6ALvIhT3SyFBF01vR2kRj2nH+REMJuvW7DEsn/I29fGoJzubFaAda4Hbg00U4SyQVN0R8J9N96mS1L1W+0XOM3f77hhFQU92QwQ6Vnh6fj+q/TJ2YJvrKe1P5DfjYki1Rj0DLwAyiVJ3c0OgK5Kbwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lPz5znfei7990PNZMEYsi30HstBM4lbiiUIVvPT4Uoc=;
 b=k1kIIti3QJehAv7cuCdt0NE++NTKB1YHH+UkR7+IT2uGiMgM8mv2qv/zWYDCpkOt8qNjcFJwSpOufGx1ZZo6Rug8VHZlu0E2Zk2/00Vb5fTGaVsQYFScq6dVCUf3dFHzlWr0a49iQYSkLSVzaCv/m785MiQ4uP9d1Stx26HrxDrUsZSIlS2H07YSSWcHumbaf9MM0JLhnL4sf0IRxabZ1cUNF03GjkHGj/TEkZK6WW93NiF1YmXU8CqUIQlkKSITEe/APspQsXEnvJh7jClHGAl6mICHxmvA6GD5U7/B8z0Jp6Yhl0HiEpevr6FvrxILphVzSGRjoNZUt8N0EgQ8XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lPz5znfei7990PNZMEYsi30HstBM4lbiiUIVvPT4Uoc=;
 b=Tv92SWXfhV9G5NPLYYBeet3YVJHY0ic2rLIJtd8ZO6qOtF2Kz5OlHnh8cMK4fG455LBfqF8fqZZND69q234hJbJw5H1cbsD/XlB63sRvVqbSnhSjL12Y6TMmEzGq5wewYBllXfkR7gKyAOdlicjkBjTXdX7kF4YiDCQftzEHXvs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5225.namprd12.prod.outlook.com (2603:10b6:408:11e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.13; Thu, 12 Aug
 2021 20:22:52 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::b891:a906:28f0:fdb%4]) with mapi id 15.20.4415.018; Thu, 12 Aug 2021
 20:22:52 +0000
Subject: Re: [PATCH] drm/amdkfd: fix random
 KFDSVMRangeTest.SetGetAttributesTest test failure
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20210810044310.3805858-1-yifan1.zhang@amd.com>
 <a07e70af-4ab8-a359-480b-d348755cbfd2@amd.com>
 <BYAPR12MB3416A20073AB5277FEB144CEC1F99@BYAPR12MB3416.namprd12.prod.outlook.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <edd0acb4-259d-ed24-4766-a1d9c07853a9@amd.com>
Date: Thu, 12 Aug 2021 16:22:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <BYAPR12MB3416A20073AB5277FEB144CEC1F99@BYAPR12MB3416.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT3PR01CA0110.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::22) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.182.144.73) by
 YT3PR01CA0110.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:85::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.14 via Frontend Transport; Thu, 12 Aug 2021 20:22:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21a4851a-a1e7-4597-cbcd-08d95dcef5bf
X-MS-TrafficTypeDiagnostic: BN9PR12MB5225:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5225010A81C7EFD889BC642992F99@BN9PR12MB5225.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WYp+YpEi+dP6Rda4nRgNGO7Ctn6TWdbv0dJgDzrHmctQzapRKUvcKKIDZ7x+clKk0XT7P2wirNoMQV7+5n0l3HFqQUZWM1jLmfOYFqu2ZoVLCYS0n5bFrcALHzU5DBThilfqVTgTVpnPhMi/ynQiqygi+XcZKspDFs0CNlovsFpqoZ8rm1/Mv47G9eNJpMgbDFAvAPd8oiE11fGw9K4Cy2wUEp7tWfw8AQW/sk4YWdbRh8/EfRP4wRvSYHK1rOAzBvjX8j0nKs/ncLc36XHM26Br3PptaDPppIn6WRWAkRbjCAZa/JxdkbfSw2YjTuADhCtCP38Zeb7svfChZs99kt9rcRr03ezzhmUY6gq/kNRt5uKf7AeKvHf4eCPjNi83E5KtNTEG47HSK4GxntObW8tw6FGBCFG0B7dwGnXBujlVHurSR3/CF1qKXvUPHAFdgWUxCNaFHysmjlEfpJJz48fV1HUn4mketqfGBDCgHVVP8Z7K5z1eIt10qLv+KZIp9Px6jiLfeM/+zSIr6RIkD58BwunDaAa5fHv4R0OO83FNbYcZUTjWkkZ6YNCRzPnYlCBc7O0qodMONQmJFNH4UESH8eJ4QcASckDeThMPqMuSjbTxE3fprNpIIKbuwbGh5i3Xj376fKsBVYn8nMeShFPC869dWuc3st6vNmavdiBCKU8SjMa7NBdmVLpIArfK3I/6aGJIqUhSHL9HssWwkzbjTfR923TfNot6ZZ+TkhGmOBD1Cw8rXVW5HBPNy2uf
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(376002)(136003)(366004)(39860400002)(186003)(31686004)(110136005)(38100700002)(83380400001)(478600001)(6486002)(16576012)(316002)(2616005)(2906002)(53546011)(956004)(8676002)(31696002)(5660300002)(8936002)(66556008)(66476007)(44832011)(86362001)(26005)(66946007)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3VQeldIdnU1Sm5CaDF2V0VHcDlPQjdkVklpcEdkL0JteGRXbWh1ZnhYYjF2?=
 =?utf-8?B?MXNBK05VdUxvQ092ajlQQUdDL3MvdThPL1N2NTZ0U2Fwdm82eWRuZ1k0c3hF?=
 =?utf-8?B?OU9hWmU3eUtGZXNwME9BNllBQ3l3eXNxWHNyekt3TVBycWhSTHRXSCtCMndp?=
 =?utf-8?B?Tnk4Rm1icTA0dU1CWk9IK0JvMjZydlBERVBQejEyZTc2eWU2Z2FZbWlSVTF5?=
 =?utf-8?B?b3lVcm1kZmQyMCtXOXoyZzlFeGVOa3pnaDA0L0NWT0Y4NHpOcUdNeGY0V0J5?=
 =?utf-8?B?dGMxSEIreC83OVJpRmR1dDRxYXlkRDlrYVVYOHU2Q0E3T3I3ak9SWmpEM2JD?=
 =?utf-8?B?MERNRVpXa1NFbmNkUkFvS2lSeUNWSjRJdGNITzFBdUxzc1lWaW82bUk1TjA1?=
 =?utf-8?B?NFNUbjBUNFJnaHBkVXNmYTlqSHFoVG5SbUgvMUxYR256dEZ5N1lPcUxIWWhV?=
 =?utf-8?B?STdzOUtXWXFOeUNuRnowWDlnZXlpSUVNSXU5OEM1UDVpeCt5cE9LUzNLWTF2?=
 =?utf-8?B?RWh0a3NJOU5QdDdBeFk0ZTVZazE2eGZJY1N0dUlVR0JJU3NNT2h6cldvSFJ5?=
 =?utf-8?B?MHU5NmJXNHBwcUo0a1p6bCs0Y3E2aVYvU2kzeUU1REEvcVBjdTIxZUdicjJo?=
 =?utf-8?B?OVB5NzBzd2FOYXhzUzQ1eGplN3BYdFp6UUU4Tmh2ZmpXcFdBbXAzR2JOalJw?=
 =?utf-8?B?N29NZXIydzJIZ20wOHgyM2JwK3hmZ1dWZWFFSkR2RUVhcWYwWmZ6THpYcHA2?=
 =?utf-8?B?RWVhUE8vL1JJNk1hOWp5U0tYak9ndzJZUDQ1Nno1SWJ1VU8rZitxZXZyOUF1?=
 =?utf-8?B?NkFOYS9ka1VYRXd1MUg0TC9GNEVDcS8xTVE0QllQZURBT1FvcksvY3BhMDhE?=
 =?utf-8?B?TXZ5RU9rNjVodjVBenBwM0tNTGlscVNqSVk4TmwzNlFIYm1RQU5HN0ZWVUVq?=
 =?utf-8?B?aFphbDcxQTY4VCtKSFRhYWpkeTFQT2RlcjRZdmJnemV2TllhSzhuVDJHSkE3?=
 =?utf-8?B?R0ZhWWFPSTYxdThRd0lNWHYyZmVodDFqTWJ0cmVOQldESytFUi8xVGREeVRt?=
 =?utf-8?B?VmVVNUo1YUc4bDFiZXZ3aTVrcE5VNm1lUTFwSDV1dkNobmN1TGpzZUJCVDha?=
 =?utf-8?B?TGF4VTArNVpONUhXclp4T0ZEQ0JIRWJ3SDRLQ3d5OXRlaUFCMTgzTEQvSmJ2?=
 =?utf-8?B?RkE0Yzg0U1Zua1U0Mk9uU29JRDZTZTllcE1ocnpwMTQ3ZXBrOUxWTko0clI2?=
 =?utf-8?B?UEVNNURSYmQ3MXRLK1BCc1lXVkluL2VocWM0MFhrNmlVVlNDV1Q3VEU5SXoy?=
 =?utf-8?B?N3BxZERrNzljSW5LZHBtNDNyQlJ3SjNJbXVHWHk2VGZFVEh2V2xKekZ5QUVy?=
 =?utf-8?B?bzY2dFU2N21ndDl2TnE5VW1LMjQ4bXJYU21WTzQ2WENkWFArNGxvMGU2ZmZS?=
 =?utf-8?B?UnRpWVlRR09UakRTbkIwcGwzSzBmOVhkeDFmV2RzcmdGM0dNMjB1aUsxdml4?=
 =?utf-8?B?N0xJbEwrdk1RMFllbWNWOEVoQ3gySGprTU1ONDZMT1dVNW1ISUZxM3FxV1Rs?=
 =?utf-8?B?OU8zTDE3cUFJVjlKNmpaUzcyYjZzendYeFY3aU5veHN1WitqV2dHZnhsMlJv?=
 =?utf-8?B?NmpDU05PYkdQMWJEcG12cTVPZnRxbWxUbk9VWXpNaW1FQStLaFMzTVFWWDR1?=
 =?utf-8?B?ZTVId0tZNS9tMThtZzQ0SU82d1RGd3JGejJJNFJWNEdlQ3VueXY5YUFhTFEy?=
 =?utf-8?Q?YpNNjiJLID2YZnSZM2u15BzTs8sQgx0TLqFXPQY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21a4851a-a1e7-4597-cbcd-08d95dcef5bf
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2021 20:22:52.4159 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nzIr1Quz4uQlePCB7rznvnN/Ydgy4XQK7H6LZEx3P5ZK7mdUOE7UDIfkWEzpzA0Yv4Ye4OMnG//GBQsGKM2pVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5225
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2021-08-12 um 11:49 a.m. schrieb Zhang, Yifan:
> [AMD Official Use Only]
>
> Yes, it is a sync issue b/w SVMRange unmap deferred list and get-attribute call. There is time slot when Process vma has been unmapped from CPU side, but prange is not removed in deferred list. If get-attribute is called  in this time slot, then there will be a problem.
>
> This issue happens when KFDSVMRangeTest,SetGetAttributesTest runs after KFDSVMRangeTest.BasicSystemMemTest test.
>
> TEST_F(KFDSVMRangeTest, SetGetAttributesTest) {
>      TEST_REQUIRE_ENV_CAPABILITIES(ENVCAPS_64BITLINUX);
>      TEST_START(TESTPROFILE_RUNALL)
> ......
>      HSAint32 enable = -1;
>      EXPECT_SUCCESS(hsaKmtGetXNACKMode(&enable));
>      expectedDefaultResults[4] = (enable)?HSA_SVM_ATTR_ACCESS:HSA_SVM_ATTR_NO_ACCESS;
>      sysBuffer = new HsaSVMRange(BufSize); // It returns the same addr as the last test case since the addr is already munmap for CPU.
>      char *pBuf = sysBuffer->As<char *>();
>  
>      LOG() << "Get default atrributes" << std::endl;
>      memcpy(outputAttributes, inputAttributes, nAttributes * sizeof(HSA_SVM_ATTRIBUTE));
>      EXPECT_SUCCESS(hsaKmtSVMGetAttr(pBuf, BufSize, // This is the problematic get-attribute. It returns the the prange attributes in the last test case since prange is not removed.
>                                      nAttributes, outputAttributes));
>
> sysBufer address is an unregistered SVM range. Thus hsaKmtSVMGetAttr should return the default attributes. But there are some corner cases, deferred list from last test case is not finished when get attribute is called, so svm range list remains the contents of the last test. In such cases, hsaKmtSVMGetAttr returns the attributes in the last test instead of default values. (The two test cases are in the same process, mmap in HsaSVMRange constructor return the same addr) and makes test case fail.

OK. Thanks for investigating further. I think your patch is the the
correct solution after all. I'd just add a carefully worded comment:

/* Flush pending deferred work to avoid racing with deferred actions from
 * previous memory map changes (e.g. munmap). Concurrent memory map changes
 * can still race with get_attr because we don't hold the mmap lock. But that
 * would be a race condition in the application anyway, and undefined
 * behaviour is acceptable in that case.
 */

With that, the patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>

Regards,
  Felix


>
>
> -----Original Message-----
> From: Kuehling, Felix <Felix.Kuehling@amd.com> 
> Sent: Tuesday, August 10, 2021 11:57 PM
> To: Zhang, Yifan <Yifan1.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH] drm/amdkfd: fix random KFDSVMRangeTest.SetGetAttributesTest test failure
>
> Am 2021-08-10 um 12:43 a.m. schrieb Yifan Zhang:
>> KFDSVMRangeTest.SetGetAttributesTest randomly fails in stress test.
>>
>> Note: Google Test filter = KFDSVMRangeTest.* [==========] Running 18 
>> tests from 1 test case.
>> [----------] Global test environment set-up.
>> [----------] 18 tests from KFDSVMRangeTest
>> [ RUN      ] KFDSVMRangeTest.BasicSystemMemTest
>> [       OK ] KFDSVMRangeTest.BasicSystemMemTest (30 ms)
>> [ RUN      ] KFDSVMRangeTest.SetGetAttributesTest
>> [          ] Get default atrributes
>> /home/yifan/brahma/libhsakmt/tests/kfdtest/src/KFDSVMRangeTest.cpp:154
>> : Failure Value of: expectedDefaultResults[i]
>>   Actual: 4294967295
>> Expected: outputAttributes[i].value
>> Which is: 0
>> /home/yifan/brahma/libhsakmt/tests/kfdtest/src/KFDSVMRangeTest.cpp:154
>> : Failure Value of: expectedDefaultResults[i]
>>   Actual: 4294967295
>> Expected: outputAttributes[i].value
>> Which is: 0
>> /home/yifan/brahma/libhsakmt/tests/kfdtest/src/KFDSVMRangeTest.cpp:152
>> : Failure Value of: expectedDefaultResults[i]
>>   Actual: 4
>> Expected: outputAttributes[i].type
>> Which is: 2
>> [          ] Setting/Getting atrributes
>> [  FAILED  ]
>>
>> the root cause is that svm work queue has not finished when 
>> svm_range_get_attr is called, thus some garbage svm interval tree data 
>> make svm_range_get_attr get wrong result. Flush work queue before iterate svm interval tree.
>>
>> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> index f811a3a24cd2..192e9401bed5 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> @@ -3072,6 +3072,9 @@ svm_range_get_attr(struct kfd_process *p, uint64_t start, uint64_t size,
>>  	pr_debug("svms 0x%p [0x%llx 0x%llx] nattr 0x%x\n", &p->svms, start,
>>  		 start + size - 1, nattr);
>>  
>> +	/* flush pending deferred work */
>> +	flush_work(&p->svms.deferred_list_work);
>> +
> There is still a race condition here. More work can be added to the deferred_list_work after the flush call.
>
> Work gets added to the deferred_list asynchronously, for example in MMU notifiers. Trying to synchronize with asynchronous events is inherently problematic. It appears that the test is making some assumptions about things happening asynchronously (page faults or MMU notifiers) and that's probably a problem with the test, not with the driver.
>
> Alternatively, there may be a problem with a set-attribute call that leaves some operations on the deferred list and results in unexpected get-attribute results. If that's the problem, we may need to add a flush-call to the end of the set-attributes function.
>
> Can you provide more details about the exact sequence of set-attribute and get-attribute calls that is causing the problem?
>
> Regards,
>   Felix
>
>
>>  	mmap_read_lock(mm);
>>  	r = svm_range_is_valid(p, start, size);
>>  	mmap_read_unlock(mm);
