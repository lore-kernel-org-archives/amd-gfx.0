Return-Path: <SRS0=qfa3=LF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85BA4C48BE0
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jun 2021 17:37:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45B6461287
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Jun 2021 17:37:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45B6461287
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA1C16F3C9;
	Fri, 11 Jun 2021 17:37:31 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D28576F3CE
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Jun 2021 17:37:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aSpeLgIomJor8f6Iney+gwrJ2FuFR03S+AatyLXkE/mG2C7y+Grt38MiBib44Zwkhssk+O0/yrN43cSaqnWCK4YiTn8O+qpDIxTdVZsDQgtf3ocRzB4u2GY0YWQqyBvyNYzdZa5YpEicnHWa6LYpGHmyFO874aBX8BEMVDIL6DV0MHc0fflIOO5me9DPsrB28r87HAZCFrE9ShXSvvkO0DgBYtB0cX1vcj+C6awzmt2EJRjHofCXnzYIU4UsdzQUeTBsXBa/WFk1B39jYhc90D4pWhkLp4l+Dc/TivdPGgd8Otn8d4IRglpc09YM/CnHoD1Z552M+tJJ3LCTpBv+dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ovkHoTtdk3BUWqQHV2gbU4DOsXKHmrlEOaXa6WCix5E=;
 b=ccgql9qWuvrrVaiUCH6TKT7TJR0RbQmViAedLEUcLLeLQHp4KPlXwGLKliuAjLQJ3D5Vews/ci+gyYNnZrw4jwO5BNXH64sIDDMO1lDAZElXL3d24DLOsy+egd6R/detEbOa2+nvwnXZ9hRpQeMduIK6a+FCiUoffIYMu1AMwZmjoba719TpnEoL3uQVeqhUOOVqSV12JO/3J4vc2MTcPdvQuhhv1IdJUS5JBaowVHjnAnWVsZtyMeAWNUxxipo51sLl4Ti2PbX4EUwkeOExgeA5w2EC/WHatmUY7fBIZSYl6vcR8RKGSUIi1xdcKslPI/bu0SAaF5DIJ6jaIIview==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ovkHoTtdk3BUWqQHV2gbU4DOsXKHmrlEOaXa6WCix5E=;
 b=MbPcThH4sMFsXIgghU/cnoUO/dfADSjWfi0AFiEB/jIZZ8ykOBkENMJHOG1pyl6kKYcflsdi9t2EAdM1JmPKVTZAt/IIQa724or/hFUdtKXzY7wq8O/+qERhQzNoJyLAWgGG7ew517CRr9Tcpw+WzynSOpJomdS4m2ycK0trICw=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB3084.namprd12.prod.outlook.com (2603:10b6:5:117::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.23; Fri, 11 Jun
 2021 17:37:29 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4219.024; Fri, 11 Jun 2021
 17:37:29 +0000
Subject: Re: [PATCH 20/40] drm/amdgpu: EEPROM respects I2C quirks
From: Luben Tuikov <luben.tuikov@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
References: <20210608213954.5517-1-luben.tuikov@amd.com>
 <20210608213954.5517-21-luben.tuikov@amd.com>
 <CADnq5_N3OHc2_G08BbFJHx1sqErQDP_+uvCKHfXGA7=dziBxVw@mail.gmail.com>
 <079adf2b-0791-0714-98de-a0bc8f9bdfe5@amd.com>
Message-ID: <4124f932-84e5-1d44-903f-c867cb338c85@amd.com>
Date: Fri, 11 Jun 2021 13:37:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <079adf2b-0791-0714-98de-a0bc8f9bdfe5@amd.com>
Content-Language: en-CA
X-Originating-IP: [108.162.138.69]
X-ClientProxiedBy: YT1PR01CA0077.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::16) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YT1PR01CA0077.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.21 via Frontend Transport; Fri, 11 Jun 2021 17:37:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a17b99e8-deaf-4819-8cce-08d92cff95af
X-MS-TrafficTypeDiagnostic: DM6PR12MB3084:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3084A9FCF9AD8390DB831B5999349@DM6PR12MB3084.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M7JrKS1orRfKui45pK0kzZm29maeDD5vAkjnhWrBWy/JZrI24Xai3NdreA9KSjTvUdSXTKTrx2D/rB8q3TDvHsQc1KAtYqywG3GFWmPaMn4OWByrWV+DevD2mLFX2eFrCCkXZ/hzGPiKW3lTDbfhB03V6qQK9Hb/zaF8HtH2FY2IKQn8hRbfMNN374TJy21ZCuiBizaExTXYBf5uImfUycXeBBOk5BOaApPIFvJEr9O51dvQbQwHLh9I27aKVEOiclRPbsuZ/d8aeI+tF5Bc43k9jvUZINHCN1aSOi3Wd528QSoQEOf1lNctu2Edox7O7yTzlpafy3RK66vc0FM83phetuBSCWhtsgulz+Hpa8FpSb4UrpMiRM6F5tjZZS6y2mtmV10HC1cc/WEroV8KED7dv3PTImU9FKln3VrLKz4boy8mmKqyAV6sME9/J7laUY5IxuSfGWn1vavUn2N1WeA4yxT/zMiYdyPBpDZvZjEEbysBtGtw4wNeQ9gTSri+ZMUA9U+ybxuCdLvDxpy97pqxgAxRjZswILsSh203fGCZzNEr4wGbQBjogbxB3FOxmdtOzbF8O/Mgone3vPhNRU3TVoZMJ6CCQwLKDQIti/XRnzWwxdmxquCqJOIgnvHV1TDF58xKSR133IYxb7nrVl4JDVz1LHoYv9CXpO91tpVUx5Uh5Zz4LCwnVC6NlE1Nb33Kai/HV1d7D51AmqIOa+N+VzJSiC/WER8B7ajwgIM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(396003)(376002)(346002)(39860400002)(44832011)(8936002)(316002)(16526019)(6916009)(45080400002)(66556008)(8676002)(66476007)(6512007)(66946007)(6506007)(186003)(26005)(38100700002)(31696002)(83380400001)(4326008)(2906002)(956004)(31686004)(54906003)(5660300002)(36756003)(6486002)(86362001)(478600001)(55236004)(53546011)(2616005)(966005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0U1V2FrdTRISFB4NENwbWdYYjJ4cjVIRWRpaGtzR3k4VU94Z2dVRzBFbjEr?=
 =?utf-8?B?U1h4cDh1cFpTKzlQU0NvWWlacWtTTzNvRTlrS29TRmt3R3luZEVtZSttQ0Fn?=
 =?utf-8?B?UCttNFhDU0M4TnhpQ2tSN0M4Ylc2SEJVN2lZd2w5ZEZBRnEvVmZZRi9wNkkv?=
 =?utf-8?B?ZlZOUklhL0ZYV1N4ZjRLelBTRjVVL252UVdqWWVaMHdMWEhZM0RPSGN2WnVC?=
 =?utf-8?B?SCs5WElLeEg5c0FvV0syZUVEQWtiakQ3LzdWNzJMUU5QQkh1a2d0RW1rTHNC?=
 =?utf-8?B?enFsNHlnb0tBOUhZNXZyM1pZQ0lkNEkyb2txU3NYT1dvUUVqd3k1TnRJK0E5?=
 =?utf-8?B?NHpNZ3pPK0xtN2l0MEEraXliL0g0QzFJcW51OHU1TFFqS0g0ZVI0TGtYKzJy?=
 =?utf-8?B?b2hyN2NkekkyYlNnNWJjRkRMc1dtMnZ3UFZNdWtOT2VDQ0Q3NlFZR3Erekl3?=
 =?utf-8?B?bzBib0ZWc051R25sQWlFVnlUNHB5bU5VejdNMFI5RnloOGRtc1lydm1hVnly?=
 =?utf-8?B?bjE4b0RlYVBjZy9kZ25YbGpsTmxhdjZrV05RcG1OS1lvUjBDTDFtNVByQy9I?=
 =?utf-8?B?dk1QUndSdWNHaWllczNsaXQ2UHc2MlA4Sk02YzdISHljRjR1eFlIRmpqcHZO?=
 =?utf-8?B?U01jeVYvN21uM0NDdDUzdmJRVUJrbGE2eDBSK0Jqb2g5eXBrR2RXSUdUWE56?=
 =?utf-8?B?VnlkTDlQRkI4YVBXaFpLcVlBUS9UdVlDMzVZTlZRYStNcWNLZmFBbnFlR0Qr?=
 =?utf-8?B?ekZXK2liVFNUUG0vZGFQZXNjdVFaWHpVdFlqYS80emtoR2lvY2pOSHIzTGFo?=
 =?utf-8?B?RUJ1Q1J6T3dkL2NUSThDRkY2aERzUm5ZU09TckV1RkZpVFVka3ZWc0xNQU5r?=
 =?utf-8?B?LzREaWhDTUJrdm1nNkN2Uzk1L0VUeFFmWEN3UGpDZlZCaktzbGx4eEZvTDND?=
 =?utf-8?B?WEMxdFU1eFNXOVlVL21RbkwzQkY0cWZjQkRCT3luV0Z1cXE4L2x5T2xTODRy?=
 =?utf-8?B?RWY0WG5qcVg3cnZrdjRtWjdrUlJEb0h6N29NMVpnMlNyMWVZaC9RaE5CSCtT?=
 =?utf-8?B?T2dtTFl1SXp6ZEpqV01UbHV0YTVEblFmWkJGRExYbkxMNVM4L0M5dERSc2xJ?=
 =?utf-8?B?eUx6TjVaM1dzRjFjNWhQVWtYUG5nSi9ITFhYMHdvK285OFNVWk1McVpoUFVk?=
 =?utf-8?B?YWh1dS85cjJjYUpxVktySEIyMm1GeHV5b1JzcFVkWEdTZ2M5ZlIyNHZIN0pQ?=
 =?utf-8?B?OFcycmpldkcvNng2WEQxSkU0VStpV0lISGVJWk9maTlJa3ZFZy9saFVOWHRm?=
 =?utf-8?B?ZCtwU0oxZDBwWGkxRHJnREk2Y2Y1N1IzbURoQ1R3ZDFHYllBUXRMVVkxV2hI?=
 =?utf-8?B?NFo0cGhzajJLeGd5cmU4bTVrRlZiakFOQVBDd2Jma20rWG5weUMyTW1aUW1W?=
 =?utf-8?B?bDVOOW5nczV2QS9nZG4zb1krZGNvQVFFUHJsOUtIZVo2Qmg0alFNRXNHWFNy?=
 =?utf-8?B?K2NZbkd3MDQwZ2NNT2JpRlkwcXR3eFpxZzBJdFdnbEpFRU1XbmhsMENlYVRP?=
 =?utf-8?B?YVBlVXVLZmFjejRjVHIwazVwV0xnZEdtdkV5cm95cGxXS0dXRFdLSzdFcW5i?=
 =?utf-8?B?WDRYalNzeDRiZ1RldnZ6ZHAyRjdSZGVuY3hFeENrL3RQL3VDTTNSQk5CNXlR?=
 =?utf-8?B?UXRZM1lUTlBLT1A1czdOcjZTSmlia3FTSk13L053WFViaTRraTFVUXYvY1pq?=
 =?utf-8?Q?EMwssUGmOdYFf9bFKGL4F90GM8dGefK8CYhqrcD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a17b99e8-deaf-4819-8cce-08d92cff95af
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2021 17:37:29.1177 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l2oXff1NsiM1d41PYxp5sjaQo7uRZshuusPm3zkbqyeTpN79RarG0RJPtKu/7D6Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3084
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

On 2021-06-11 1:17 p.m., Luben Tuikov wrote:
> On 2021-06-11 1:01 p.m., Alex Deucher wrote:
>> On Tue, Jun 8, 2021 at 5:40 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
>>> Consult the i2c_adapter.quirks table for
>>> the maximum read/write data length per bus
>>> transaction. Do not exceed this transaction
>>> limit.
>>>
>>> Cc: Jean Delvare <jdelvare@suse.de>
>>> Cc: Alexander Deucher <Alexander.Deucher@amd.com>
>>> Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
>>> Cc: Lijo Lazar <Lijo.Lazar@amd.com>
>>> Cc: Stanley Yang <Stanley.Yang@amd.com>
>>> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
>>> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
>>> ---
>>>  drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c | 80 +++++++++++++++++-----
>>>  1 file changed, 64 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
>>> index 7fdb5bd2fc8bc8..94aeda1c7f8ca0 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eeprom.c
>>> @@ -32,20 +32,9 @@
>>>
>>>  #define EEPROM_OFFSET_SIZE 2
>>>
>>> -/**
>>> - * amdgpu_eeprom_xfer -- Read/write from/to an I2C EEPROM device
>>> - * @i2c_adap: pointer to the I2C adapter to use
>>> - * @slave_addr: I2C address of the slave device
>>> - * @eeprom_addr: EEPROM address from which to read/write
>>> - * @eeprom_buf: pointer to data buffer to read into/write from
>>> - * @buf_size: the size of @eeprom_buf
>>> - * @read: True if reading from the EEPROM, false if writing
>>> - *
>>> - * Returns the number of bytes read/written; -errno on error.
>>> - */
>>> -int amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap,
>>> -                      u16 slave_addr, u16 eeprom_addr,
>>> -                      u8 *eeprom_buf, u16 buf_size, bool read)
>>> +static int __amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap,
>>> +                               u16 slave_addr, u16 eeprom_addr,
>>> +                               u8 *eeprom_buf, u16 buf_size, bool read)
>>>  {
>>>         u8 eeprom_offset_buf[EEPROM_OFFSET_SIZE];
>>>         struct i2c_msg msgs[] = {
>>> @@ -65,8 +54,8 @@ int amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap,
>>>         u16 len;
>>>
>>>         r = 0;
>>> -       for (len = 0; buf_size > 0;
>>> -            buf_size -= len, eeprom_addr += len, eeprom_buf += len) {
>>> +       for ( ; buf_size > 0;
>>> +             buf_size -= len, eeprom_addr += len, eeprom_buf += len) {
>>>                 /* Set the EEPROM address we want to write to/read from.
>>>                  */
>>>                 msgs[0].buf[0] = (eeprom_addr >> 8) & 0xff;
>>> @@ -120,3 +109,62 @@ int amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap,
>>>
>>>         return r < 0 ? r : eeprom_buf - p;
>>>  }
>>> +
>>> +/**
>>> + * amdgpu_eeprom_xfer -- Read/write from/to an I2C EEPROM device
>>> + * @i2c_adap: pointer to the I2C adapter to use
>>> + * @slave_addr: I2C address of the slave device
>>> + * @eeprom_addr: EEPROM address from which to read/write
>>> + * @eeprom_buf: pointer to data buffer to read into/write from
>>> + * @buf_size: the size of @eeprom_buf
>>> + * @read: True if reading from the EEPROM, false if writing
>>> + *
>>> + * Returns the number of bytes read/written; -errno on error.
>>> + */
>>> +int amdgpu_eeprom_xfer(struct i2c_adapter *i2c_adap,
>>> +                      u16 slave_addr, u16 eeprom_addr,
>>> +                      u8 *eeprom_buf, u16 buf_size, bool read)
>>> +{
>>> +       const struct i2c_adapter_quirks *quirks = i2c_adap->quirks;
>>> +       u16 limit;
>>> +
>>> +       if (!quirks)
>>> +               limit = 0;
>>> +       else if (read)
>>> +               limit = quirks->max_read_len;
>>> +       else
>>> +               limit = quirks->max_write_len;
>>> +
>>> +       if (limit == 0) {
>>> +               return __amdgpu_eeprom_xfer(i2c_adap, slave_addr, eeprom_addr,
>>> +                                           eeprom_buf, buf_size, read);
>>> +       } else if (limit <= EEPROM_OFFSET_SIZE) {
>>> +               dev_err_ratelimited(&i2c_adap->dev,
>>> +                                   "maddr:0x%04X size:0x%02X:quirk max_%s_len must be > %d",
>>> +                                   eeprom_addr, buf_size,
>>> +                                   read ? "read" : "write", EEPROM_OFFSET_SIZE);
>>> +               return -EINVAL;
>> I presume we handle this case properly at higher levels (i.e., split
>> up EEPROM updates into smaller transactions)?
> Absolutely we do.
> (We break it down twice: once per this limit and again per page size and page boundary. It'll work always. :-) )
>
> But this is different--this means that the user has set a limit less than 2, which means we can't even send a set-address phase to set the EEPROM memory address offset we want to read or write from, and thus the chattiness.
>
> I just noticed that it is less-than-or-equal, which means the smallest limit the user can set which would work is 3. But 2 would also work, then all transfers would be 2 bytes long. Does it matter? I guess I can change this from LTE to LT, to mean that a minimum transfer of 2 is the smallest we support. I've changed it to LT. :-)

Ooops, no!
It was correct the way I had it.
It has to be LTE due to the comment below, else the min(0, u16) is 0 and we'll not send anything. :-)

Regards,
Luben

>
> Regards,
> Luben
>
>> Alex
>>
>>
>>> +       } else {
>>> +               u16 ps; /* Partial size */
>>> +               int res = 0, r;
>>> +
>>> +               /* The "limit" includes all data bytes sent/received,
>>> +                * which would include the EEPROM_OFFSET_SIZE bytes.
>>> +                * Account for them here.
>>> +                */
>>> +               limit -= EEPROM_OFFSET_SIZE;
>>> +               for ( ; buf_size > 0;
>>> +                     buf_size -= ps, eeprom_addr += ps, eeprom_buf += ps) {
>>> +                       ps = min(limit, buf_size);
>>> +
>>> +                       r = __amdgpu_eeprom_xfer(i2c_adap,
>>> +                                                slave_addr, eeprom_addr,
>>> +                                                eeprom_buf, ps, read);
>>> +                       if (r < 0)
>>> +                               return r;
>>> +                       res += r;
>>> +               }
>>> +
>>> +               return res;
>>> +       }
>>> +}
>>> --
>>> 2.32.0
>>>
>>> _______________________________________________
>>> amd-gfx mailing list
>>> amd-gfx@lists.freedesktop.org
>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7Cluben.tuikov%40amd.com%7Cc8502a7f4dd94666468408d92cfa95e6%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637590277035962948%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=UsBaf7trds%2BjmJ8yhIaMoLNdq2Rxk3EXY5jztgzjFL0%3D&amp;reserved=0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
