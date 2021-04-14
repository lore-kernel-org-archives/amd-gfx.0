Return-Path: <SRS0=h6PS=JL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0939C433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Apr 2021 14:36:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D1E860E09
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Apr 2021 14:36:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D1E860E09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D3F66E8AF;
	Wed, 14 Apr 2021 14:36:13 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2045.outbound.protection.outlook.com [40.107.237.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EAEA6E8AF
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Apr 2021 14:36:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZoHm4+Z63pwdKY8S8H0fM84BY/ccJnw8IlAIcsfeu1BUJsfB0ixPv0fn38dmkRrOpV/uKyvzcEj7TS9ORKqI5oAOkMg8TQ/o/rohndGMOxVmQ6+0ryST1CJu2Py8H5Cpv2M/m3dP8MR1SHGMjwl70T4r/eLNlaHqRq0roTOen4j5XcmFk7+8y/jt5zB/xNCcp/RmaV8Tz+AaQV8tnD6E8EQe1/xLlDGx0McbK6XAxPyntOeahIN/F+sFDBDBSeLL4bQupLd0KQSLcxtvNivt8bi8VhVJbDQ2qMRkVNpFnRixZCgIcWs8k0KPOfgbRe1ZrCfBzJU0lM1kQsU9NYpsZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/tVrVTK7G72kmdY6LISwL4F3SvgjwvDuH2ye6crYJVg=;
 b=eklL1fMcgqxQwAcCaeQSkmyiDkrrEbvtV0oubNw3B2LjFJBiHmskaqmnySxGpHIg85ZOxN4UXethtqAXtZ15gPpHxF2CDxpZpAzX+B7PAslHHmtJKYYzyquPFddOeYn+eyIWmklNtv0SaKCjwIT1Qf2P0ORm2h202c885+D8MHL6Zvsw28YTB5aBbz0yebPgb+NlNUmBu45YSt5prbOos2TzOGx6GWnRstbuReDpSHvGE6hlIzZXJUWJuqcxAoWXFqpx+cpTOcE9U5yBB4LJeKmJjr/vtXhUIebZz7ccCAraH8ertGCgeQ8rphaTqhjWmyd6dXtBhmHVLPLcEOSgKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/tVrVTK7G72kmdY6LISwL4F3SvgjwvDuH2ye6crYJVg=;
 b=ADiePqaPdnPeMDr/y0MJNl4iiHvN/YVa36O0WlTmOu5vyKFGX8QteFG4UGK6wCdHaUaDSIMLf/TxBKTujLtH/9XVQJGS91jHgr8lHtq8iFPYIaSXj37nxU5SvqrN/UQrmEDHOIlXc9fazfHOb1xNpVlW7eVXHs7Wn1KyCikjr1c=
Authentication-Results: ffwll.ch; dkim=none (message not signed)
 header.d=none;ffwll.ch; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SA0PR12MB4447.namprd12.prod.outlook.com (2603:10b6:806:9b::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Wed, 14 Apr
 2021 14:36:06 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::89b0:10d7:12d3:efde]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::89b0:10d7:12d3:efde%5]) with mapi id 15.20.4020.022; Wed, 14 Apr 2021
 14:36:06 +0000
Subject: Re: [PATCH 0/4] Refine GPU recovery sequence to enhance its stability
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Li, Dennis" <Dennis.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>, Daniel Vetter <daniel@ffwll.ch>
References: <20210318072339.28736-1-Dennis.Li@amd.com>
 <01f69c6f-02a3-3387-db6b-0fa1bfa9bd17@amd.com>
 <70a534b7-2e55-cdd7-2f82-3b8799967aa0@amd.com>
 <62a329d4-ffd1-3ac1-03eb-dd0089b75541@amd.com>
 <b6a24d3f-4fe6-c642-b478-36e386aa906d@gmail.com>
 <80713dbe-411c-d79b-34ba-b67bc3a50dc5@amd.com>
 <cd94e02c-11c8-0198-ab70-0ceee54d437b@amd.com>
 <aaa2b266-f091-dd9c-e49d-5e528decfbd7@amd.com>
 <a970101f-89f1-8bdf-51d9-4a4e5e0f9e9a@amd.com>
 <ecf465a2-d4fc-1cbf-a9d5-39c3844f23bb@amd.com>
 <2894bf97-8c39-6610-c479-b089c46513e7@amd.com>
 <0224d3c2-1bd0-3941-fa7f-5667027368fa@amd.com>
 <a92e8f96-029f-6d21-4430-7e3116c21dea@amd.com>
 <9ea8f0c1-8d58-f4ab-e2a9-1ef8fd00718c@amd.com>
 <9b9e84ca-b259-b683-ef9d-1f9be95e1734@gmail.com>
 <ae02bdf3-8f4b-ed38-b62d-c3b606554a59@amd.com>
 <8b2db19a-d5f9-a7e3-6662-b990b7b3db2f@amd.com>
 <0fe87232-08ec-d804-ff55-2716b8e09c12@amd.com>
 <e37d6954-46e7-e7eb-22c3-a5b19829fe6c@amd.com>
 <65cd86df-b660-6c8a-348e-d511b61d91d4@amd.com>
 <689099ea-c1e9-31ea-6a5a-070562cb7440@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <b30c75cf-9b00-b52d-1ac1-ccd33e02bfe3@amd.com>
Date: Wed, 14 Apr 2021 10:36:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <689099ea-c1e9-31ea-6a5a-070562cb7440@amd.com>
Content-Language: en-US
X-Originating-IP: [2607:fea8:3edf:49b0:680d:86cf:cd97:28aa]
X-ClientProxiedBy: YTXPR0101CA0014.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::27) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:680d:86cf:cd97:28aa]
 (2607:fea8:3edf:49b0:680d:86cf:cd97:28aa) by
 YTXPR0101CA0014.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.21 via Frontend Transport; Wed, 14 Apr 2021 14:36:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af4f6f52-d040-40ab-18d4-08d8ff52a306
