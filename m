Return-Path: <SRS0=0i2d=KW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE55C4707F
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 14:23:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57F1961378
	for <amd-gfx@archiver.kernel.org>; Thu, 27 May 2021 14:23:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57F1961378
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A4EA6F3CE;
	Thu, 27 May 2021 14:23:00 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCBF06F3C9
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 May 2021 14:22:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nvqzoIci4QECZgg1F0OcTlXv/9gttXZoVCkhOJS0Orri/RgvMm+xXBbtDvLTrqsYVDYqT/y1Vp7wwBwwyL80N5wjZG8HA/lq/G2jAhmlIy3Qp9qD2IxivtvInrlKtoYjrWNOXdydkfFiZaWpn3w4raWZw9kj8MPgPHhn6TAtbOJ5W7uO1sndT/EFAakL1C8hRQ4NyvHfafkVCD+o7bmEql17KeYQ4MYBUxMYlLyhE83Jh4L8GA+omqv9cVMU2IOf83/XCixaOcRCYlot3Ew3fBpjjrZ6sWuDIy9nCJwEBXZwYSuSI/LJqEaMqKnPbsdquRRULRSI4sdOvpza0/L6Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nAR9W5dI94KU/aaP3igJh51SUxf8jYhVdkY7OO4QwU8=;
 b=TxeXtTHOCMSzEfVExmnuw5MaPz/xdUFsD7gA3/5TCpusMSMWUAWu5EeTF2l+OPQkYB5eZqITwTFykkX3DZxxOeEyP3/3ioTYISpdUv5eJkyMuCCBIvvd/mkRIu4NfS4uvjUgW5ZIuQ4AxTUts3Ih4Yd8br0OMMOEU5BvWzeXrPHbsY2XOC1BUjVqnJpeR0SDk1/KaO6UEXuO2h1XeByYNYbN8eENxG28eI/iSLkofyjs8/TkxHWbxR1W6J7l86o3FNrDtf4I4BwP2xGddCKOeXBRW13DsBANAle0oJhaQJP3OIXCk5a9dLVViglGutAoutXKQwAKOf1hf8LgwARKnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nAR9W5dI94KU/aaP3igJh51SUxf8jYhVdkY7OO4QwU8=;
 b=DQH756hmxeajNEkQGHdPey31GWa04FWPZIOFhM5Q1WTa1ldNziFu2KaRQdD3uD3nUvSGXNN+nohUkbhY7b6wh/8qU/sUWaI5ZH58Ctr0xI4hsYicLOPQTWdPqijV8iPK3th8MQjLpoY4c6Ic9oLL5ur6xO8XMJc4BNo81wvR3oU=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1787.namprd12.prod.outlook.com (2603:10b6:3:113::12)
 by DM5PR12MB1227.namprd12.prod.outlook.com (2603:10b6:3:76::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Thu, 27 May
 2021 14:22:57 +0000
Received: from DM5PR12MB1787.namprd12.prod.outlook.com
 ([fe80::e516:6700:6c7:55fd]) by DM5PR12MB1787.namprd12.prod.outlook.com
 ([fe80::e516:6700:6c7:55fd%5]) with mapi id 15.20.4173.022; Thu, 27 May 2021
 14:22:57 +0000
Subject: Re: [PATCH] drm/amdgpu: Fix Gstreamer api vaapih264enc missing
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 "Li, Xin (Justin)" <xin2.li@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210526101310.1872892-1-xin2.li@amd.com>
 <dfab1180-2ee9-7d41-8a12-0a7e86dca9d4@amd.com>
From: Leo Liu <leo.liu@amd.com>
Message-ID: <29a7a3ee-8eac-c999-a918-dced2eb3bdc5@amd.com>
Date: Thu, 27 May 2021 10:22:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <dfab1180-2ee9-7d41-8a12-0a7e86dca9d4@amd.com>
Content-Language: en-US
X-Originating-IP: [2607:9880:2088:19:bea2:d5ef:905f:cd70]
X-ClientProxiedBy: YT1PR01CA0085.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::24) To DM5PR12MB1787.namprd12.prod.outlook.com
 (2603:10b6:3:113::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:9880:2088:19:bea2:d5ef:905f:cd70]
 (2607:9880:2088:19:bea2:d5ef:905f:cd70) by
 YT1PR01CA0085.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4150.27 via Frontend Transport; Thu, 27 May 2021 14:22:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8195c2f8-966d-4c35-032b-08d9211aec56
