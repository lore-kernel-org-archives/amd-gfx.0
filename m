Return-Path: <SRS0=qfa3=LF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAAC6C48BD1
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jun 2021 17:17:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 965CB6124C
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jun 2021 17:17:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 965CB6124C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C3C16F387;
	Fri, 11 Jun 2021 17:17:11 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2040.outbound.protection.outlook.com [40.107.212.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 843916F387
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jun 2021 17:17:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OczCaU/v6ktIBN8Zg4TS5KKjt9vIvucQO8p2aFEGoX00tkYNZtVc9sFPPaRh9jypsColOGx487mQ7032TKEdOuqaQWeWPvOd+87b66VcVv19yfa1OrgfvFmcJNZSLvuxTYridi0ZA2BTJG3G6e/1ea2B5uqiicszKfee3NEcmX8L7etIfm+X7cIPzFO0U3Gcapm/0KNCNtYgDAY8FMKs1JbQ9TrxMgfyWyVlGmjBP07jw33UdiojyFNbs1WSE3jl5008Cn7kkvw64FLMT1M6OeI/sjQokJUFnka8CaJWZr7iW3uHyiOLJp8Ui49+ESErffEJzHoUOzVunAdTaa9WeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6lGmmz7DiVtCIX9IHwef19kTeI8CevMlsw1ZdcMtBIA=;
 b=mv1Zvh/AWJjWd8XzpmVgfxRf69TT7OIMawE7otVB15k5CS90L8RV+lvR+6Ajb/0MGkZ5/A3pgkUnOmBn7e69k4roC7N8wW8vIHjYS1ChUV20KKgMROxEFLpcXGAbVLCb68ts6Q3oR9VKVmrNzAt4XgBV+CC/SZKWdu15PFNQPyUT2NmP1XpXgSKW1iSLzE0i5tMO6j7sdf3lA7NrEIuePupSApBqZ8Bz3Zee/W3KMyVBZo9lQDSP8+JEq6QPrYl0ZZgtKRNZPUaSZikk6uQUw+qFvpgMXDtjDm/YroAxOM6XuTfWsQN+BU3S8XMrmMVrUzMyZMQjIJzK/SJKlw9HQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6lGmmz7DiVtCIX9IHwef19kTeI8CevMlsw1ZdcMtBIA=;
 b=ECg27KI0KO/ytAWyrIkW2tXR8L+6ez2QJvpDKGlOqUbcSABCssOlSD8K2xsyulrbDOldUImghQ7T1hgmD1YUBR+mLQMW0FhEXcRmfMk4vvwXSUSUGpxzISH/Nm5r0dJ6qQf2PkhnIXmcTn8i/W8qbJIx+hJaRlKur+AAbuFznD0=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4337.namprd12.prod.outlook.com (2603:10b6:5:2a9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20; Fri, 11 Jun
 2021 17:17:08 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4219.024; Fri, 11 Jun 2021
 17:17:08 +0000
Subject: Re: [PATCH 20/40] drm/amdgpu: EEPROM respects I2C quirks
To: Alex Deucher <alexdeucher@gmail.com>
References: <20210608213954.5517-1-luben.tuikov@amd.com>
 <20210608213954.5517-21-luben.tuikov@amd.com>
 <CADnq5_N3OHc2_G08BbFJHx1sqErQDP_+uvCKHfXGA7=dziBxVw@mail.gmail.com>
From: Luben Tuikov <luben.tuikov@amd.com>
Message-ID: <079adf2b-0791-0714-98de-a0bc8f9bdfe5@amd.com>
Date: Fri, 11 Jun 2021 13:17:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <CADnq5_N3OHc2_G08BbFJHx1sqErQDP_+uvCKHfXGA7=dziBxVw@mail.gmail.com>
Content-Language: en-CA
X-Originating-IP: [108.162.138.69]
X-ClientProxiedBy: YT1PR01CA0046.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::15) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YT1PR01CA0046.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.20 via Frontend Transport; Fri, 11 Jun 2021 17:17:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c99f207f-6a88-42c1-a05a-08d92cfcbdcf
X-MS-TrafficTypeDiagnostic: DM6PR12MB4337:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB43373B364951FE7C125A12ED99349@DM6PR12MB4337.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +/OMbtmdWPwEib5KFY8/fILebY59uIefJ3sVPQUNaHEPi+7H0gRWjGxclDLcwxknVcUJc13i0WvtUWmtlqe/aTzEj+jblWoF6n99d3btwudMsdqmUbJ59vpu4NTKBvoZfLMonGoEyn1Ozo4HQcHqbgCD6TFmIbX/MFa9vKod7UP9PuP8evRybsJRrakUA9f2SXB9Qx+Z2m/PQuaS+W3T3YvoO3fqvm5r19Uir1Ra69/0jpXy90U1TJKsYouVMnD69sc1dwxpyQTR9pS0HGyQ5WL+pXlzfoEaaswtlmzlpfavsyHUdPm+POeNZjds9PCMl/KyN5FuQ74KQ8fO+JE4LNnMeRA+I4rrt7+eGlohuEmFVGeMMJgNNDWglZ0O8cEt5YmkGrPPdmddpvhWEmmicha1iRtNVYz7Il94lfuLrxhy8N2dgXUStJqOFLkiilIAO0ZfcD60yO0+ZCzxa78/BBsWPwQ6pB1C8XGU5Tzki8OuesZjO7RkQa1gfm3A3R61PhCiWWbM8K8z6wNc7hhLo3W8VctJ7Z7qfphOSXwYorFKp/6mUiix4lzCeHAq4rLLZpShIW4oPY8RRJNpr2a/pyxk4eNsklx+7CPA7lXsN/xRukO8nf4xm7TrV6b5rEidzM9FpMRHVEe9VlADYkVizaPtp2jTqvo0wMm+iZi2nBY694yV/NZIXTqbmkjlSVbdIu2iZ7NdgFMIUTrPkd/BWsETZfcyXjbJunlVndZlHHk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(39860400002)(366004)(136003)(8676002)(44832011)(26005)(4326008)(66476007)(31686004)(6506007)(478600001)(66556008)(316002)(966005)(66946007)(38100700002)(53546011)(6486002)(36756003)(8936002)(86362001)(83380400001)(186003)(54906003)(2906002)(6916009)(16526019)(2616005)(31696002)(5660300002)(956004)(6512007)(55236004)(45080400002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmQrUFU5eUdmRTZrUjduWlRKMzBIcE1YcHNVOStrYzBWYkxxWU11OFNXTVRY?=
 =?utf-8?B?Ym03UFBVMEM0NllaUHc2N05JcTZZbndGdFlSZFVmT1ZSTGl6WWpoK005VWVj?=
 =?utf-8?B?VEo3VXRwTUIrT0ZxY3k2aHd1MitEbnRoR0ZaUjFEeUhGc1BzNExCaEVNT3l4?=
 =?utf-8?B?TVptQ2w1dzMvZURLRUNEZFNiSFBwcjdQOU0xU1Bsb2hhbEE0WlcwbjFqaUNk?=
 =?utf-8?B?NTRnbVU4QTNITGRVVksrUHphZ09hOVFRMmVlZnRITjJoanZvUytPTXJBamN2?=
 =?utf-8?B?Nk12RFRpWm5QU1ZuSXhlbFF6eXI3Sko3emhHK0JKVVFta1l2c1JYQTFlZlJH?=
 =?utf-8?B?a0R4bzNhcXAzWTRzMTlPWkREV2R1cmZxcWxQcHRHK0tMZzVnQnlCMmREU0Q0?=
 =?utf-8?B?TDJLV1RhZlN2MEpISnVWQUQxNUQwMkJTWWR0Q3VXY0FhdTFBQTVZd1lVZE5W?=
 =?utf-8?B?TFBFbWVqaTdnaXUwZlRSREdUc3V0R09KZnB5ejZhVjJIWXpPZllhQUFXZHl5?=
 =?utf-8?B?bDNGRmdpNWxXU0JTSGM5ZUJNU3kwRDBQYmtwNlYzcFMwTTdKL2RkbVRmZ3lB?=
 =?utf-8?B?ZzFaV0NZM01uaFVtSGRGODJpNWpvNUdTSnhRYTZ2RXd6ajdUMUM5b1I0RXFV?=
 =?utf-8?B?a0c5dmVJc0x6ajJYQ1kzZnAya3I3Z2dBOHZEQlZuV1V6MkRGY3Z5Z1hka3NK?=
 =?utf-8?B?NUR6MVQ5YmFwZHBSTW1TSHR4YkRTWElBN0FQWTRiT21pNGV5YXhOYWpEZTNB?=
 =?utf-8?B?WVo3RFRSMm5kMmI4Z25ETnhyS29TYVVKRlI3SFFyZHNPSTRtUnoyY3cyY1hI?=
 =?utf-8?B?NWwrVEtQT3FYRmJST0haRk1PR1ZNRERqanZISVJvZWwzQlA3bXJ2VkhQS2Y4?=
 =?utf-8?B?bTFRTVVHL0s0Z040Y1NaWHdoS3lKbWU3L1I1MExDRzRHZzJ5aDNVeUk1QVk2?=
 =?utf-8?B?ZSszZFRBQmxxcnJYY2hEQ0xGVE80OEJOZnkyVmp4aFdUWUFGZ2ZPUmE2NU5T?=
 =?utf-8?B?NW5aYmZOMmpPWDJBakpUbVgvYlM3VzYxcFc5a2FLV2o3ZFdnOCtBM0FsQTRa?=
 =?utf-8?B?VDZIbTBkWGNsazBHRkJKamhUR1hUU0pMdHVtT0hBUUpNK3l3THFpZTRlelRt?=
 =?utf-8?B?UlQvUGRoYnNBbU5vZHhCTlRCZWlwbEh3V2lxVFU4L3k0QXhpaU1tNjl3bENt?=
 =?utf-8?B?WWJzaXNyMkQ3T04zdmtsYnhNc1hNeHA3M2lVcEpVM2R4dnVmbndCcmVLeE03?=
 =?utf-8?B?Qys2WDNWb2JHL3ZKZStmdGdWcGxBVk4zTFJaK2JkbmlSTnRwaUY1SUdpVDFl?=
 =?utf-8?B?N1RINE5Lb0EyYXl1eFgrdWtIMXVHaWQzak9mTnZSV2F4eGVTUUl2SkZGY0o3?=
 =?utf-8?B?ZG5ndFdEakplSmQ4cTRrZ0xPR0oxQWc4ZVRYZzB0QlptY3BOa1N0Q0dsVk5W?=
 =?utf-8?B?K2d2QStmci9tL1lCd295cFA2dlRCR1ZSVlVPTEM5VkhRYlJEWUw1aDRTN1Rh?=
 =?utf-8?B?UTBEeEtra3hBeEQ1M3hXbnpodnBxckluaHhvb3RMVlovaWxZWU5PeUp2SFVj?=
 =?utf-8?B?dHhXRDNxNkFPK29LNGFoYjJWVUhuL3o2eStxTHcwaEpES3BDNXh4T2I4ZjlM?=
 =?utf-8?B?OTY1TVpGcWN5bzNnVlN5K1pBemE5YkRodlBQbkgzbEh0NnFNbUgzR2tWRTVV?=
 =?utf-8?B?NlZHVGt1L2ZrMVFoVExjMXJZU1Z3Z2hmYmZ3ZGFRQU9DOGQ1QlFUdlMzaFFD?=
 =?utf-8?Q?hkMIfXvJEGxNi2IonJ1BVPqCFJSk4et/5Dez1VC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c99f207f-6a88-42c1-a05a-08d92cfcbdcf
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2021 17:17:07.8866 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gSaI98vR8+ixkb+vIMpzXBO2ZvB7qWuQ6nXP0Egs0DIAGOAKA/r4d/9160JII7RW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4337
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Lijo Lazar <Lijo.Lazar@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Stanley Yang <Stanley.Yang@amd.com>,
 Alexander Deucher <Alexander.Deucher@amd.com>, Jean Delvare <jdelvare@suse.de>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-06-11 1:01 p.m., Alex Deucher wrote:
> On Tue, Jun 8, 2021 at 5:40 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
>> Consult the i2c_adapter.quirks table for
>> the maximum read/write data length per bus
>> transaction. Do not exceed this transaction
>> limit.
>>
>> Cc: Jean Delvare <jdelvare@suse.de>
>> Cc: Alexander Deucher <Alexander.Deucher@amd.com>
>> Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
>> Cc: Lijo Lazar <Lijo.Lazar@amd.com>
>> Cc: Stanley Yang <Stanley.Yang@amd.com>
>> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
>> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c | 80 +++++++++++++++++-----
>>  1 file changed, 64 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
>> index 7fdb5bd2fc8bc8..94aeda1c7f8ca0 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
>> @@ -32,20 +32,9 @@
>>
>>  #define EEPROM_OFFSET_SIZE 2
>>
>> -/**
>> - * amdgpu_eeprom_xfer -- Read/write from/to an I2C EEPROM device
>> - * @i2c_adap: pointer to the I2C adapter to use
>> - * @slave_addr: I2C address of the slave device
>> - * @eeprom_addr: EEPROM address from which to read/write
>> - * @eeprom_buf: pointer to data buffer to read into/write from
>> - * @buf_size: the size of @eeprom_buf
>> - * @read: True if reading from the EEPROM, false if writing
>> - *
>> - * Returns the number of bytes read/written; -errno on error.
>> - */
>> -int amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap,
>> -                      u16 slave_addr, u16 eeprom_addr,
>> -                      u8 *eeprom_buf, u16 buf_size, bool read)
>> +static int __amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap,
>> +                               u16 slave_addr, u16 eeprom_addr,
>> +                               u8 *eeprom_buf, u16 buf_size, bool read)
>>  {
>>         u8 eeprom_offset_buf[EEPROM_OFFSET_SIZE];
>>         struct i2c_msg msgs[] = {
>> @@ -65,8 +54,8 @@ int amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap,
>>         u16 len;
>>
>>         r = 0;
>> -       for (len = 0; buf_size > 0;
>> -            buf_size -= len, eeprom_addr += len, eeprom_buf += len) {
>> +       for ( ; buf_size > 0;
>> +             buf_size -= len, eeprom_addr += len, eeprom_buf += len) {
>>                 /* Set the EEPROM address we want to write to/read from.
>>                  */
>>                 msgs[0].buf[0] = (eeprom_addr >> 8) & 0xff;
>> @@ -120,3 +109,62 @@ int amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap,
>>
>>         return r < 0 ? r : eeprom_buf - p;
>>  }
>> +
>> +/**
>> + * amdgpu_eeprom_xfer -- Read/write from/to an I2C EEPROM device
>> + * @i2c_adap: pointer to the I2C adapter to use
>> + * @slave_addr: I2C address of the slave device
>> + * @eeprom_addr: EEPROM address from which to read/write
>> + * @eeprom_buf: pointer to data buffer to read into/write from
>> + * @buf_size: the size of @eeprom_buf
>> + * @read: True if reading from the EEPROM, false if writing
>> + *
>> + * Returns the number of bytes read/written; -errno on error.
>> + */
>> +int amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap,
>> +                      u16 slave_addr, u16 eeprom_addr,
>> +                      u8 *eeprom_buf, u16 buf_size, bool read)
>> +{
>> +       const struct i2c_adapter_quirks *quirks = i2c_adap->quirks;
>> +       u16 limit;
>> +
>> +       if (!quirks)
>> +               limit = 0;
>> +       else if (read)
>> +               limit = quirks->max_read_len;
>> +       else
>> +               limit = quirks->max_write_len;
>> +
>> +       if (limit == 0) {
>> +               return __amdgpu_eeprom_xfer(i2c_adap, slave_addr, eeprom_addr,
>> +                                           eeprom_buf, buf_size, read);
>> +       } else if (limit <= EEPROM_OFFSET_SIZE) {
>> +               dev_err_ratelimited(&i2c_adap->dev,
>> +                                   "maddr:0x%04X size:0x%02X:quirk max_%s_len must be > %d",
>> +                                   eeprom_addr, buf_size,
>> +                                   read ? "read" : "write", EEPROM_OFFSET_SIZE);
>> +               return -EINVAL;
> I presume we handle this case properly at higher levels (i.e., split
> up EEPROM updates into smaller transactions)?

Absolutely we do.
(We break it down twice: once per this limit and again per page size and page boundary. It'll work always. :-) )

But this is different--this means that the user has set a limit less than 2, which means we can't even send a set-address phase to set the EEPROM memory address offset we want to read or write from, and thus the chattiness.

I just noticed that it is less-than-or-equal, which means the smallest limit the user can set which would work is 3. But 2 would also work, then all transfers would be 2 bytes long. Does it matter? I guess I can change this from LTE to LT, to mean that a minimum transfer of 2 is the smallest we support. I've changed it to LT. :-)

Regards,
Luben

>
> Alex
>
>
>> +       } else {
>> +               u16 ps; /* Partial size */
>> +               int res = 0, r;
>> +
>> +               /* The "limit" includes all data bytes sent/received,
>> +                * which would include the EEPROM_OFFSET_SIZE bytes.
>> +                * Account for them here.
>> +                */
>> +               limit -= EEPROM_OFFSET_SIZE;
>> +               for ( ; buf_size > 0;
>> +                     buf_size -= ps, eeprom_addr += ps, eeprom_buf += ps) {
>> +                       ps = min(limit, buf_size);
>> +
>> +                       r = __amdgpu_eeprom_xfer(i2c_adap,
>> +                                                slave_addr, eeprom_addr,
>> +                                                eeprom_buf, ps, read);
>> +                       if (r < 0)
>> +                               return r;
>> +                       res += r;
>> +               }
>> +
>> +               return res;
>> +       }
>> +}
>> --
>> 2.32.0
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cluben.tuikov%40amd.com%7Cc8502a7f4dd94666468408d92cfa95e6%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637590277035962948%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=UsBaf7trds%2BjmJ8yhIaMoLNdq2Rxk3EXY5jztgzjFL0%3D&amp;reserved=0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
