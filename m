Return-Path: <SRS0=2har=LE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29D06C48BDF
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 22:26:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9C6E61181
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Jun 2021 22:26:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9C6E61181
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B7516E461;
	Thu, 10 Jun 2021 22:26:33 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 726BC6EE09
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Jun 2021 22:26:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gj2pZim2STxyvxwJC0oOlnDBOc9IF0pMJ4Q3sGv4hagmizkP0No4mFxtmvRAcZCNdyeYdfjGHrMTymboG67WK1qjUWe+u9XsF9IxRF7zaf7lMiQwdmTLTqm/9NbbXeGQyrEa0gsUD5s3zDpfDt/Vb1lPQtBGjow3k/2pU9G4OGoAinnPyZSZeOB8xx0fjPDhmxv8WjNT5zbOW+tbF5YLmMzk3gD95H7mUAba6bmMBBpa/SgDAdBTs/9YbvwuQxZLPIEjSAsd0okD6felNUIv46bYP3sbZIhyjeGnOSa1+9GYViZmxd5AoJOztsTRFTItodrG9qDaI3CLsKmllBcTdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+0y3CtZ/H2QZ0wPDE3Fj0GnyD6e8MxKBvq6EPYuP00=;
 b=GvFdQc6+5lv4q5rWT5HM3sZAiCenQAsyE8kQrmNJFKgZ5VqBiLhUuKVRDNyyL3BHVI1pKexHoHFFcJwGfnA+GW8go/CTpst4BEs9kZRgjaAom1pd87KT6y7YCdvzUHqRGNcNM4AI7CXgNfs0AqjeQqind6fKaiqLgyy0auspL23eev4F7UypAIIWGjB2M0RHeNSu78BIUvUZbLLu4aVojaGj/pcRJTPyUUDZYXwzQ6oUaTLfGQlUMH9qxEg6GoV9B4eSJyydeeqju6WwjSEb0UiYD8sb10+mCM5MYIrvpYpDwWhJJyOaNHJy1wGIn208nBWVvpPQhscyJtsGr7lNzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+0y3CtZ/H2QZ0wPDE3Fj0GnyD6e8MxKBvq6EPYuP00=;
 b=lydJKfohilkGQKDuScSSWypHeIDPLO/ECcEBiOT6oJJIPvIOGHsO1wOoZ/bqHlMGWVq3proCFA+oqH0TKey1bJDqUEGgWSfZ5UipVifQH8pP4kFn7jWDzK+aM0mcuq1trRoojq6s5pPTN/C7QXbxyRAX36yWFpZnNhLfvGIFMXE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4603.namprd12.prod.outlook.com (2603:10b6:5:166::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.27; Thu, 10 Jun
 2021 22:26:30 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4219.022; Thu, 10 Jun 2021
 22:26:30 +0000
Subject: Re: [PATCH 33/40] drm/amd/pm: Fix a bug in i2c_xfer
To: Alex Deucher <alexdeucher@gmail.com>
References: <20210608213954.5517-1-luben.tuikov@amd.com>
 <20210608213954.5517-34-luben.tuikov@amd.com>
 <CADnq5_OLmoW1QhT-5ztWtbgq0NuvzMK+=rsQfu4YxoMkF2SYZA@mail.gmail.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <a459b666-a5b1-2d70-7656-bd16bf8dec6b@amd.com>
Date: Thu, 10 Jun 2021 18:26:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <CADnq5_OLmoW1QhT-5ztWtbgq0NuvzMK+=rsQfu4YxoMkF2SYZA@mail.gmail.com>
Content-Language: en-CA
X-Originating-IP: [108.162.138.69]
X-ClientProxiedBy: YTXPR0101CA0043.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::20) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YTXPR0101CA0043.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend
 Transport; Thu, 10 Jun 2021 22:26:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae892ef9-480d-415d-d023-08d92c5ecbba