X-MS-TrafficTypeDiagnostic: DM5PR12MB1227:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1227F1325F79D2C116A97450E5239@DM5PR12MB1227.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FOzXJng8FKzLyHHZU0+J4zjGR9JYSWTOZLuIBVXqUqJ87jmBIeg3B4aBhl8IOqHeIRINNEDMr80FqjiQYKdKKEot9GzC7SEVHsx1+cUF7uk4K1fsuPyXNbfjLuhdhvDLwPL41P5ftjFFjbKWk7pA4objd6aIQzcJ7m9W+4Uux+AF6f7F5wH3OUfd0W902zwcJu/4fdI8HzKDRIW6hNFkupL4+TnQrnd5mngwcoLCQTaaqtmwjEJlQ2w/atEIKRNZcCT99K1Ze2O2T+VZFd4Jv8DtM5DghOyjKrqoOcjuzePMM03eRoH3vacjl8jlNURVabZlsoIMubmS4OxsKC8taKE/xdBbvlG8o3MShiLBbDr9U9G1KbHP+UmyvSvnOy0j0uhR1xdDhvwN1lfuzB52dT9jhssD1+8BYQg7tamrDdJaAsMwsUtKOsqV770BDJZqQdmJzClU2o+XZ2uQ3jEwgRN+BRotbi11Th16OIY29pv/SEPqrKWTe+sEf+cOs8nvgelN46zlS2s9MkQqWyjdxLGyfragh96a6YgPyvmx/nD4urvfndSyXT0QAHnVlhQ2zqkDwDBOeZpOiWm2813jurWgGhq8VR6lTz2xuEbv+hXTwXOXERsV1vP617KI4vVBHGqksd2u/Gj1B4A484ELGV/vl60iZtB+eKBuHcHtj/5E43J7T7yFBZqYlkNiz7qQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1787.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(376002)(346002)(366004)(396003)(8676002)(31696002)(53546011)(66946007)(186003)(44832011)(4326008)(316002)(8936002)(6486002)(38100700002)(110136005)(2616005)(54906003)(31686004)(66574015)(2906002)(66476007)(66556008)(16526019)(86362001)(83380400001)(478600001)(36756003)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VzdaVDBDbHFidUNSRXJyaUo4ckQ0Q2gzRWpzbWRLVWlaZEdSdGFtUFU1ZFZp?=
 =?utf-8?B?b0pCNHFnU0pySDhrT0Nnd0NueWcvRVlNdE5lVkJlUldvcGNLajc2ekovTHZ2?=
 =?utf-8?B?cGlxZktQT3A5RTQ1OVJTVmtWZi9Rb2JnbS8zc0JrS3hXUVYwN2FPVVJ2ZFF6?=
 =?utf-8?B?WEEwdFp6R2F2OXVhRVE3dlloNW9CQ0xSYTgwUWd2NjBOaWZjVlJHTTNKM09p?=
 =?utf-8?B?S204WEx6N3BaYWNUakFtM3RJbW11M1V5WEczay8vVzJJMmRoOVlxd2o0c2hs?=
 =?utf-8?B?MHdrVnpTdzVPUlFiRXlPU3RCeXUzdUo4MHRvaWJGeFFrNUNFZzU2Mk1GVlJQ?=
 =?utf-8?B?QWk0Rm5nVTRaWlNUd3Mxd0ZJM09wNUtKcE1xbDhXT1UxVDBoSDhwcFBwNHc0?=
 =?utf-8?B?anlUbW95VHhtY1Jha1l2SDhOcHQwTWNpU0YydnU4KzZna1FRZ3QzN3lPOVFi?=
 =?utf-8?B?UmFjVkQyM1QxUUZLZ2VlZHoxckI1UkZFSThVY1Q4OUlMVmFYenU4eEYvWG1I?=
 =?utf-8?B?TnRHeURBd01obXh6ZXIvQWN0cVBjWFoyOGxRWnIwZ2hKRWVkTjlYS0c1MHJX?=
 =?utf-8?B?MHM2Z3RPWG9yU2hTZnlUSEtCM00wUzhBOE1XazJzeC9YRC9uT2E3UFFIc1Ux?=
 =?utf-8?B?WlkzbGhKQU92bVlmbGlnUkR4aE0ybjJTUElabE5XNG42ZkxPdFpuWmsyWlFo?=
 =?utf-8?B?Z29pYUlXTVFFVG9PRnd0eE00Tys0SmZ3L21aVDlEMnZmcVJ3V1BwWjlrZ292?=
 =?utf-8?B?VWRtcDloNUtqL25SczZBNTdSVjFyYndtTVVNWTVQUGpuWEEveitzM2o4TU9E?=
 =?utf-8?B?Y1lWOVBuQWU0bDl6NDg1bDliRzFDRDdZTFRacHhJUHlRS3F3VVBIK2pkMTJk?=
 =?utf-8?B?Z0taVWhXbCs2bEozOWdDcUcwZWtqZDFxNk9UeEJtZFR3a1dUakJKb1R4K2hR?=
 =?utf-8?B?cUo4ajFUWFFOdTMwOWFBTXNCMHRlaTE0eFpBRGlxQnRUY1BxdG9rNnlENFJS?=
 =?utf-8?B?K0RYK3psZkp0VHJZYUUrU3VZSUxybEd0aHErejQ4ZDhWN0RrVThiMXdzK2Fl?=
 =?utf-8?B?MzFjeXl1SlJKWVRWaEZRdHV0aGF4dHhGT2o0TmlaK0E5dmZhd2U4SWFyaERY?=
 =?utf-8?B?WXpVVVF6cm9zSEdjU3RQZEQ2VmJpb09GNzNYSHVLSDF4MmY5Nm56bmkzSUhT?=
 =?utf-8?B?Mm5Kbmtpb1YyNkp4enRlN2haK0RVR2tDdmhVcWxaVXo0TWxqWXovdGd1OU5x?=
 =?utf-8?B?b01QNWFWT2xYS3creTBQcmVNc3N4VTlvd25pZ0VCQ0Z1TVczWVhtcnhyOThJ?=
 =?utf-8?B?TmF4anF3N0dKanZiMGJZVjlaeitvYlFNb3FlUzBjUld6SThPZEkrNjd2aE5J?=
 =?utf-8?B?OHJzb1prZk8rSDR4NU5zMnlpa2dSakZHRzNNY2NpTmh6cWFsQzErci83NGVG?=
 =?utf-8?B?ajJ1NjNiY25QWmF4QzFaM2RKSGJYcDEyYWZJYzNiTktKL3JlNXpMNWc1NDZy?=
 =?utf-8?B?WjBiWWhCV0tEcW1Cd3NEVUxrZ1hJVzlOVjdPM0g1eWhsUHU5ZVExMUp5QlNQ?=
 =?utf-8?B?UlFtaGVCQk5ZSnc2eHFCMmdzK1JHRll1bGNoNjJDbVF2QjZPWUdTOEorRDF2?=
 =?utf-8?B?ZUZMMHF3aFFiSisvNXUxQmg4S3o3ZnhPK3NGcTFiN3VDaUVoemFQa1VDRDl2?=
 =?utf-8?B?aXRsbHhCMXpTLzVmSHgvY0FBRm5DNWdjbSsyUXlWOXgyemZheEV2VHYwVTlF?=
 =?utf-8?B?OW42eStyZmk5M0trTExobXZmdnpjSHJWNVpSMm1rSHBlN2VpSjI4YURQNzZU?=
 =?utf-8?B?OTBiZjBwRVB4b3hmQUxEeDg1SFFGNkhzMVZNUmFlVXV1K0h0VVNhaGJ5WHFO?=
 =?utf-8?Q?YkXc2uuwDM6pe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8195c2f8-966d-4c35-032b-08d9211aec56
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1787.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2021 14:22:56.9461 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vAq3gFWPrVI9I5h/s2dP5DdC/EYja9eO2Wz16SPPQiO8HNkMQvzcfuiWmjK5tAur
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1227
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
Cc: "Alex . Deucher" <alexander.deucher@amd.com>,
 "Frank . Min" <Frank.Min@amd.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ck9uIDIwMjEtMDUtMjYgNjo0OSBhLm0uLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+IEFtIDI2