X-MS-TrafficTypeDiagnostic: SA0PR12MB4447:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4447A5AF82452A6C3B152CC5EA4E9@SA0PR12MB4447.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IrOFzV8NBqKy09FFfw28eQsy26jO6po/7rY748Xq//7pz2B360hCo27xKhRGEZzEjq8qtgyYz7tn5fylH5EMyt7YT/zTCbxOz0v9w1zZL4hLl03+H43JxKsDF8K782gwyhv4gmmFJ3GTjtcM2T1xmoV7ePUdWsNmq2kWL5febb0Z/8tIOO8lnJyEhgGmJT5zX6ncKnOZbCOCwq9CD42rWsxmN78JS9TumM8DBOcCSCQ6WXcIqyW3YmHVYdh6y3y6EnQJBn1te/T2/fFA8XTii/VJ2KNiWmSbFm5aoKQdDFKtN17f1eKpq+zb1rgo3FFe2jsc3p76G7m+UShF6aCjbHqYC7C3Zw0qjN3GFCDlsdKpjKINzkTia5jGiF2bjoc9AVKTiDnCGzFnMmHy5mT0dUPyRVLrQuOHYi7pwla664M7Dug0NLS6QD/8meHFePQzhBG9a2cfZ3TWnuwJKcOUvj6yLaX5l17LQbMLZYN2i5czUN7PxxJ4xR/ehl1XLKRov1bipu2pMwW4Wpi9p/JcapD+CEmuJBXrrIOjnBoDFfRVcGZQa04xk4l3pFXGdp/Rcsm3OilE13gvT62Ce8SNeP4/lBzITxfYtr1NwyJodiXxmbSjh3g2SqAnPGoLj2zX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(376002)(39860400002)(396003)(366004)(66946007)(316002)(66476007)(52116002)(921005)(66574015)(86362001)(83380400001)(44832011)(5660300002)(966005)(31696002)(186003)(45080400002)(2616005)(36756003)(30864003)(8676002)(31686004)(16526019)(2906002)(110136005)(38100700002)(8936002)(66556008)(53546011)(478600001)(6486002)(60764002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?K1RvcEdNUmN2RFRzRDRzVm9SaFJWSnNBaWdwcUwzM0dla0ZBWGl1aFhSeFcz?=
 =?utf-8?B?UXduV0FrMTZhWWlwWU5aUTFrMW5Rd1ZCS1B2ZC93aStYR2lPcnpsSDlXU0dQ?=
 =?utf-8?B?ZkZtdFBWY05zK2JSRjNYZjNMZGw0cEgwcTBHNktqL0lYUkZVcGczSCt4WXhQ?=
 =?utf-8?B?azlGUnhZREdDWkdUbTZ1UVR0VHdtNmZEeHV4a1ZRenlVR2o3ZXRxc0V5OFVZ?=
 =?utf-8?B?M0VFSjZNYjFaZFNydVg1azVycHJMenphSlZYejJFZkdhWlE5WXN1bTltdjhu?=
 =?utf-8?B?UFFHL0wxYzlEejR4N0hHUkVSeGFPdVZ1N2pnanhkS2xWMEdpb2xGSXRzTEtk?=
 =?utf-8?B?aHBxT2tEcDRqUlpSWk0vaWFrMkYxR3lSU0UxTjR2ZWZ3M3dKSGxlY0VEVzV1?=
 =?utf-8?B?TFdRU0FOYzNrbUxKOVFQZ1FqY0JPTHN2VnQ5Z1dHZWdSbjJ2MnVOcVl5TkJa?=
 =?utf-8?B?c1BVK1VnUWVOZG9TREFONXNCNG9DZjF3OFFlTi9DaGZvbE1jL3VnbTZVY2lw?=
 =?utf-8?B?YjFlQWM5OE8rV3kyMHVRcFdEUS9ONGF1cSt6bjVWOE9Hc1YwLzdFU2xDM0FC?=
 =?utf-8?B?emdmeVlCcFRFRWh1SXorTStrVHpMandYaGhTbXpRamlCS0dNcEEvMW80VW0z?=
 =?utf-8?B?d29qenIwSkd5aVYzdEN1RE0wZ05jeTNSM0ZHdTN0cUVhTEJ0ekE5Sk50Y0Rp?=
 =?utf-8?B?bVYxUzN2Mnc4TGprTEFoKzY1ZHZudERYdnp4TGRSS2NWUFh5bk1vcTQ5TG9a?=
 =?utf-8?B?eFRMdDdnUElMUzlVbVpyYkw0bStLQXpnNkczdHhsREpLMXYrMk9EWXM1RDVT?=
 =?utf-8?B?TXo4MXErQ3FBR3FTZ25qSWphbm1Wb2tTOUNDZWw3Z0NpbDNzUWo2elREaU9a?=
 =?utf-8?B?WkVwNGw2UmJBdjdSQVVHZE1sbXMwZ2RXelJKZ1VYNnp5TE1idWxWcTJMQmdz?=
 =?utf-8?B?QXhUa2JmM3JwRlpyeVN2MkFENnRyUk54aUE1SUF2aXNvTTdOT29BeWpGRUZL?=
 =?utf-8?B?MGN5cTU5OWR6R2tuVTR2WllMSGZubHRKdEVEQmJ3eFJ2YWhsdWVkZ0prZHRP?=
 =?utf-8?B?Y3pDaTA1cVhjdzlSVERzejZhYW9OYkpTMWFUZm8zNGxJN2JYTlJ4ZThubDgz?=
 =?utf-8?B?MU5NaDNaeFZOUTFqUy84NHAvdUxOWnExNDY4VGEzdFFwZHlMWmtsdXZCcitH?=
 =?utf-8?B?SU1xaWJ2aThFZVN5YnV3cXRVTUk1NVpPTlowY0tqN21Gd3UrVG41RFM2VWRB?=
 =?utf-8?B?RzR2dDlualRHNGd5TGRBU0xPaUY5TkJVbkovOFdMcjdaajZGenh5TTU3emZl?=
 =?utf-8?B?TUc4bXc4WmFvQksyeUxiZ2xnclcxVnYvL05zSENESzNHZFkvOU56VGgrYThQ?=
 =?utf-8?B?ejc3dlRhYytlZGpOcnR0WFo1WHhKbm1BTE1oZDBmS2hOdjRoWXF6MzNEM2ww?=
 =?utf-8?B?MktpUDA3RTh0MXd1ZysvTjFZU3Q4QlRSK2I2QlFCSTR0NUpTZVRiU0JRd0t0?=
 =?utf-8?B?czJlZkRUTk5sLzNrTDg1OVR2ZGZtTThmam91cFI1MlpHRlVGd1VlZzRRZnhy?=
 =?utf-8?B?Vk9PVFozYVc5bFlMZlNNejBrc1dwS25SSTZHSkhQci81K3VHQmVjWUZ1WHUv?=
 =?utf-8?B?Wm0vWjFuMzYzOUpLbnpDYlhsWGowakhNUVFmWHFFbWFueDlDWCtXSDRtU3ZR?=
 =?utf-8?B?SGFqbGlQc0VIaUwrZHJJUTZKaUdaYkdCRDE0TG9ZK0NLTlI0MXoxbjN1eGpp?=
 =?utf-8?B?T0VVR1p3VUVuUzVyeENnZS9Xb1ZrM0ZZTGNab1BXbFE5YUtnd1dVdzg1ZTJa?=
 =?utf-8?B?UVc2bWVRUWQ0K2ZvbHYzMzFZVDFEV2Fha2lSR2xsYStVUFhCYm5CU2ovQkd5?=
 =?utf-8?Q?XmNk0RSycqySf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af4f6f52-d040-40ab-18d4-08d8ff52a306
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2021 14:36:06.3210 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TbBlUDbJ5+LrqGx69kKzsNpK3YIjpCCNJH8YITeyxiPKqVtZ8fGUm1c6vfds9yXMHPWzGNskh50RZsqpEtXZmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4447
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

