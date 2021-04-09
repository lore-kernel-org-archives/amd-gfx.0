Return-Path: <SRS0=E5im=JG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D79EC433B4
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Apr 2021 06:53:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAE8F610E5
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Apr 2021 06:53:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAE8F610E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FA3C6E461;
	Fri,  9 Apr 2021 06:53:21 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 865096E461
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Apr 2021 06:53:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=an1zizYExbLEQMpW4Y59jv8r+2yt14MPQPR2eIKe27kSeMAyAOvnG6Z8wVFCIUXCafozAjfCAbcO6GrMOkpEKxKCR++eTWBAx2IdmInGOEFmUJ1H01I16d5ePA+j+TDrs54WrKw9Ycm3ThrmFZNKePD2oc8I6HvAUmtY+sxG0Ne8KHu/4VEYOYhFSYBWzf4nBa/YGP326OvITAEYps38yxwWXb+pUbF0ivQhwawbxhcd54gpoZNYpKan0LIS9m9weZ1SBY4u5yF3f220CkFkJn7nP2fDh0SskZP6DXEooO53zAHH7uWOU2pqp2PoKdszY7yvi7/dLK6in+FOt5u0lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qdgwZ7l7/s0VgHaZryLtLmNg5Q3bHc+kjlKi4GVjYcE=;
 b=H0lqP6BAOGmxumUll7ch+OvXeBXmsLr73IiwnoX9ETFIbgoSNGgBF2p11+uVkfVZrronUAh3P99n+0estkGUWiw2Y/zSKJQxngQlwGWHRzyuc50zGGFivO/m16A5Et4Ip/nhdjPbQJixGYeNiiMsYR0SlnjNm1kXeUjsJySAQKDsa5+WsNKN6ZFKQKFs4qrAscBiujy2/4v3u2CUglstrxEQAX/zVmYoccHUaqCvfdYbGztkD5JHWDUvbpirrSwedjIvMQv6Z6DAWpmkqZASaqMrNHRSvgS/5ALtia+LNQdIJSDjwUFrW+IfIQdIQNFw2G31G/HCPd3DmtM1WREKaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qdgwZ7l7/s0VgHaZryLtLmNg5Q3bHc+kjlKi4GVjYcE=;
 b=c9whEDn+4A03yQ5o5vIg/hNe96WsZOhDPoxkGdE8KX3leyiM9uyDwQgw1Mz54UG2Ix9buIliFJ89+I5Z762TI0IdDkCvlFX1nR0DQ2jNGjPnMAM4qIdJuCvr/0l6ZB9w/YXtogZRB0rwmHqrUVQiiuVEXjMxg0LR5nOqtT0M0dk=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4318.namprd12.prod.outlook.com (2603:10b6:208:1d8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Fri, 9 Apr
 2021 06:53:18 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4020.017; Fri, 9 Apr 2021
 06:53:17 +0000
Subject: Re: [PATCH 0/4] Refine GPU recovery sequence to enhance its stability
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Li, Dennis" <Dennis.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>
References: <20210318072339.28736-1-Dennis.Li@amd.com>
 <d40648ba-9948-5442-23ed-d352f824f8f9@amd.com>
 <DM5PR12MB25330F3CD92C587C2E921424ED699@DM5PR12MB2533.namprd12.prod.outlook.com>
 <MN2PR12MB3775531A74B886A207134B1583699@MN2PR12MB3775.namprd12.prod.outlook.com>
 <DM5PR12MB253379E8C89D8A20C8A0245AED699@DM5PR12MB2533.namprd12.prod.outlook.com>
 <378fdffb-99b5-2a14-736d-a06f310b040c@amd.com>
 <1e37bb4d-f54d-1b7e-4632-94cfcf749528@amd.com>
 <51d7873d-cf35-6be5-79c2-024937c67f6a@amd.com>
 <29ffe63b-9049-824f-84fc-a92fdb451e0d@amd.com>
 <e37bdceb-cdb2-a826-21cf-8cb88748be08@gmail.com>
 <1e4b766d-b5c2-e6b5-8be6-9b2fae3abc94@amd.com>
 <b67ab565-e4be-0809-7021-cb59fd10464a@amd.com>
 <8c2cbe39-ea05-add4-efee-65527e53bb34@gmail.com>
 <50e0907c-52d6-1fdb-aa5e-39b1c326180c@amd.com>
 <4a1e3961-8708-46b7-bfd8-86a4ee4e2726@amd.com>
 <f36bef2c-d5c2-7290-c029-2bcc9d834bbc@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <b3965720-ea45-7664-5927-dd3836bfa46d@amd.com>
Date: Fri, 9 Apr 2021 08:53:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <f36bef2c-d5c2-7290-c029-2bcc9d834bbc@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:2f79:f442:c4cd:830e]
X-ClientProxiedBy: AM0PR06CA0126.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::31) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:2f79:f442:c4cd:830e]
 (2a02:908:1252:fb60:2f79:f442:c4cd:830e) by
 AM0PR06CA0126.eurprd06.prod.outlook.com (2603:10a6:208:ab::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.16 via Frontend Transport; Fri, 9 Apr 2021 06:53:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8f81b08-d3e5-4f46-d002-08d8fb2427a1
X-MS-TrafficTypeDiagnostic: MN2PR12MB4318:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB431886532B7F0D906D47440B83739@MN2PR12MB4318.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DKSEZw2k9DHJAomUpmSy5WwvNwLJkRa+hEouQEyWjO8uZoYFmrra08GoheVPPBInfAfI933lGBrxqL/Fy/px2NFKp0lyJ58LjJsjN+GEF56QJYx3aWuibnWWnt7EyETrbluA6tIzP87WfSGZAFM/VQIZ9dc12gM894heh1JmAaR06rJcJfIXuF8gIDDjb0gGicUeV3dVdZP8XErfrD6QXMS5BvAISxsytkKkdD8yZC8tOKwqaO6Uqa2huK//EAsJKyvNrTaoXPDFqqfk9Bg2NYM3UbnQcHsCif4cC/9E7jfGrTSyr9cDzvwBFYUeCuLo9jegVvNvME/luIkrkvXpQpIhoiAnvImSySn4Tiuld7HiyZDlDTwumQKxmDMfyAwwNlQ3XyjQojV40HG7cTX7SBuj/KMbqycCJADHVIUIzpArqVjUwlnymCobO4wXmoRzGPaIpwBJzfptG1lR/rJG6Fr7Jik/cWQ7EAPKQfukHW7VN1FF5MCl3guN4qheLPh9VnOxwiBcFS+CEQQ3vMuU0sWs7N0oRkRaM4QiNmuVBzgQcZtrKaZX4BbYaZ5n0cdMrDaExQy2zx8xQnBfAm89IhXzw1Yurf1Xp3KGashdGbFswOlpJXtlZDXP8iQUXpOWaWcHzTMBbqamPfX3IImlLea5NRc1e51p+Ru5vjOXo49Q1NxZRuDIwBPp9JnqV+N8NSKqtoZq+YmPLzkR1lfw/JHX6pictd15oGMiAmk6SFn0ck98BFxF3AeWrAJhYOeH9iaeLijqsi+zuhhOVLlNmA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(39860400002)(376002)(366004)(136003)(316002)(6636002)(8936002)(8676002)(478600001)(966005)(110136005)(31686004)(66476007)(66556008)(86362001)(5660300002)(66946007)(83380400001)(66574015)(31696002)(16526019)(52116002)(186003)(53546011)(6666004)(2906002)(38100700001)(921005)(6486002)(36756003)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?S0d5SzZPVGJxTzNIaHo2V1lqaFVhWjVhbVB0ekRzVTZmTXZFWVNtamdNSnFz?=
 =?utf-8?B?U0xtSzl5ZFdzQ1NUa0paTlVGZ2d4aGJuUUVJdmdLN0ZnejU5a2RWKzNrUXJK?=
 =?utf-8?B?MEVTUS9NMFFNd29VZU1OSk12Z2NRNXpXODN2aXlOVXJ5aWE2ZHRwZUdxUmFO?=
 =?utf-8?B?SkJsZGdVekRSelBlVDdoWHhURk93VXd5enhTcGxKczkxSS9kU0VXU1pLcUJY?=
 =?utf-8?B?czNRYlh5WmE3LzhzUjJ4LzZOaWRHQURiOGxXZExZRWdETE9KT1VhWXY2eXdR?=
 =?utf-8?B?VXdOREpodHdnUTl0YTdsNU0rcjR5bVR0VnoyS28zWFJVSTUzRlRJdDA1Sk12?=
 =?utf-8?B?Nm9Ia0xyUFBLNEx2R0lCaUdIQ2ZMOURzWmFuK0svSDJRTUlTTllNUTBLZ283?=
 =?utf-8?B?WTNoOUkyUkhqbU44U1JxSSt5dGZFSWF6a3Z4cm5ONGs2d2N0cy90Q2g3MUxl?=
 =?utf-8?B?cm1URFYyeVRGOXpFeGNhbCtRZGprVWxhSEZIdWhtYldId2pma2hkZ2VlWEdk?=
 =?utf-8?B?N0hTcUI3cS8wNG5DWnQ4TFY5L3pybGVKeWxUOVEwclQ0YVdROGhkdVp2dXRS?=
 =?utf-8?B?Q0ZXVnBnalNOVGxpWXg5KzhmbTlNdkpUTStmSS8vRGlsT05VTkNKVnVCcTZC?=
 =?utf-8?B?dUJCcjhiRVgrbW5nNWhGQmcwemd2bjZvOER4L3h3bGxmWEtEM2lBV2FBNVBm?=
 =?utf-8?B?aTZyYm52VEJxNmQzSjFIZTRGV1dtbi9VdDVpamp5eS9RTzRRR1lQb1RmZG03?=
 =?utf-8?B?d3VNL1BocjAwTWJqSFpHNHRmem0xZFVTRWlHNWtYMjdPUXJYM0V6ejA1Zndl?=
 =?utf-8?B?L0FmSXNGbnIxNEF3Q2prSHJKSXNlcHFOd3djdEw3NjZJZWd0SFovSmxWd0xK?=
 =?utf-8?B?ei94UjdQeDFPdGdqNXgwRjhKS3pvSWg4bXBONllRa2ZEdFdLTDdZdlFvR0x6?=
 =?utf-8?B?QmRkWk1EKzJ1SzdkbUQyaHorZFQ1eUtIdlR1UGFOZC96UnlvcGh2Zm9qN0JW?=
 =?utf-8?B?MlVpMkYxbXVCWW9ZWk9kaWZHd1BDRTEwR1ZiZDd3RlZ4Y0xObHp1c1dMOWJX?=
 =?utf-8?B?R1o2bU8ycmtMMVJPNUtkb29zdy9NU0Z5NmJWTlR5Sm8vWEFNanZ6dFlDRy9n?=
 =?utf-8?B?dkRidVc0QTI5V2JUU1hGSVZzMmNGUlYzWXA2Q1M0djd2Nlo0SXl3Rk15K09I?=
 =?utf-8?B?bFVpVW9TUXZ3QXRvYkZsdWlOdWo4RVVhVU50d2YwWktyN2ZIQUY1bERuWm1L?=
 =?utf-8?B?SU93UnZDRk9GU3c2dUFyZm9FeGhVT1g3R0s1SHdtVU1LRWkxL1ZmZjEwQ1U4?=
 =?utf-8?B?V1NDMzNRcFN6aW1hcVVRaHVxV2M5Q1NsMWJVVzEzUEhlc0VaR1h0eUhMcy9r?=
 =?utf-8?B?QUtnYXoxeXJBZjhtME5IbFdYMDJJbGtETXFsSWIvQnlpS3JCbFF1cFNmZXZk?=
 =?utf-8?B?UDJpSm5GamJTa01RbXFITFNKK29QUXd1K3dnem1qbDlKaHYvRU9HZWU0NDg5?=
 =?utf-8?B?aHdGbFU4YjRTV0hCa1NWekhFL21LN1Z1Y2tQcTRsV0VEZ053a2lJMWQwaW5r?=
 =?utf-8?B?MW5CNU1lakdkSkZrOVg1RWxvN3hkdVFxZDBmMWMrMy9ITWJqVFRzWHJ1QkxB?=
 =?utf-8?B?UFRMeEJvSGFnY01MOHExMDIwbVZNQ3o1bGM4bVBiVGlOOTlaa2ZkeGR5c2Mx?=
 =?utf-8?B?SVJRU1U5ZkRXNk55Z09oUjV5amZVRkovVUtWRllweUloYzNHck8rVWQ4MkJD?=
 =?utf-8?B?TExrMzRvT0tCazMyeUljSWI5Mm9NWnVVaWVPNm5ZRWpGVTV6WkplTmlsVmYv?=
 =?utf-8?B?ZHFseFJnZkp2YVdDM1hNcnpnY1VsWitZbitUWHlEeUNGNWlJY2pzSGNnVkN4?=
 =?utf-8?Q?lSb9YhajRnaCq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8f81b08-d3e5-4f46-d002-08d8fb2427a1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2021 06:53:17.7754 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 12r3c1K/ZHf15bviQdpCh6++ubIxtfxOvyn2f0UfdTpqTiwlay19qL63U0WVB4sV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4318
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

QW0gMDguMDQuMjEgdW0gMjI6Mzkgc2NocmllYiBBbmRyZXkgR3JvZHpvdnNreToKPgo+IE9uIDIw
MjEtMDQtMDggMjo1OCBwLm0uLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+PiBBbSAwOC4wNC4y
MSB1bSAxODowOCBzY2hyaWViIEFuZHJleSBHcm9kem92c2t5Ogo+Pj4gT24gMjAyMS0wNC0wOCA0
OjMyIGEubS4sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+Pj4gQW0gMDguMDQuMjEgdW0gMTA6
MjIgc2NocmllYiBDaHJpc3RpYW4gS8O2bmlnOgo+Pj4+PiBbU05JUF0KPj4+Pj4+Pgo+Pj4+Pj4+
Cj4+Pj4+Pj4+IEJleW9uZCBibG9ja2luZyBhbGwgZGVsYXllZCB3b3JrcyBhbmQgc2NoZWR1bGVy
IHRocmVhZHMgd2UgYWxzbyAKPj4+Pj4+Pj4gbmVlZCB0byBndWFyYW50ZWUgbm/CoCBJT0NUTCBj
YW4gYWNjZXNzIE1NSU8gcG9zdCBkZXZpY2UgdW5wbHVnIAo+Pj4+Pj4+PiBPUiBpbiBmbGlnaHQg
SU9DVExzIGFyZSBkb25lIGJlZm9yZSB3ZSBmaW5pc2ggcGNpX3JlbW92ZSAKPj4+Pj4+Pj4gKGFt
ZGdwdV9wY2lfcmVtb3ZlIGZvciB1cykuCj4+Pj4+Pj4+IEZvciB0aGlzIEkgc3VnZ2VzdCB3ZSBk
byBzb21ldGhpbmcgbGlrZSB3aGF0IHdlIHdvcmtlZCBvbiB3aXRoIAo+Pj4+Pj4+PiBUYWthc2hp
IEl3YWkgdGhlIEFMU0EgbWFpbnRhaW5lciByZWNlbnRseSB3aGVuIGhlIGhlbHBlZCAKPj4+Pj4+
Pj4gaW1wbGVtZW50aW5nIFBDSSBCQVJzIG1vdmUgc3VwcG9ydCBmb3Igc25kX2hkYV9pbnRlbC4g
VGFrZSBhIAo+Pj4+Pj4+PiBsb29rIGF0Cj4+Pj4+Pj4+IGh0dHBzOi8vY2dpdC5mcmVlZGVza3Rv
cC5vcmcvfmFncm9kem92L2xpbnV4L2NvbW1pdC8/aD15YWRyby9wY2llX2hvdHBsdWcvbW92YWJs
ZV9iYXJzX3Y5LjEmaWQ9Y2JhYTMyNDc5OTcxOGUyYjgyOGE4YzdiNWIwMDFkZDg5Njc0ODQ5NyAK
Pj4+Pj4+Pj4gYW5kCj4+Pj4+Pj4+IGh0dHBzOi8vY2dpdC5mcmVlZGVza3RvcC5vcmcvfmFncm9k
em92L2xpbnV4L2NvbW1pdC8/aD15YWRyby9wY2llX2hvdHBsdWcvbW92YWJsZV9iYXJzX3Y5LjEm
aWQ9ZTM2MzY1ZDlhYjViYmMzMGJkYzIyMWFiNGIzNDM3ZGUzNDQ5MjQ0MCAKPj4+Pj4+Pj4KPj4+
Pj4+Pj4gV2UgYWxzbyBoYWQgc2FtZSBpc3N1ZSB0aGVyZSwgaG93IHRvIHByZXZlbnQgTU1JTyBh
Y2Nlc3NlcyAKPj4+Pj4+Pj4gd2hpbGUgdGhlIEJBUnMgYXJlIG1pZ3JhdGluZy4gV2hhdCB3YXMg
ZG9uZSB0aGVyZSBpcyBhIHJlZmNvdW50IAo+Pj4+Pj4+PiB3YXMgYWRkZWQgdG8gY291bnQgYWxs
IElPQ1RMcyBpbiBmbGlnaHQsIGZvciBhbnkgaW4gZmxpZ2h0wqAgCj4+Pj4+Pj4+IElPQ1RMIHRo
ZSBCQVIgbWlncmF0aW9uIGhhbmRsZXIgd291bGQKPj4+Pj4+Pj4gYmxvY2sgZm9yIHRoZSByZWZj
b3VudCB0byBkcm9wIHRvIDAgYmVmb3JlIGl0IHdvdWxkIHByb2NlZWQsIAo+Pj4+Pj4+PiBmb3Ig
YW55IGxhdGVyIElPQ1RMIGl0IHN0b3BzIGFuZCB3YWl0IGlmIGRldmljZSBpcyBpbiBtaWdyYXRp
b24gCj4+Pj4+Pj4+IHN0YXRlLiBXZSBldmVuIGRvbid0IG5lZWQgdGhlIHdhaXQgcGFydCwgbm90
aGluZyB0byB3YWl0IGZvciwgCj4+Pj4+Pj4+IHdlIGp1c3QgcmV0dXJuIHdpdGggLUVOT0RFViBm
b3IgdGhpcyBjYXNlLgo+Pj4+Pj4+Pgo+Pj4+Pj4+Cj4+Pj4+Pj4gVGhpcyBpcyBlc3NlbnRpYWxs
eSB3aGF0IHRoZSBEUk0gU1JDVSBpcyBkb2luZyBhcyB3ZWxsLgo+Pj4+Pj4+Cj4+Pj4+Pj4gRm9y
IHRoZSBob3RwbHVnIGNhc2Ugd2UgY291bGQgZG8gdGhpcyBpbiB0aGUgdG9wbGV2ZWwgc2luY2Ug
d2UgCj4+Pj4+Pj4gY2FuIHNpZ25hbCB0aGUgZmVuY2UgYW5kIGRvbid0IG5lZWQgdG8gYmxvY2sg
bWVtb3J5IG1hbmFnZW1lbnQuCj4+Pj4+Pgo+Pj4+Pj4KPj4+Pj4+IFRvIG1ha2UgU1JDVSAnd2Fp
dCBmb3InIGFsbCBJT0NUTHMgaW4gZmxpZ2h0IHdlIHdvdWxkIG5lZWQgdG8gCj4+Pj4+PiB3cmFw
IGV2ZXJ5IElPQ1RMICggcHJhY3RpY2FsbHkgLSBqdXN0IGRybV9pb2N0bCBmdW5jdGlvbikgd2l0
aCAKPj4+Pj4+IGRybV9kZXZfZW50ZXIvZHJtX2Rldl9leGl0IC0gY2FuIHdlIGRvIGl0ID8KPj4+
Pj4+Cj4+Pj4KPj4+PiBTb3JyeSB0b3RhbGx5IG1pc3NlZCB0aGlzIHF1ZXN0aW9uLgo+Pj4+Cj4+
Pj4gWWVzLCBleGFjdGx5IHRoYXQuIEFzIGRpc2N1c3NlZCBmb3IgdGhlIGhvdHBsdWcgY2FzZSB3
ZSBjYW4gZG8gdGhpcy4KPj4+Cj4+Pgo+Pj4gVGhpbmtpbmcgbW9yZSBhYm91dCBpdCAtIGFzc3Vt
aW5nIHdlIGFyZcKgIHRyZWF0aW5nIHN5bmNocm9uaXplX3NyY3UgCj4+PiBhcyBhICd3YWl0IGZv
ciBjb21wbGV0aW9uJyBvZiBhbnkgaW4gZmxpZ2h0IHtkcm1fZGV2X2VudGVyLCAKPj4+IGRybV9k
ZXZfZXhpdH0gc2NvcGUsIHNvbWUgb2YgdGhvc2Ugc2NvcGVzIG1pZ2h0IGRvIGRtYV9mZW5jZV93
YWl0IAo+Pj4gaW5zaWRlLiBTaW5jZSB3ZSBoYXZlbid0IGZvcmNlIHNpZ25hbGVkIHRoZSBmZW5j
ZXMgeWV0IHdlIHdpbGwgZW5kIAo+Pj4gdXAgYSBkZWFkbG9jay4gV2UgaGF2ZSB0byBzaWduYWwg
YWxsIHRoZSB2YXJpb3VzIGZlbmNlcyBiZWZvcmUgZG9pbmcgCj4+PiB0aGUgJ3dhaXQgZm9yJy4g
QnV0IHdlIGNhbid0IHNpZ25hbCB0aGUgZmVuY2VzIGJlZm9yZSBzZXR0aW5nIAo+Pj4gJ2Rldi0+
dW5wbHVnZ2VkID0gdHJ1ZScgdG8gcmVqZWN0IGZ1cnRoZXIgQ1MgYW5kIG90aGVyIHN0dWZmIHdo
aWNoIAo+Pj4gbWlnaHQgY3JlYXRlIG1vcmUgZmVuY2VzIHdlIHdlcmUgc3VwcG9zZWQtdG8gZm9y
Y2Ugc2lnbmFsIGFuZCBub3cgCj4+PiBtaXNzZWQgdGhlbS4gRWZmZWN0aXZlbHkgc2V0dGluZyAn
ZGV2LT51bnBsdWdnZWQgPSB0cnVlJyBhbmQgZG9pbmcgCj4+PiBzeW5jaHJvbml6ZV9zcmN1IGlu
IG9uZSBjYWxsIGxpa2UgZHJtX2Rldl91bnBsdWcgZG9lcyB3aXRob3V0IAo+Pj4gc2lnbmFsbGlu
ZyBhbGwgdGhlIGZlbmNlcyBpbiB0aGUgZGV2aWNlIGluIGJldHdlZW4gdGhlc2UgdHdvIHN0ZXBz
IAo+Pj4gbG9va3MgbHVjayBhIHBvc3NpYmxlIGRlYWRsb2NrIHRvIG1lIC0gd2hhdCBkbyB5b3Ug
dGhpbmsgPwo+Pj4KPj4KPj4gSW5kZWVkLCB0aGF0IGlzIGEgcmVhbGx5IGdvb2QgYXJndW1lbnQg
dG8gaGFuZGxlIGl0IHRoZSBzYW1lIHdheSBhcyAKPj4gdGhlIHJlc2V0IGxvY2suCj4+Cj4+IEUu
Zy4gbm90IHRha2luZyBpdCBhdCB0aGUgaGlnaCBsZXZlbCBJT0NUTCwgYnV0IHJhdGhlciB3aGVu
IHRoZSAKPj4gZnJvbnRlbmQgb2YgdGhlIGRyaXZlciBoYXMgYWNxdWlyZWQgYWxsIHRoZSBuZWNl
c3NhcnkgbG9ja3MgKEJPIHJlc3YsIAo+PiBWTSBsb2NrIGV0Yy4uLikgYmVmb3JlIGNhbGxpbmcg
aW50byB0aGUgYmFja2VuZCB0byBhY3R1YWxseSBkbyB0aGluZ3MgCj4+IHdpdGggdGhlIGhhcmR3
YXJlLgo+Pgo+PiBDaHJpc3RpYW4uCj4KPiBGcm9tIHdoYXQgeW91IHNhaWQgSSB1bmRlcnN0YW5k
IHRoYXQgeW91IHdhbnQgdG8gc29sdmUgdGhpcyBwcm9ibGVtIGJ5IAo+IHVzaW5nIGRybV9kZXZf
ZW50ZXIvZXhpdCBicmFja2V0cyBsb3cgZW5vdWdoIGluIHRoZSBjb2RlIHN1Y2ggdGhhdCBpdCAK
PiB3aWxsIG5vdCBpbmNsdWRlIGFuZCBmZW5jZSB3YWl0Lgo+Cj4gQnV0IGluc2VydGluZyBkbXJf
ZGV2X2VudGVyL2V4aXQgb24gdGhlIGhpZ2hlc3QgbGV2ZWwgaW4gZHJtX2lvY3RsIGlzIAo+IG11
Y2ggbGVzcyBlZmZvcnQgYW5kIGxlc3Mgcm9vbSBmb3IgZXJyb3IgdGhlbiBnb2luZyB0aHJvdWdo
IGVhY2ggSU9DVEwgCj4gYW5kIHRyeWluZyB0byBpZGVudGlmeSBhdCB3aGF0IHBvaW50IChwb3Nz
aWJseSBtdWx0aXBsZSBwb2ludHMpIHRoZXkgCj4gYXJlIGFib3V0IHRvIGFjY2VzcyBIVywgc29t
ZSBvZiB0aGlzIGlzIGhpZGRlbiBkZWVwIGluIEhBTCBsYXllcnMgc3VjaCAKPiBhcyBEQyBsYXll
ciBpbiBkaXNwbGF5IGRyaXZlciBvciB0aGUgbXVsdGkgbGF5ZXJzIG9mIHBvd2VycGxheS9TTVUg
Cj4gbGlicmFyaWVzLiBBbHNvLCB3ZSBjYW4ndCBvbmx5IGxpbWl0IG91ci1zZWxmIHRvIGJhY2st
ZW5kIGlmIGJ5IHRoaXMgCj4geW91IG1lYW4gQVNJQyBzcGVjaWZpYyBmdW5jdGlvbnMgd2hpY2gg
YWNjZXNzIHJlZ2lzdGVycy4gV2UgYWxzbyBuZWVkIAo+IHRvIHRha2UgY2FyZSBvZiBhbnkgTU1J
TyBrZXJuZWwgQk8gKFZSQU0gQk9zKSB3aGVyZSB3ZSBtYXkgYWNjZXNzIAo+IGRpcmVjdGx5IE1N
SU8gc3BhY2UgYnkgcG9pbnRlciBmcm9tIHRoZSBmcm9udCBlbmQgb2YgdGhlIGRyaXZlciAoSFcg
Cj4gYWdub3N0aWMpIGFuZCBUVE0vRFJNIGxheWVycy4KCkV4YWN0bHksIHllcy4gVGhlIGtleSBw
b2ludCBpcyB3ZSBuZWVkIHRvIGlkZW50aWZ5IHN1Y2ggcGxhY2VzIGFueXdheSAKZm9yIEdQVSBy
ZXNldCB0byB3b3JrIHByb3Blcmx5LiBTbyB3ZSBjb3VsZCBqdXN0IHBpZ2d5IGJhY2sgaG90cGx1
ZyBvbiAKdG9wIG9mIHRoYXQgd29yayBhbmQgYXJlIGRvbmUuCgo+Cj4gT3VyIHByb2JsZW0gaGVy
ZSBpcyBob3cgdG8gc2lnbmFsIGFsbCB0aGUgZXhpc3RpbmfCoCBmZW5jZXMgb24gb25lIGhhbmQg
Cj4gYW5kIG9uIHRoZSBvdGhlciBwcmV2ZW50IGFueSBuZXcgZG1hX2ZlbmNlIHdhaXRzIGFmdGVy
IHdlIGZpbmlzaGVkIAo+IHNpZ25hbGluZyBleGlzdGluZyBmZW5jZXMuIE9uY2Ugd2Ugc29sdmVk
IHRoaXMgdGhlbiB0aGVyZSBpcyBubyAKPiBwcm9ibGVtIHVzaW5nIGRybV9kZXZfdW5wbHVnIGlu
IGNvbmp1bmN0aW9uIHdpdGggZHJtX2Rldl9lbnRlci9leGl0IGF0IAo+IHRoZSBoaWdoZXN0IGxl
dmVsIG9mIGRybV9pb2N0bCB0byBmbHVzaCBhbnkgSU9DVExzIGluIGZsaWdodCBhbmQgYmxvY2sg
Cj4gYW55IG5ldyBvbmVzLgo+Cj4gSU1ITyB3aGVuIHdlIHNwZWFrIGFib3V0IHNpZ25hbGxpbmcg
YWxsIGZlbmNlcyB3ZSBkb24ndCBtZWFuIEFMTCB0aGUgCj4gY3VycmVudGx5IGV4aXN0aW5nIGRt
YV9mZW5jZSBzdHJ1Y3RzICh0aGV5IGFyZSBzcHJlYWQgYWxsIG92ZXIgdGhlIAo+IHBsYWNlKSBi
dXQgcmF0aGVyIHNpZ25hbCBhbGwgdGhlIEhXIGZlbmNlcyBiZWNhdXNlIEhXIGlzIHdoYXQncyBn
b25lIAo+IGFuZCB3ZSBjYW4ndCBleHBlY3QgZm9yIHRob3NlIGZlbmNlcyB0byBiZSBldmVyIHNp
Z25hbGVkLiBBbGwgdGhlIHJlc3QgCj4gc3VjaCBhczogc2NoZWR1bGVyIGZlbmNlcyzCoCB1c2Vy
IGZlbmNlcywgZHJtX2dlbSByZXNlcnZhdGlvbiBvYmplY3RzIAo+IGUudC5jLiBhcmUgZWl0aGVy
IGRlcGVuZGVudCBvbiB0aG9zZSBIVyBmZW5jZXMgYW5kIGhlbmNlIHNpZ25hbGluZyB0aGUgCj4g
SFcgZmVuY2VzIHdpbGwgaW4gdHVybiBzaWduYWwgdGhlbSBvciwgYXJlIG5vdCBpbXBhY3RlZCBi
eSB0aGUgSFcgCj4gYmVpbmcgZ29uZSBhbmQgaGVuY2UgY2FuIHN0aWxsIGJlIHdhaXRlZCBvbiBh
bmQgd2lsbCBjb21wbGV0ZS4gSWYgdGhpcyAKPiBhc3N1bXB0aW9uIGlzIGNvcnJlY3QgdGhlbiBJ
IHRoaW5rIHRoYXQgd2Ugc2hvdWxkIHVzZSBzb21lIGZsYWcgdG8gCj4gcHJldmVudCBhbnkgbmV3
IHN1Ym1pc3Npb24gdG8gSFcgd2hpY2ggY3JlYXRlcyBIVyBmZW5jZXMgKHNvbWV3aGVyZSAKPiBh
cm91bmQgYW1kZ3B1X2ZlbmNlX2VtaXQpLCB0aGVuIHRyYXZlcnNlIGFsbCBleGlzdGluZyBIVyBm
ZW5jZXMgCj4gKGN1cnJlbnRseSB0aGV5IGFyZSBzcHJlYWQgaW4gYSBmZXcgcGxhY2VzIHNvIG1h
eWJlIHdlIG5lZWQgdG8gdHJhY2sgCj4gdGhlbSBpbiBhIGxpc3QpIGFuZCBzaWduYWwgdGhlbS4g
QWZ0ZXIgdGhhdCBpdCdzIHNhZmUgdG8gY2FsIAo+IGRybV9kZXZfdW5wbHVnIGFuZCBiZSBzdXJl
IHN5bmNocm9uaXplX3NyY3Ugd29uJ3Qgc3RhbGwgYmVjYXVzZSBvZiBvZiAKPiBkbWFfZmVuY2Vf
d2FpdC4gQWZ0ZXIgdGhhdCB3ZSBjYW4gcHJvY2VlZCB0byBjYW5jZWxpbmcgd29yayBpdGVtcywg
Cj4gc3RvcHBpbmcgc2NoZWR1bGVycyBlLnQuYy4KClRoYXQgaXMgcHJvYmxlbWF0aWMgYXMgd2Vs
bCBzaW5jZSB5b3UgbmVlZCB0byBtYWtlIHN1cmUgdGhhdCB0aGUgCnNjaGVkdWxlciBpcyBub3Qg
Y3JlYXRpbmcgYSBuZXcgaGFyZHdhcmUgZmVuY2UgaW4gdGhlIG1vbWVudCB5b3UgdHJ5IHRvIApz
aWduYWwgYWxsIG9mIHRoZW0uIEl0IHdvdWxkIHJlcXVpcmUgYW5vdGhlciBTUkNVIG9yIGxvY2sg
Zm9yIHRoaXMuCgpDaHJpc3RpYW4uCgo+Cj4gQW5kcmV5Cj4KPgo+Pgo+Pj4gQW5kcmV5Cj4+Pgo+
Pj4KPj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFt
ZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