LjA1LjIxIHVtIDEyOjEzIHNjaHJpZWIgTGksIFhpbiAoSnVzdGluKToKPj4gc2luY2UgdmNuIGRl
Y29kaW5nIHJpbmcgaXMgbm90IHJlcXVpcmVkLCBzbyBqdXN0IGRpc2FibGUgaXQuCj4+Cj4+IENj
OiBBbGV4LkRldWNoZXIgPGFsZXhhbmRlci5kZXVjaGVyQGFtZC5jb20+Cj4+IENjOiBDaHJpc3Rp
YW4uS29uaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KPj4gU2lnbmVkLW9mZi1ieTogTGku
WGluLkp1c3RpbiA8eGluMi5saUBhbWQuY29tPgo+PiBTaWduZWQtb2ZmLWJ5OiBGcmFuay5NaW4g
PEZyYW5rLk1pbkBhbWQuY29tPgo+PiAtLS0KPj4gwqAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRn
cHUvYW1kZ3B1X2ttcy5jIHzCoCA2ICsrKy0tLQo+PiDCoCBkcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS92Y25fdjJfMC5jwqDCoCB8IDI1ICsrKysrKysrKysrKysrLS0tLS0tLS0tLS0KPj4gwqAg
MiBmaWxlcyBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCAxNCBkZWxldGlvbnMoLSkKPj4KPj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9rbXMuYyAKPj4g
Yi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfa21zLmMKPj4gaW5kZXggNTI0ZTRm
ZTVlZmU4Li42MTRlNmIwNmU5NGUgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQv
YW1kZ3B1L2FtZGdwdV9rbXMuYwo+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfa21zLmMKPj4gQEAgLTQyNyw3ICs0MjcsOSBAQCBzdGF0aWMgaW50IGFtZGdwdV9od19p
cF9pbmZvKHN0cnVjdCBhbWRncHVfZGV2aWNlIAo+PiAqYWRldiwKPj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgaWYgKGFkZXYtPnV2ZC5oYXJ2ZXN0X2NvbmZpZyAmICgxIDw8IGkpKQo+PiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbnRpbnVlOwo+PiDCoCAtwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBpZiAoYWRldi0+dmNuLmluc3RbaV0ucmluZ19kZWMuc2NoZWQucmVh
ZHkpCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChhZGV2LT52Y24uaW5zdFtpXS5yaW5n
X2RlYy5zY2hlZC5yZWFkeSB8fAo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIChh
ZGV2LT5hc2ljX3R5cGUgPT0gQ0hJUF9OQVZJMTIgJiYKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBhbWRncHVfc3Jpb3ZfdmYoYWRldikpKQo+Cj4gTGVvIG5lZWRzIHRvIHRha2Ug
YSBjbG9zZXIgbG9vaywgYnV0IHRoYXQgbG9va3MgZmlzaHkgdG8gbWUuCgpUaGUgZGVjb2RlIGlz
IGV4cGxpY2l0bHkgZGlzYWJsZWQgd2l0aCBzcmlvdiBjYXNlIHdpdGggdmNuMgoKK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgcmluZy0+c2NoZWQucmVhZHkgPSBmYWxzZTsKCmFuZCBJIGRvbid0IHVu
ZGVyc3RhbmQgZWl0aGVyIHdoeSB0byBhZGQgdGhlIHJpbmcgbnVtYmVyIGhlcmUgaWYgYWxyZWFk
eSAKaGF2ZSBpdCBkaXNhYmxlZC4gSWYgeW91IGFyZSB0cnlpbmcgdG8gd29ya2Fyb3VuZCBzb21l
IGlzc3VlcywgdGhlIApjaGFuZ2VzIGZyb20gaGVyZSBpcyB2ZXJ5IGJhZCBoYWNrIGFuZCB5b3Ug
cHJvYmFibHkgbmVlZCB0byBmaW5kIHRoZSAKcmVhbCByb290IGNhdXNlLgoKUmVnYXJkcywKCkxl
bwoKCj4KPiBXaHkgc2hvdWxkIHRoZSByaW5nIGJlIGF2YWlsYWJsZSBpZiBpdCBpcyBkaXNhYmxl
ZD8gVGhhdCBkb2Vzbid0IG1ha2UgCj4gc2Vuc2UuCj4KPiBDaHJpc3RpYW4uCj4KPj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCArK251bV9yaW5nczsKPj4gwqDCoMKgwqDCoMKg
wqDCoMKgIH0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgIGliX3N0YXJ0X2FsaWdubWVudCA9IDE2Owo+
PiBAQCAtNzcwLDggKzc3Miw2IEBAIGludCBhbWRncHVfaW5mb19pb2N0bChzdHJ1Y3QgZHJtX2Rl
dmljZSAqZGV2LCAKPj4gdm9pZCAqZGF0YSwgc3RydWN0IGRybV9maWxlICpmaWxwKQo+PiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkZXZfaW5mby0+aWRzX2ZsYWdzIHw9IEFNREdQVV9JRFNf
RkxBR1NfRlVTSU9OOwo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKGFtZGdwdV9tY2JwIHx8IGFt
ZGdwdV9zcmlvdl92ZihhZGV2KSkKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGV2X2lu
Zm8tPmlkc19mbGFncyB8PSBBTURHUFVfSURTX0ZMQUdTX1BSRUVNUFRJT047Cj4+IC3CoMKgwqDC
oMKgwqDCoCBpZiAoYW1kZ3B1X2lzX3RteihhZGV2KSkKPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgZGV2X2luZm8tPmlkc19mbGFncyB8PSBBTURHUFVfSURTX0ZMQUdTX1RNWjsKPj4gwqAgwqDC
oMKgwqDCoMKgwqDCoMKgIHZtX3NpemUgPSBhZGV2LT52bV9tYW5hZ2VyLm1heF9wZm4gKiBBTURH
UFVfR1BVX1BBR0VfU0laRTsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHZtX3NpemUgLT0gQU1ER1BV
X1ZBX1JFU0VSVkVEX1NJWkU7Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2Ft
ZGdwdS92Y25fdjJfMC5jIAo+PiBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92Ml8w
LmMKPj4gaW5kZXggOGFmNTY3YzU0NmRiLi5kYzhhMzY3NjZjNGEgMTAwNjQ0Cj4+IC0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92Ml8wLmMKPj4gKysrIGIvZHJpdmVycy9ncHUv
ZHJtL2FtZC9hbWRncHUvdmNuX3YyXzAuYwo+PiBAQCAtMjIwLDE3ICsyMjAsMjAgQEAgc3RhdGlj
IGludCB2Y25fdjJfMF9od19pbml0KHZvaWQgKmhhbmRsZSkKPj4gwqAgewo+PiDCoMKgwqDCoMKg
IHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2ID0gKHN0cnVjdCBhbWRncHVfZGV2aWNlICopaGFu
ZGxlOwo+PiDCoMKgwqDCoMKgIHN0cnVjdCBhbWRncHVfcmluZyAqcmluZyA9ICZhZGV2LT52Y24u
aW5zdC0+cmluZ19kZWM7Cj4+IC3CoMKgwqAgaW50IGksIHI7Cj4+ICvCoMKgwqAgaW50IGksIHIg
PSAtMTsKPj4gwqAgwqDCoMKgwqDCoCBhZGV2LT5uYmlvLmZ1bmNzLT52Y25fZG9vcmJlbGxfcmFu
Z2UoYWRldiwgcmluZy0+dXNlX2Rvb3JiZWxsLAo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJpbmctPmRvb3JiZWxsX2luZGV4LCAwKTsKPj4g
wqAgLcKgwqDCoCBpZiAoYW1kZ3B1X3NyaW92X3ZmKGFkZXYpKQo+PiArwqDCoMKgIGlmIChhbWRn
cHVfc3Jpb3ZfdmYoYWRldikpIHsKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHZjbl92Ml8wX3N0YXJ0
X3NyaW92KGFkZXYpOwo+PiAtCj4+IC3CoMKgwqAgciA9IGFtZGdwdV9yaW5nX3Rlc3RfaGVscGVy
KHJpbmcpOwo+PiAtwqDCoMKgIGlmIChyKQo+PiAtwqDCoMKgwqDCoMKgwqAgZ290byBkb25lOwo+
PiArwqDCoMKgwqDCoMKgwqAgaWYgKGFkZXYtPmFzaWNfdHlwZSA9PSBDSElQX05BVkkxMikKPj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmluZy0+c2NoZWQucmVhZHkgPSBmYWxzZTsKPj4gK8Kg
wqDCoCB9IGVsc2Ugewo+PiArwqDCoMKgwqDCoMKgwqAgciA9IGFtZGdwdV9yaW5nX3Rlc3RfaGVs
cGVyKHJpbmcpOwo+PiArwqDCoMKgwqDCoMKgwqAgaWYgKHIpCj4+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGdvdG8gZG9uZTsKPj4gK8KgwqDCoCB9Cj4+IMKgIMKgwqDCoMKgwqAgLy9EaXNhYmxl
IHZjbiBkZWNvZGUgZm9yIHNyaW92Cj4+IMKgwqDCoMKgwqAgaWYgKGFtZGdwdV9zcmlvdl92Zihh
ZGV2KSkKPj4gQEAgLTI0NSw4ICsyNDgsMTEgQEAgc3RhdGljIGludCB2Y25fdjJfMF9od19pbml0
KHZvaWQgKmhhbmRsZSkKPj4gwqAgwqAgZG9uZToKPj4gwqDCoMKgwqDCoCBpZiAoIXIpCj4+IC3C
oMKgwqDCoMKgwqDCoCBEUk1fSU5GTygiVkNOIGRlY29kZSBhbmQgZW5jb2RlIGluaXRpYWxpemVk
IAo+PiBzdWNjZXNzZnVsbHkodW5kZXIgJXMpLlxuIiwKPj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgKGFkZXYtPnBnX2ZsYWdzICYgQU1EX1BHX1NVUFBPUlRfVkNOX0RQRyk/IkRQRyAKPj4gTW9k
ZSI6IlNQRyBNb2RlIik7Cj4+ICvCoMKgwqDCoMKgwqDCoCBEUk1fSU5GTygiVkNOICVzIGVuY29k
ZSBpbml0aWFsaXplZCBzdWNjZXNzZnVsbHkodW5kZXIgJXMpLlxuIiwKPj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgKGFkZXYtPmFzaWNfdHlwZSA9PSBDSElQX05BVkkxMiAmJgo+PiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGFtZGdwdV9zcmlvdl92ZihhZGV2KSk/IiI6ImRlY29k
ZSBhbmQiLAo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAoYWRldi0+cGdfZmxhZ3MgJgo+PiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEFNRF9QR19TVVBQT1JUX1ZDTl9EUEcpPyJE
UEcgTW9kZSI6IlNQRyBNb2RlIik7Cj4+IMKgIMKgwqDCoMKgwqAgcmV0dXJuIHI7Cj4+IMKgIH0K
Pj4gQEAgLTE3MjEsOSArMTcyNyw2IEBAIGludCB2Y25fdjJfMF9kZWNfcmluZ190ZXN0X3Jpbmco
c3RydWN0IAo+PiBhbWRncHVfcmluZyAqcmluZykKPj4gwqDCoMKgwqDCoCB1bnNpZ25lZCBpOwo+
PiDCoMKgwqDCoMKgIGludCByOwo+PiDCoCAtwqDCoMKgIGlmIChhbWRncHVfc3Jpb3ZfdmYoYWRl
dikpCj4+IC3CoMKgwqDCoMKgwqDCoCByZXR1cm4gMDsKPj4gLQo+PiDCoMKgwqDCoMKgIFdSRUcz
MihhZGV2LT52Y24uaW5zdFtyaW5nLT5tZV0uZXh0ZXJuYWwuc2NyYXRjaDksIDB4Q0FGRURFQUQp
Owo+PiDCoMKgwqDCoMKgIHIgPSBhbWRncHVfcmluZ19hbGxvYyhyaW5nLCA0KTsKPj4gwqDCoMKg
wqDCoCBpZiAocikKPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwphbWQtZ2Z4IG1haWxpbmcgbGlzdAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