Ck9uIDIwMjEtMDQtMTQgMzowMSBhLm0uLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+IEFtIDEz
LjA0LjIxIHVtIDIwOjMwIHNjaHJpZWIgQW5kcmV5IEdyb2R6b3Zza3k6Cj4+Cj4+IE9uIDIwMjEt
MDQtMTMgMjoyNSBwLm0uLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+Pj4KPj4+Cj4+PiBBbSAx
My4wNC4yMSB1bSAyMDoxOCBzY2hyaWViIEFuZHJleSBHcm9kem92c2t5Ogo+Pj4+Cj4+Pj4gT24g
MjAyMS0wNC0xMyAyOjAzIHAubS4sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+Pj4+IEFtIDEz
LjA0LjIxIHVtIDE3OjEyIHNjaHJpZWIgQW5kcmV5IEdyb2R6b3Zza3k6Cj4+Pj4+Pgo+Pj4+Pj4g
T24gMjAyMS0wNC0xMyAzOjEwIGEubS4sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+Pj4+Pj4g
QW0gMTIuMDQuMjEgdW0gMjI6MDEgc2NocmllYiBBbmRyZXkgR3JvZHpvdnNreToKPj4+Pj4+Pj4K
Pj4+Pj4+Pj4gT24gMjAyMS0wNC0xMiAzOjE4IHAubS4sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6
Cj4+Pj4+Pj4+PiBBbSAxMi4wNC4yMSB1bSAyMToxMiBzY2hyaWViIEFuZHJleSBHcm9kem92c2t5
Ogo+Pj4+Pj4+Pj4+IFtTTklQXQo+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+IFNvIHdoYXQncyB0
aGUgcmlnaHQgYXBwcm9hY2ggPyBIb3cgd2UgZ3VhcmFudGVlIHRoYXQgd2hlbiAKPj4+Pj4+Pj4+
Pj4+IHJ1bm5pbmcgYW1kZ3B1X2ZlbmNlX2RyaXZlcl9mb3JjZV9jb21wbGV0aW9uIHdlIHdpbGwg
c2lnbmFsIAo+Pj4+Pj4+Pj4+Pj4gYWxsIHRoZSBIVyBmZW5jZXMgYW5kIG5vdCByYWNpbmcgYWdh
aW5zdCBzb21lIG1vcmUgZmVuY2VzIAo+Pj4+Pj4+Pj4+Pj4gaW5zZXJ0aW9uIGludG8gdGhhdCBh
cnJheSA/Cj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+PiBXZWxsIEkgd291bGQg
c3RpbGwgc2F5IHRoZSBiZXN0IGFwcHJvYWNoIHdvdWxkIGJlIHRvIGluc2VydCAKPj4+Pj4+Pj4+
Pj4gdGhpcyBiZXR3ZWVuIHRoZSBmcm9udCBlbmQgYW5kIHRoZSBiYWNrZW5kIGFuZCBub3QgcmVs
eSBvbiAKPj4+Pj4+Pj4+Pj4gc2lnbmFsaW5nIGZlbmNlcyB3aGlsZSBob2xkaW5nIHRoZSBkZXZp
Y2Ugc3JjdS4KPj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4gTXkgcXVlc3Rpb24gaXMs
IGV2ZW4gbm93LCB3aGVuIHdlIHJ1biAKPj4+Pj4+Pj4+PiBhbWRncHVfZmVuY2VfZHJpdmVyX2Zp
bmlfaHctPmFtZGdwdV9mZW5jZV93YWl0X2VtcHR5IG9yIAo+Pj4+Pj4+Pj4+IGFtZGdwdV9mZW5j
ZV9kcml2ZXJfZmluaV9ody0+YW1kZ3B1X2ZlbmNlX2RyaXZlcl9mb3JjZV9jb21wbGV0aW9uLCAK
Pj4+Pj4+Pj4+PiB3aGF0IHRoZXJlIHByZXZlbnRzIGEgcmFjZSB3aXRoIGFub3RoZXIgZmVuY2Ug
YmVpbmcgYXQgdGhlIAo+Pj4+Pj4+Pj4+IHNhbWUgdGltZSBlbWl0dGVkIGFuZCBpbnNlcnRlZCBp
bnRvIHRoZSBmZW5jZSBhcnJheSA/IExvb2tzIAo+Pj4+Pj4+Pj4+IGxpa2Ugbm90aGluZy4KPj4+
Pj4+Pj4+Pgo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+IEVhY2ggcmluZyBjYW4gb25seSBiZSB1c2VkIGJ5
IG9uZSB0aHJlYWQgYXQgdGhlIHNhbWUgdGltZSwgCj4+Pj4+Pj4+PiB0aGlzIGluY2x1ZGVzIGVt
aXR0aW5nIGZlbmNlcyBhcyB3ZWxsIGFzIG90aGVyIHN0dWZmLgo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+
IER1cmluZyBHUFUgcmVzZXQgd2UgbWFrZSBzdXJlIG5vYm9keSB3cml0ZXMgdG8gdGhlIHJpbmdz
IGJ5IAo+Pj4+Pj4+Pj4gc3RvcHBpbmcgdGhlIHNjaGVkdWxlciBhbmQgdGFraW5nIHRoZSBHUFUg
cmVzZXQgbG9jayAoc28gdGhhdCAKPj4+Pj4+Pj4+IG5vYm9keSBlbHNlIGNhbiBzdGFydCB0aGUg
c2NoZWR1bGVyIGFnYWluKS4KPj4+Pj4+Pj4KPj4+Pj4+Pj4KPj4+Pj4+Pj4gV2hhdCBhYm91dCBk
aXJlY3Qgc3VibWlzc2lvbnMgbm90IHRocm91Z2ggc2NoZWR1bGVyIC0gCj4+Pj4+Pj4+IGFtZGdw
dV9qb2Jfc3VibWl0X2RpcmVjdCwgSSBkb24ndCBzZWUgaG93IHRoaXMgaXMgcHJvdGVjdGVkLgo+
Pj4+Pj4+Cj4+Pj4+Pj4gVGhvc2Ugb25seSBoYXBwZW4gZHVyaW5nIHN0YXJ0dXAgYW5kIEdQVSBy
ZXNldC4KPj4+Pj4+Cj4+Pj4+Pgo+Pj4+Pj4gT2ssIGJ1dCB0aGVuIGxvb2tzIGxpa2UgSSBhbSBt
aXNzaW5nIHNvbWV0aGluZywgc2VlIHRoZSBmb2xsb3dpbmcgCj4+Pj4+PiBzdGVwcyBpbiBhbWRn
cHVfcGNpX3JlbW92ZSAtCj4+Pj4+Pgo+Pj4+Pj4gMSkgVXNlIGRpc2FibGVfaXJxIEFQSSBmdW5j
dGlvbiB0byBzdG9wIGFuZCBmbHVzaCBhbGwgaW4gZmxpZ2h0IAo+Pj4+Pj4gSFcgaW50ZXJydXB0
cyBoYW5kbGVycwo+Pj4+Pj4KPj4+Pj4+IDIpIEdyYWIgdGhlIHJlc2V0IGxvY2sgYW5kIHN0b3Ag
YWxsIHRoZSBzY2hlZHVsZXJzCj4+Pj4+Pgo+Pj4+Pj4gQWZ0ZXIgYWJvdmUgMiBzdGVwcyB0aGUg
SFcgZmVuY2VzIGFycmF5IGlzIGlkbGUsIG5vIG1vcmUgCj4+Pj4+PiBpbnNlcnRpb25zIGFuZCBu
byBtb3JlIGV4dHJhY3Rpb25zIGZyb20gdGhlIGFycmF5Cj4+Pj4+Pgo+Pj4+Pj4gMykgUnVuIG9u
ZSB0aW1lIGFtZGdwdV9mZW5jZV9wcm9jZXNzIHRvIHNpZ25hbCBhbGwgY3VycmVudCBIVyBmZW5j
ZXMKPj4+Pj4+Cj4+Pj4+PiA0KSBTZXQgZHJtX2Rldl91bnBsdWcgKHdpbGwgJ2ZsdXNoJyBhbGwg
aW4gZmxpZ2h0IElPQ1RMcyksIAo+Pj4+Pj4gcmVsZWFzZSB0aGUgR1BVIHJlc2V0IGxvY2sgYW5k
IGdvIG9uIHdpdGggdGhlIHJlc3Qgb2YgdGhlIAo+Pj4+Pj4gc2VxdWVuY2UgKGNhbmNlbCB0aW1l
cnMsIHdvcmsgaXRlbXMgZS50LmMpCj4+Pj4+Pgo+Pj4+Pj4gV2hhdCdzIHByb2JsZW1hdGljIGlu
IHRoaXMgc2VxdWVuY2UgPwo+Pj4+Pgo+Pj4+PiBkcm1fZGV2X3VucGx1ZygpIHdpbGwgd2FpdCBm
b3IgdGhlIElPQ1RMcyB0byBmaW5pc2guCj4+Pj4+Cj4+Pj4+IFRoZSBJT0NUTHMgaW4gdHVybiBj
YW4gd2FpdCBmb3IgZmVuY2VzLiBUaGF0IGNhbiBiZSBib3RoIGhhcmR3YXJlIAo+Pj4+PiBmZW5j
ZXMsIHNjaGVkdWxlciBmZW5jZXMsIGFzIHdlbGwgYXMgZmVuY2VzIGZyb20gb3RoZXIgZGV2aWNl
cyAKPj4+Pj4gKGFuZCBLSVEgZmVuY2VzIGZvciByZWdpc3RlciB3cml0ZXMgdW5kZXIgU1JJT1Ys
IGJ1dCB3ZSBjYW4gCj4+Pj4+IGhvcGVmdWxseSBpZ25vcmUgdGhlbSBmb3Igbm93KS4KPj4+Pj4K
Pj4+Pj4gV2UgaGF2ZSBoYW5kbGVkIHRoZSBoYXJkd2FyZSBmZW5jZXMsIGJ1dCB3ZSBoYXZlIG5v
IGlkZWEgd2hlbiB0aGUgCj4+Pj4+IHNjaGVkdWxlciBmZW5jZXMgb3IgdGhlIGZlbmNlcyBmcm9t
IG90aGVyIGRldmljZXMgd2lsbCBzaWduYWwuCj4+Pj4+Cj4+Pj4+IFNjaGVkdWxlciBmZW5jZXMg
d29uJ3Qgc2lnbmFsIHVudGlsIHRoZSBzY2hlZHVsZXIgdGhyZWFkcyBhcmUgCj4+Pj4+IHJlc3Rh
cnRlZCBvciB3ZSBzb21laG93IGNhbmNlbCB0aGUgc3VibWlzc2lvbnMuIERvYWJsZSwgYnV0IHRy
aWNreSAKPj4+Pj4gYXMgd2VsbC4KPj4+Pgo+Pj4+Cj4+Pj4gRm9yIHNjaGVkdWxlciBmZW5jZXMg
SSBhbSBub3Qgd29ycmllZCwgZm9yIHRoZSAKPj4+PiBzY2hlZF9mZW5jZS0+ZmluaXNoZWQgZmVu
Y2UgdGhleSBhcmUgYnkgZGVmaW5pdGlvbiBhdHRhY2hlZCB0byBIVyAKPj4+PiBmZW5jZXMgd2hp
Y2ggYWxyZWFkeSBzaWduYWxlZGZvciBzY2hlZF9mZW5jZS0+c2NoZWR1bGVkIHdlIHNob3VsZCAK
Pj4+PiBydW4gZHJtX3NjaGVkX2VudGl0eV9raWxsX2pvYnMgZm9yIGVhY2ggZW50aXR5IGFmdGVy
IHN0b3BwaW5nIHRoZSAKPj4+PiBzY2hlZHVsZXIgdGhyZWFkcyBhbmQgYmVmb3JlIHNldHRpbmcg
ZHJtX2Rldl91bnBsdWcuCj4+Pgo+Pj4gV2VsbCBleGFjdGx5IHRoYXQgaXMgd2hhdCBpcyB0cmlj
a3kgaGVyZS4gCj4+PiBkcm1fc2NoZWRfZW50aXR5X2tpbGxfam9icygpIGFzc3VtZXMgdGhhdCB0
aGVyZSBhcmUgbm8gbW9yZSBqb2JzIAo+Pj4gcHVzaGVkIGludG8gdGhlIGVudGl0eS4KPj4+Cj4+
PiBXZSBhcmUgcmFjaW5nIGhlcmUgb25jZSBtb3JlIGFuZCBuZWVkIHRvIGhhbmRsZSB0aGF0Lgo+
Pgo+Pgo+PiBCdXQgd2h5LCBJIHdyb3RlIGFib3ZlIHRoYXQgd2UgZmlyc3Qgc3RvcCB0aGUgYWxs
IHNjaGVkdWxlcnMsIHRoZW4gCj4+IG9ubHkgY2FsbCBkcm1fc2NoZWRfZW50aXR5X2tpbGxfam9i
cy4KPgo+IFRoZSBzY2hlZHVsZXJzIGNvbnN1bWluZyBqb2JzIGlzIG5vdCB0aGUgcHJvYmxlbSwg
d2UgYWxyZWFkeSBoYW5kbGUgCj4gdGhhdCBjb3JyZWN0Lgo+Cj4gVGhlIHByb2JsZW0gaXMgdGhh
dCB0aGUgZW50aXRpZXMgbWlnaHQgY29udGludWUgZmVlZGluZyBzdHVmZiBpbnRvIHRoZSAKPiBz
Y2hlZHVsZXIuCgoKTWlzc2VkIHRoYXQuwqAgT2ssIGNhbiBJIGp1c3QgdXNlIG5vbiBzbGVlcGlu
ZyBSQ1Ugd2l0aCBhIGZsYWcgYXJvdW5kIApkcm1fc2NoZWRfZW50aXR5X3B1c2hfam9iIGF0IHRo
ZSBhbWRncHUgbGV2ZWwgKG9ubHkgMiBmdW5jdGlvbnMgY2FsbCBpdCAKLSBhbWRncHVfY3Nfc3Vi
bWl0IGFuZCBhbWRncHVfam9iX3N1Ym1pdCkgYXMgYSBwcmVsaW1pbmFyeSBzdGVwIHRvIGZsdXNo
IAphbmQgYmxvY2sgaW4gZmxpZ2h0IGFuZCBmdXR1cmUgc3VibWlzc2lvbnMgdG8gZW50aXR5IHF1
ZXVlID8KCgo+Cj4+Pgo+Pj4+Pgo+Pj4+PiBGb3Igd2FpdGluZyBmb3Igb3RoZXIgZGV2aWNlIEkg
aGF2ZSBubyBpZGVhIGlmIHRoYXQgY291bGRuJ3QgCj4+Pj4+IGRlYWRsb2NrIHNvbWVob3cuCj4+
Pj4KPj4+Pgo+Pj4+IFllYSwgbm90IHN1cmUgZm9yIGltcG9ydGVkIGZlbmNlcyBhbmQgZG1hX2J1
ZnMsIEkgd291bGQgYXNzdW1lIHRoZSAKPj4+PiBvdGhlciBkZXZpY2VzIHNob3VsZCBub3QgYmUg
aW1wYWN0ZWQgYnkgb3VyIGRldmljZSByZW1vdmFsIGJ1dCwgd2hvIAo+Pj4+IGtub3dzLi4uCj4+
Pj4KPj4+PiBTbyBJIGd1ZXNzIHdlIGFyZSBOT1QgZ29pbmcgd2l0aCBmaW5hbGl6aW5nIEhXIGZl
bmNlcyBiZWZvcmUgCj4+Pj4gZHJtX2Rldl91bnBsdWcgYW5kIGluc3RlYWQgd2lsbCBqdXN0IGNh
bGwgZHJtX2Rldl9lbnRlci9leGl0IGF0IHRoZSAKPj4+PiBiYWNrLWVuZHMgYWxsIG92ZXIgdGhl
IHBsYWNlIHdoZXJlIHRoZXJlIGFyZSBNTUlPIGFjY2Vzc2VzID8KPj4+Cj4+PiBHb29kIHF1ZXN0
aW9uLiBBcyB5b3Ugc2FpZCB0aGF0IGlzIHJlYWxseSB0aGUgaGFyZCBwYXRoLgo+Pj4KPj4+IEhh
bmRsaW5nIGl0IGFsbCBhdCBvbmNlIGF0IElPQ1RMIGxldmVsIGNlcnRhaW5seSBoYXMgc29tZSBh
cHBlYWwgYXMgCj4+PiB3ZWxsLCBidXQgSSBoYXZlIG5vIGlkZWEgaWYgd2UgY2FuIGd1YXJhbnRl
ZSB0aGF0IHRoaXMgaXMgbG9jayBmcmVlLgo+Pgo+Pgo+PiBNYXliZSBqdXN0IGVtcGlyaWNhbGx5
IC0gbGV0J3MgdHJ5IGl0IGFuZCBzZWUgdW5kZXIgZGlmZmVyZW50IHRlc3QgCj4+IHNjZW5hcmlv
cyB3aGF0IGFjdHVhbGx5IGhhcHBlbnPCoCA/Cj4KPiBOb3QgYSBnb29kIGlkZWEgaW4gZ2VuZXJh
bCwgd2UgaGF2ZSB0aGF0IGFwcHJvYWNoIHdheSB0byBvZnRlbiBhdCBBTUQgCj4gYW5kIGFyZSB0
aGVuIHN1cnByaXNlZCB0aGF0IGV2ZXJ5dGhpbmcgd29ya3MgaW4gUUEgYnV0IGZhaWxzIGluIAo+
IHByb2R1Y3Rpb24uCj4KPiBCdXQgRGFuaWVsIGFscmVhZHkgbm90ZWQgaW4gaGlzIHJlcGx5IHRo
YXQgd2FpdGluZyBmb3IgYSBmZW5jZSB3aGlsZSAKPiBob2xkaW5nIHRoZSBTUkNVIGlzIGV4cGVj
dGVkIHRvIHdvcmsuCj4KPiBTbyBsZXQncyBzdGljayB3aXRoIHRoZSBhcHByb2FjaCBvZiBoaWdo
IGxldmVsIGxvY2tpbmcgZm9yIGhvdHBsdWcuCgoKVG8gbXkgdW5kZXJzdGFuZGluZyB0aGlzIGlz
IHRydWUgZm9yIG90aGVyIGRldmlzZXMsIG5vdCB0aGUgb25lIGJlaW5nIApleHRyYWN0ZWQsIGZv
ciBoaW0geW91IHN0aWxsIG5lZWQgdG8gZG8gYWxsIHRoZSBIVyBmZW5jZSBzaWduYWxsaW5nIApk
YW5jZSBiZWNhdXNlIHRoZSBIVyBpcyBnb25lIGFuZCB3ZSBibG9jayBhbnkgVERScyAod2hpY2gg
d29uJ3QgaGVscCAKYW55d2F5KS4KCkFuZHJleQoKCj4KPiBDaHJpc3RpYW4uCj4KPj4KPj4gQW5k
cmV5Cj4+Cj4+Cj4+Pgo+Pj4gQ2hyaXN0aWFuLgo+Pj4KPj4+Pgo+Pj4+IEFuZHJleQo+Pj4+Cj4+
Pj4+Cj4+Pj4+IFJlZ2FyZHMsCj4+Pj4+IENocmlzdGlhbi4KPj4+Pj4KPj4+Pj4+Cj4+Pj4+PiBB
bmRyZXkKPj4+Pj4+Cj4+Pj4+Pgo+Pj4+Pj4+Cj4+Pj4+Pj4KPj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+
Cj4+Pj4+Pj4+Pj4+IEJUVzogQ291bGQgaXQgYmUgdGhhdCB0aGUgZGV2aWNlIFNSQ1UgcHJvdGVj
dHMgbW9yZSB0aGFuIG9uZSAKPj4+Pj4+Pj4+Pj4gZGV2aWNlIGFuZCB3ZSBkZWFkbG9jayBiZWNh
dXNlIG9mIHRoaXM/Cj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+IEkgaGF2ZW4ndCBh
Y3R1YWxseSBleHBlcmllbmNlZCBhbnkgZGVhZGxvY2sgdW50aWwgbm93IGJ1dCwgCj4+Pj4+Pj4+
Pj4geWVzLCBkcm1fdW5wbHVnX3NyY3UgaXMgZGVmaW5lZCBhcyBzdGF0aWMgaW4gZHJtX2Rydi5j
IGFuZCBzbyAKPj4+Pj4+Pj4+PiBpbiB0aGUgcHJlc2VuY2Ugb2YgbXVsdGlwbGUgZGV2aWNlcyBm
cm9tIHNhbWUgb3IgZGlmZmVyZW50IAo+Pj4+Pj4+Pj4+IGRyaXZlcnMgd2UgaW4gZmFjdCBhcmUg
ZGVwZW5kZW50IG9uIGFsbCB0aGVpciBjcml0aWNhbCAKPj4+Pj4+Pj4+PiBzZWN0aW9ucyBpIGd1
ZXNzLgo+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4gU2hpdCwgeWVhaCB0aGUgZGV2aWwg
aXMgYSBzcXVpcnJlbC4gU28gZm9yIEErSSBsYXB0b3BzIHdlIAo+Pj4+Pj4+Pj4gYWN0dWFsbHkg
bmVlZCB0byBzeW5jIHRoYXQgdXAgd2l0aCBEYW5pZWwgYW5kIHRoZSByZXN0IG9mIHRoZSAKPj4+
Pj4+Pj4+IGk5MTUgZ3V5cy4KPj4+Pj4+Pj4+Cj4+Pj4+Pj4+PiBJSVJDIHdlIGNvdWxkIGFjdHVh
bGx5IGhhdmUgYW4gYW1kZ3B1IGRldmljZSBpbiBhIGRvY2tpbmcgCj4+Pj4+Pj4+PiBzdGF0aW9u
IHdoaWNoIG5lZWRzIGhvdHBsdWcgYW5kIHRoZSBkcml2ZXIgbWlnaHQgZGVwZW5kIG9uIAo+Pj4+
Pj4+Pj4gd2FpdGluZyBmb3IgdGhlIGk5MTUgZHJpdmVyIGFzIHdlbGwuCj4+Pj4+Pj4+Cj4+Pj4+
Pj4+Cj4+Pj4+Pj4+IENhbid0IHdlIHByb3Bvc2UgYSBwYXRjaCB0byBtYWtlIGRybV91bnBsdWdf
c3JjdSBwZXIgZHJtX2RldmljZSAKPj4+Pj4+Pj4gPyBJIGRvbid0IHNlZSB3aHkgaXQgaGFzIHRv
IGJlIGdsb2JhbCBhbmQgbm90IHBlciBkZXZpY2UgdGhpbmcuCj4+Pj4+Pj4KPj4+Pj4+PiBJJ20g
cmVhbGx5IHdvbmRlcmluZyB0aGUgc2FtZSB0aGluZyBmb3IgcXVpdGUgYSB3aGlsZSBub3cuCj4+
Pj4+Pj4KPj4+Pj4+PiBBZGRpbmcgRGFuaWVsIGFzIHdlbGwsIG1heWJlIGhlIGtub3dzIHdoeSB0
aGUgZHJtX3VucGx1Z19zcmN1IGlzIAo+Pj4+Pj4+IGdsb2JhbC4KPj4+Pj4+Pgo+Pj4+Pj4+IFJl
Z2FyZHMsCj4+Pj4+Pj4gQ2hyaXN0aWFuLgo+Pj4+Pj4+Cj4+Pj4+Pj4+Cj4+Pj4+Pj4+IEFuZHJl
eQo+Pj4+Pj4+Pgo+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+IENocmlzdGlhbi4KPj4+Pj4+
Pj4+Cj4+Pj4+Pj4+Pj4gQW5kcmV5Cj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pgo+
Pj4+Pj4+Pj4+PiBDaHJpc3RpYW4uCj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+PiBBbmRyZXkKPj4+
Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+IEFuZHJl
eQo+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+
Pj4+Pj4+IENocmlzdGlhbi4KPj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4gwqDCoMKg
IC8qIFBhc3QgdGhpcyBwb2ludCBubyBtb3JlIGZlbmNlIGFyZSBzdWJtaXR0ZWQgdG8gCj4+Pj4+
Pj4+Pj4+Pj4+Pj4gSFcgcmluZyBhbmQgaGVuY2Ugd2UgY2FuIHNhZmVseSBjYWxsIGZvcmNlIHNp
Z25hbCBvbiAKPj4+Pj4+Pj4+Pj4+Pj4+PiBhbGwgdGhhdCBhcmUgY3VycmVudGx5IHRoZXJlLgo+
Pj4+Pj4+Pj4+Pj4+Pj4+IMKgwqDCoMKgICogQW55IHN1YnNlcXVlbnRseSBjcmVhdGVkwqAgSFcg
ZmVuY2VzIHdpbGwgYmUgCj4+Pj4+Pj4+Pj4+Pj4+Pj4gcmV0dXJuZWQgc2lnbmFsZWQgd2l0aCBh
biBlcnJvciBjb2RlIHJpZ2h0IGF3YXkKPj4+Pj4+Pj4+Pj4+Pj4+PiDCoMKgwqDCoCAqLwo+Pj4+
Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4gwqDCoMKgIGZvcl9lYWNoX3JpbmcoYWRldikK
Pj4+Pj4+Pj4+Pj4+Pj4+PiDCoMKgwqAgwqDCoMKgIGFtZGdwdV9mZW5jZV9wcm9jZXNzKHJpbmcp
Cj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+PiDCoMKgwqAgZHJtX2Rldl91bnBsdWco
ZGV2KTsKPj4+Pj4+Pj4+Pj4+Pj4+PiDCoMKgwqAgU3RvcCBzY2hlZHVsZXJzCj4+Pj4+Pj4+Pj4+
Pj4+Pj4gwqDCoMKgIGNhbmNlbF9zeW5jKGFsbCB0aW1lcnMgYW5kIHF1ZXVlZCB3b3Jrcyk7Cj4+
Pj4+Pj4+Pj4+Pj4+Pj4gwqDCoMKgIGh3X2ZpbmkKPj4+Pj4+Pj4+Pj4+Pj4+PiDCoMKgwqAgdW5t
YXBfbW1pbwo+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4gfQo+Pj4+Pj4+Pj4+Pj4+
Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+PiBBbmRyZXkKPj4+Pj4+Pj4+Pj4+
Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+
Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+
Pj4+Pj4+IEFsdGVybmF0aXZlbHkgZ3JhYmJpbmcgdGhlIHJlc2V0IHdyaXRlIHNpZGUgYW5kIAo+
Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gc3RvcHBpbmcgYW5kIHRoZW4gcmVzdGFydGluZyB0aGUgc2No
ZWR1bGVyIGNvdWxkIAo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gd29yayBhcyB3ZWxsLgo+Pj4+Pj4+
Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+IENocmlzdGlhbi4KPj4+Pj4+Pj4+
Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gSSBk
aWRuJ3QgZ2V0IHRoZSBhYm92ZSBhbmQgSSBkb24ndCBzZWUgd2h5IEkgbmVlZCAKPj4+Pj4+Pj4+
Pj4+Pj4+Pj4+Pj4gdG8gcmV1c2UgdGhlIEdQVSByZXNldCByd19sb2NrLiBJIHJlbHkgb24gdGhl
IFNSQ1UgCj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+IHVucGx1ZyBmbGFnIGZvciB1bnBsdWcuIEFsc28s
IG5vdCBjbGVhciB0byBtZSB3aHkgCj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+IGFyZSB3ZSBmb2N1c2lu
ZyBvbiB0aGUgc2NoZWR1bGVyIHRocmVhZHMsIGFueSBjb2RlIAo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+
PiBwYXRjaCB0byBnZW5lcmF0ZSBIVyBmZW5jZXMgc2hvdWxkIGJlIGNvdmVyZWQsIHNvIAo+Pj4+
Pj4+Pj4+Pj4+Pj4+Pj4+PiBhbnkgY29kZSBsZWFkaW5nIHRvIGFtZGdwdV9mZW5jZV9lbWl0IG5l
ZWRzIHRvIGJlIAo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+PiB0YWtlbiBpbnRvIGFjY291bnQgc3VjaCBh
cywgZGlyZWN0IElCIHN1Ym1pc3Npb25zLCAKPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gVk0gZmx1c2hl
cyBlLnQuYwo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gWW91IG5lZWQg
dG8gd29yayB0b2dldGhlciB3aXRoIHRoZSByZXNldCBsb2NrIAo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+
IGFueXdheSwgY2F1c2UgYSBob3RwbHVnIGNvdWxkIHJ1biBhdCB0aGUgc2FtZSB0aW1lIAo+Pj4+
Pj4+Pj4+Pj4+Pj4+Pj4+IGFzIGEgcmVzZXQuCj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+
Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+IEZvciBnb2luZyBteSB3YXkgaW5kZWVkIG5vdyBJ
IHNlZSBub3cgdGhhdCBJIGhhdmUgdG8gCj4+Pj4+Pj4+Pj4+Pj4+Pj4+PiB0YWtlIHJlc2V0IHdy
aXRlIHNpZGUgbG9jayBkdXJpbmcgSFcgZmVuY2VzIAo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gc2lnbmFs
bGluZyBpbiBvcmRlciB0byBwcm90ZWN0IGFnYWluc3Qgc2NoZWR1bGVyL0hXIAo+Pj4+Pj4+Pj4+
Pj4+Pj4+Pj4gZmVuY2VzIGRldGFjaG1lbnQgYW5kIHJlYXR0YWNobWVudCBkdXJpbmcgc2NoZWR1
bGVycyAKPj4+Pj4+Pj4+Pj4+Pj4+Pj4+IHN0b3AvcmVzdGFydC4gQnV0IGlmIHdlIGdvIHdpdGgg
eW91ciBhcHByb2FjaMKgIHRoZW4gCj4+Pj4+Pj4+Pj4+Pj4+Pj4+PiBjYWxsaW5nIGRybV9kZXZf
dW5wbHVnIGFuZCBzY29waW5nIGFtZGdwdV9qb2JfdGltZW91dCAKPj4+Pj4+Pj4+Pj4+Pj4+Pj4+
IHdpdGggZHJtX2Rldl9lbnRlci9leGl0IHNob3VsZCBiZSBlbm91Z2ggdG8gcHJldmVudCAKPj4+
Pj4+Pj4+Pj4+Pj4+Pj4+IGFueSBjb25jdXJyZW50IEdQVSByZXNldHMgZHVyaW5nIHVucGx1Zy4g
SW4gZmFjdCBJIAo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gYWxyZWFkeSBkbyBpdCBhbnl3YXkgLSAKPj4+
Pj4+Pj4+Pj4+Pj4+Pj4+IGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9v
ay5jb20vP3VybD1odHRwczolMkYlMkZjZ2l0LmZyZWVkZXNrdG9wLm9yZyUyRn5hZ3JvZHpvdiUy
RmxpbnV4JTJGY29tbWl0JTJGJTNGaCUzRGRybS1taXNjLW5leHQlMjZpZCUzRGVmMGVhNGRkMjll
ZjQ0ZDI2NDljNWVkYTE2YzhmNDg2OWFjYzM2YjEmYW1wO2RhdGE9MDQlN0MwMSU3Q2FuZHJleS5n
cm9kem92c2t5JTQwYW1kLmNvbSU3Q2M3ZmM2Y2I1MDVjMzRhZWRmZTZkMDhkOGZlNGIzOTQ3JTdD
M2RkODk2MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzUzODk0NjMyNDg1
NzM2OSU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9p
VjJsdU16SWlMQ0pCVGlJNklrMWhhV3dpTENKWFZDSTZNbjAlM0QlN0MxMDAwJmFtcDtzZGF0YT02
NDM2MlBSQzh4VGdSMlVqMlIyNTZiTWVnVm04WVdxMUtJJTJCQWp6ZVlYdjQlM0QmYW1wO3Jlc2Vy
dmVkPTAgCj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+
Pj4+PiBZZXMsIGdvb2QgcG9pbnQgYXMgd2VsbC4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+
Pj4+Pj4+Pj4gQ2hyaXN0aWFuLgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4K
Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+IEFuZHJleQo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+
Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+
Pj4+Pj4+Pj4+IENocmlzdGlhbi4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+
Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+PiBBbmRyZXkKPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+
Pj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+
Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+PiBDaHJpc3RpYW4uCj4+Pj4+Pj4+Pj4+Pj4+Pj4+
Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gQW5k
cmV5Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+
Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+IEFuZHJleQo+Pj4+
Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+
Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+
Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+
Cj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Cj4+Pj4+Pj4KPj4+Pj4KPj4+Cj4K
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