X-MS-TrafficTypeDiagnostic: DM6PR12MB4603:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB46033A1FC2FBAF903DB0AAFA99359@DM6PR12MB4603.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:330;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CNzqJbz2LgRBPIdtfoV+8F09IT+hBSmiP2i/Aw/joeBTUiObbvExfQSMSYNjE+iMwu3UrsZXXVKhe8dQkITR8AFd53YDSKhX064YrnnBGB7NIkaNOZUch0xUL+v29ykCUkDwOGdKnQnSdMY1RBFcvwtlSNVVXVITFAkKS8ovbs01E6FlctAo2pkFw8K32YoDTcHnCTRFcuMBGhj2RtEpCdE1ebd7ZahNpenfLkZwAZF9pS4HxKSU1+r1goSKROZY+KgeCZTlxNp8tc0+eTTPUEHUQTlbpCxgeBpWBWAgLFbbZiAiD82Sk7jrOlBOgtS6yKBUWRMvE7ec3yExz0RUIsCTCyE0fhd+AbYfMnw0WSmc8lyjr9OGeNnXDnPSg35QCIJaCykH75kRBF5rryB2P2Oi4vYR+8XdkfHB1haX5Nw9v+MMbqvV4/1f83GFFzBpR1woq+KK8JANQVCr18LgqdiUu4LgccayZiJ87bs4KVsBDFrhIAfXEZys8yVVEPf0bJICsFqnkIFK/O3wNEBCvoH7q3+JrWl5CVaxgp5ZWsUtirA1HNdbvBUP/ZJWyaJj7kmGnCNTjjdJnyYtW8rpCpnQWzuW5vLSD71kxTPst9a1NjZaUcYh+4eYNcQUnbhfVJj+TNgu884lpM6J+N7a1ZcK8b4YFgWdQNWatJRZZD980ZiXIBzaaQ+6Qi037UTjaH8u5WHa9algXLzXxMP9hw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(39860400002)(366004)(346002)(396003)(54906003)(38100700002)(5660300002)(83380400001)(45080400002)(55236004)(53546011)(478600001)(8676002)(6506007)(316002)(8936002)(2616005)(26005)(6916009)(31686004)(6486002)(31696002)(4326008)(36756003)(2906002)(956004)(6512007)(66476007)(86362001)(16526019)(66556008)(66946007)(44832011)(186003)(966005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVU0R09wQVpHWlhpVUVTRkZSU240ZVlJVmVNYWg1aVFiMWhnd0E3V1VNWXlH?=
 =?utf-8?B?YTFrUlNsR2RpZTFsbldmQUNRdDRCeFUyMFZMK01IajlQaTU1Q0kzYVdQMDVK?=
 =?utf-8?B?Q2s3STYwM1hwVDA5NURlUW9TRkJDdUFIclAwUnBkdkVoWjBpVUEvbTEwUzQy?=
 =?utf-8?B?ejFicSttZjVWNE9Cbnk5MWljLzgvM1pJTEFXQjM4a2ErSFhhTVVKU2tvNUdN?=
 =?utf-8?B?a2JydGNJOG5hb09WTHE2OUFpOUZhekZiZHJPQlA4VkIyZ3JXVmdWbUI2dXBS?=
 =?utf-8?B?UWpSQ24vd0dQUEZHUzE1Qm9WamdubXZwRmZTVWFuTC9heklKUHNzdTRwOTV1?=
 =?utf-8?B?SHZhejUyRzBpcm5tVnd0YTd0Q3J3RnlaTGNIdmoxRjNQVXIxTEp3elRFS3pO?=
 =?utf-8?B?SVltRUMrL3RYRkJ3NVFMTElOdHlGK2V0WGlEUkNCTGlpM1BJeWNkWTZndWx1?=
 =?utf-8?B?VWQvRmZEWHlaemRjb01QSnpnZmZnaGFYQ2xHOW1NRk9LdHNLUnM3NS9qa2hn?=
 =?utf-8?B?R2JkTGFuQ3VRTjJGai8yTys5VGp6dGtrY0hEcEFaandxbDVKTlY5RDZzUHJs?=
 =?utf-8?B?ZmVlbzRmVWZUZTVzZ0lrQ1dtcDRCNGthWlZGYlBrNFdzOUVrYlBIU1dTdkhv?=
 =?utf-8?B?K2o3RUhpZlgrWnN0aW83UDNoZk9Pc2hVT3VhVk5oWEMvZ1ZSaW5ZSlRQNGZv?=
 =?utf-8?B?eXdkVnhVbXgwZ0lMc0VmTE9mWFk1TG1CM2J6eXJhbjBlZGY0dTI0R1N4Smpp?=
 =?utf-8?B?VWFSUldCTDZxUkRsZ1VBQ254V3ZZZjNud1NJWitOdVhpK3hQK0RNYVpLOWV4?=
 =?utf-8?B?MHVxWU84M1B5Z3QxNW1uWkN3Skt4WUpjcWEvRzBDSnorQnlVbjQydlBKMmhV?=
 =?utf-8?B?KzhtK2tpdFRwb2pIMVI2Tno3UnhKKzd6SThFZ09yS3dGVGx0UGJOdHBwbHRT?=
 =?utf-8?B?azh5NHdFcU5ocTNlaFJqVEZ4cHIzckw2cE5TODVJUllQNVNUOENTNGNDcmpz?=
 =?utf-8?B?ZHZ3cEtIcG1iNnF0R0VtNThFUWFIN2ltUDQ1OFFMVWYrOGhSN2ZYbEV5T1Ja?=
 =?utf-8?B?eEVCbEdPdGtOQWgzUlpleTF5OXNWNmk3Z3pOZGN1bmZjUllrN2tNNlYvUnE1?=
 =?utf-8?B?bU5aWFZDWmJ4OTBVdE5zY2Q0d1hidklsaFdWVEMvUnVMWFp1dlVBdVpKa0Nl?=
 =?utf-8?B?WXR0YklObDQ0TFh3MFAyUnNKcVhyNVRnblFhQVlIYkVlS25Nd2Zyeld0VzQv?=
 =?utf-8?B?UnNoMU9SdGtPSG9YbTh6cHVYM29uVTMxakU1ZXFpdkk3UWJiZUJGTml1RjZj?=
 =?utf-8?B?eDJGOUF6WTlWaGtwS2duanJmRGVHK0NiT1dYcUExMWpYQWZqamVuekhUblZS?=
 =?utf-8?B?VUFpVlJwSUFOMm9OTFpIYmwrM0xwTXVPU0poazNvQVVOTnJMa0hxTmNCS0hw?=
 =?utf-8?B?SGNOb0cxeG8vOTQwNDNoQ1FxRW1LL2V0azlXOVZXZUVuMXN3eHByMXc1aGJP?=
 =?utf-8?B?YWo0N042SGk1Q2FxdHg4Z0dGaE1zR3VmclZUN3pwVXlJRU1KRm00V2FKTDRz?=
 =?utf-8?B?K29ER1ppTm5SdE9BdFpBWHRIT2dVcysvOGI5WXVkdXA0TFBIMkREMlhDbmtG?=
 =?utf-8?B?WktudE1PRzRXZUFIalBaTGorWUl5bUFWU0pTeEsxS0xtQURRNG41ciszN0hZ?=
 =?utf-8?B?MTJReThJQVZ1RE5wVWd0V1lLTlQwM0tiQkpRcnI4dDJFK3oxWFdUYXBrREhi?=
 =?utf-8?Q?TtAOaXRX0FJYhpK9fDziAvvLkiGnyff/Z/iybVf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae892ef9-480d-415d-d023-08d92c5ecbba
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2021 22:26:30.8710 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GrVtB00voG3ADuJpFCXymojsMF6NWwmc9AQ3S6lvFr32mJzgZ0yIaJsMRUrs2pBF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4603
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-06-10 5:12 p.m., Alex Deucher wrote:
> On Tue, Jun 8, 2021 at 5:41 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
>> "req" is now a pointer , i.e. it is no longer
>> allocated on the stack, thus taking its reference
>> and passing that is a bug.
>>
>> This commit fixes this bug.
>>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
> Can we just squash this into the original patch where this was broken?
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Yeah, I'll do this--it'll be better this way.

Regards,
Luben

>
>> ---
>>  drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c       | 2 +-
>>  drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c         | 2 +-
>>  drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 2 +-
>>  3 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
>> index 0db79a5236e1f1..7d9a2946806f58 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
>> @@ -1957,7 +1957,7 @@ static int arcturus_i2c_xfer(struct i2c_adapter *i2c_adap,
>>                 }
>>         }
>>         mutex_lock(&adev->smu.mutex);
>> -       r = smu_cmn_update_table(&adev->smu, SMU_TABLE_I2C_COMMANDS, 0, &req, true);
>> +       r = smu_cmn_update_table(&adev->smu, SMU_TABLE_I2C_COMMANDS, 0, req, true);
>>         mutex_unlock(&adev->smu.mutex);
>>         if (r)
>>                 goto fail;
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>> index 2acf54967c6ab1..0568cbfb023459 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
>> @@ -2752,7 +2752,7 @@ static int navi10_i2c_xfer(struct i2c_adapter *i2c_adap,
>>                 }
>>         }
>>         mutex_lock(&adev->smu.mutex);
>> -       r = smu_cmn_update_table(&adev->smu, SMU_TABLE_I2C_COMMANDS, 0, &req, true);
>> +       r = smu_cmn_update_table(&adev->smu, SMU_TABLE_I2C_COMMANDS, 0, req, true);
>>         mutex_unlock(&adev->smu.mutex);
>>         if (r)
>>                 goto fail;
>> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>> index 44ca3b3f83f4d9..091b3339faadb9 100644
>> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
>> @@ -3440,7 +3440,7 @@ static int sienna_cichlid_i2c_xfer(struct i2c_adapter *i2c_adap,
>>                 }
>>         }
>>         mutex_lock(&adev->smu.mutex);
>> -       r = smu_cmn_update_table(&adev->smu, SMU_TABLE_I2C_COMMANDS, 0, &req, true);
>> +       r = smu_cmn_update_table(&adev->smu, SMU_TABLE_I2C_COMMANDS, 0, req, true);
>>         mutex_unlock(&adev->smu.mutex);
>>         if (r)
>>                 goto fail;
>> --
>> 2.32.0
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cluben.tuikov%40amd.com%7Ca961cab9226c41c5fde408d92c54721c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637589563470538602%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=LQxzFaoGKixKHL8HD2YzWDxv1FYO7oXhW4y0UMpzslY%3D&amp;reserved=0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
