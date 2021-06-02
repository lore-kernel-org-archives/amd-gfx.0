Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D71C4708F
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 08:57:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72618613DB
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 08:57:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72618613DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C5C66EBA5;
	Wed,  2 Jun 2021 08:57:25 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2044.outbound.protection.outlook.com [40.107.96.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABC826EBA5
 for <amd-gfx@freedesktop.org>; Wed,  2 Jun 2021 08:57:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oMz9iW2ajurC+foMhRzz6mKbPOrMFNYCVgNcL0nS+pvuEoaCiGXKMNmzJDgpznS/QJ6kC/Ru5qWOyPKdNCMKuLLNIpfY2fVfD4UzewxQTASiul0Kyh95e8LyMebb4SP+Zo9+kUpkil83Mw8LYEvQO/7AmxjUhT/KImg2gac20QwT3vLmDynrqpMfQyjthPlQuxiSY9wOdQyiGb+X2z+g+z87CDq4EqTnSJK19wPxcVdDhxanIUX14w2hCU16xk06g9ufZRuq/ccmspwQE/mCysxBu/yVUZp1GxudjrfAJD+RBeSo26ZpbDWqui0sds21mYngCe+F01PoYG4AKxltnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iDJI2uFSlSlLnHa5KGn+YjOzU/+SHa82l29a7HNsh8o=;
 b=EEUD78w2oBfsmnHT1Yj8HHNJUiL5xTqihCZjNitT+nr5t4E9KPEM9l0NHuEmoUllXV1gn9vrI8mNfQ7NdQPkNX23aMFGA5IWO8TuWm1SzP9m1Q9QDU4IfaliumNBZNqwhj/Vl68RjviWvu0FsV1QPXcJZUSesi8ZmqqjtnvNOb3VzmcJkBL/bEJ047LEJ22czijP7qYBcyDJIbJBfcT0Aw2tDvMsibRsWRoVe55U3pd9qdoXWLp2ANC9YcyYxYxuWo98y8M4IN1VZNw2PSiOjFUCearAJ4ARebEUxX8phzuHcZVXHwe6Tw94VsRQ8KZC6FVCdn5gmxuWo8JvTlRtZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iDJI2uFSlSlLnHa5KGn+YjOzU/+SHa82l29a7HNsh8o=;
 b=mvvXU5G/B5+cuzIyxRQ2quEnfP8NrAngVVrfMjlUPV49dTmlk9Y7ERnKCnAhGiLufQrIjdid5NV03nJAFMSBQD09zKGXZzXt9S0b8D5H7lAwj6vQPRxihANp7p8APRADzBR4gsfJnjx8Mz8fYkqFenClbqQA+xUx/0ITdvWgb8c=
Authentication-Results: freedesktop.org; dkim=none (message not signed)
 header.d=none;freedesktop.org; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB4690.namprd12.prod.outlook.com (2603:10b6:208:8e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Wed, 2 Jun
 2021 08:57:21 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4173.033; Wed, 2 Jun 2021
 08:57:20 +0000
Subject: Re: [PATCH] drm/amdgpu: take back kvmalloc_array for entries alloc
 because of kzalloc memory limit
To: "Das, Nirmoy" <nirmoy.das@amd.com>, Changfeng <Changfeng.Zhu@amd.com>,
 Ray.Huang@amd.com, amd-gfx@freedesktop.org
References: <20210602083017.2335-1-Changfeng.Zhu@amd.com>
 <c9c3817a-ddd5-d73e-5a5b-fb3ad25d8ddc@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <9a3adb34-031e-9742-d165-cb6f36c91063@amd.com>
Date: Wed, 2 Jun 2021 10:57:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <c9c3817a-ddd5-d73e-5a5b-fb3ad25d8ddc@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:cd07:2759:3eec:1d00]
X-ClientProxiedBy: FR3P281CA0049.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::22) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:cd07:2759:3eec:1d00]
 (2a02:908:1252:fb60:cd07:2759:3eec:1d00) by
 FR3P281CA0049.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:4a::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4195.9 via Frontend Transport; Wed, 2 Jun 2021 08:57:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12cbab2a-5131-49f5-356a-08d925a46e48
X-MS-TrafficTypeDiagnostic: BL0PR12MB4690:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB4690E775636DE3033CCEBE4D833D9@BL0PR12MB4690.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OlQKIJlvWWdJi5fuIMdhm2cGRrOGxAdVOcvaaJz5mrIKVjWQkbskam88Ge2Byegf16GgrbK254Y281Os0OS1W6b+kIrUMHyQmXs6sPqlE762WJ6YOZ3hyYiSZy5GEq9m3+2KVjRrTe1qRpxjuReIzhLWLEPQdjiuvQETbSQYJUgEBSerWfpMHynjDk1feIEaz6SX7jmrzSMk4PCJTniBe+gw3XY9f4FxcC4etjJ83B4R4cNqNB+nwMeKBZN65UzOdrg8KY10dnZ8ab/NC5ytLEo1sClKdslmHFNbFbKUcXcp2VIDdk6T2CLZZfVFX9k8nEmBKOpiDsBtDRUOIATUCzNS/E0LkBMW8bSJeoca/JlHBXRGPZkinfPP/3ugWM7PcTURzWUjgf+UjixV/8PoRWOqij8LWTdG3NoNp/9taBFKfAXBPwswLQPpukQBV1UKVOkvJbqhvgaDYwU/oDE/Jne6pbEcm2G/0GpndMc3TLY5KcOhWxLr18TZ2as7C/udxDG4tsgfqsDtu90a4aXc+GUH3zQY8t23LkvvtAHg63IXpy1TuUQt40ZD+Lb3zOGEp6OTgdxQaG+rhSwYv/PngjAklX7jhUY6IZ6DM91hoPXqSSLlaMGpW/SAkI8YDiBBqgdAaGbceODr7TJrOPaM0oolCYfqdn5n/EtQsq4TZwMYWzTP9ehyJWRlt9JhSs1G
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(346002)(376002)(39860400002)(396003)(2906002)(31696002)(31686004)(186003)(16526019)(86362001)(66946007)(6486002)(66556008)(66476007)(38100700002)(8676002)(83380400001)(8936002)(36756003)(5660300002)(478600001)(2616005)(316002)(6666004)(110136005)(53546011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UWN6enVpSUQ3eWFOWjVCS3JZbFU5azJ0Wm10VXNjbDkwY2NDMkNwTi95WDhV?=
 =?utf-8?B?Ynl6eE1iSUxqM3FIQ09pNUVpNVp6R1kxV3ErN09QcitPVW1Oa0wrUjg5c3lQ?=
 =?utf-8?B?YU9WVnVBY3AzRmM0SEI3bjhKRnFNNExRM1RJaUNXUE41d1VPK2pjRlo4OHpy?=
 =?utf-8?B?Q2ZaL1ZNaDVoK3JmZUxsYkQxcEMvRjl6elNmbmwvakRLK3BxdGZycDdPdFBa?=
 =?utf-8?B?UktENkZVakhXNXJIOVlxby9Tc3JpK3hxUzV6K1NhM2xKZk9aTU1RVGJ2Vy95?=
 =?utf-8?B?SHEwWXFtVXZuaUw4cmtXWE1SbHJEdnNnU1h0ajVUWDZpOTVkUll2LzdncHRs?=
 =?utf-8?B?aUpRZ1djK2hsd0lkaTRhWkp5aGRBajVYbFpld1NyWmJoTTJNem54eHRIcFVV?=
 =?utf-8?B?VHFVU0tEYzU2WjlHa0pXakhlYnFnL0lvVDJtemRoMWJxZ1JkbGY5ODFEbG9H?=
 =?utf-8?B?K2YrTEFPbWRjQm5kZThZSnNobnZxV2p3WmRKK1pXc3NCNW5uWS9NZXIwL1Av?=
 =?utf-8?B?RHlIc2p0OXEzVklxOFh0c0p1QTA1SUF4dUszYSttTkF2enhEZFpOMndkbTVP?=
 =?utf-8?B?dksrdkdyRVhnQzhaZGx4elZDeEZOU0VoMlVqbTdoM0dycmltK21QZkJ2SnlR?=
 =?utf-8?B?UDl6Q0p0VFZ5OXVuaHAxeUxtSHREVFBCS0lHdFhwVmZJOE5KVjIrTld2emp1?=
 =?utf-8?B?SHBpdFpTZjM3dXZzS0hiWlZhRXVhRTFadjltWkt3V24rOWI3bDgvV3VybjFW?=
 =?utf-8?B?eXRiS29jdXE3cDNyQnI2VDVRekZ0MTN0VHBKTWFBbVZEcUk5Rk9KUVNVZFlS?=
 =?utf-8?B?UW02SU5TSjNzRmxTRG0rVGVGaTZ6b00rOFpIUmRvS01uY1hWVThqYzBFVytL?=
 =?utf-8?B?akxab0lwVmxrVFFKakJIRzlsWDZZdUZSQ3BhczhwZncxb2VpWmJoNGN4ZVpO?=
 =?utf-8?B?TzhwV3hYU1FWc0VZYUszVTlscFBWeGtEQUN2S0pGM1ZkL3NXbU9iQmRIbVVC?=
 =?utf-8?B?Q2NKWFBUYVoxTDlRSHg1WE10QXNzaGlUQmVPY3ZlM2p6bHFrdWNpUzQ4MkNw?=
 =?utf-8?B?b0haYTV2VjNBYnVoTzczUDlpNDBqcmRmSmJaalF0NFZKeEhVV2xXelVLdlhR?=
 =?utf-8?B?ZTdXeDhmMEROVWtLckh6UGVjdXZSbUZ3NWhtQWI0WGZyZzBvdGVERUtBbTBn?=
 =?utf-8?B?ZDZsUi9nbVEzanpxQWs5V3dHTllONUg3VzdQenVoUVdVMU9qRjZ5ejVaNElt?=
 =?utf-8?B?VUJtRWV5V0E0d2t5dVYxOEluOFBsS3Z3OTRtYkl0c25JMzJwcEpPYW93c1pE?=
 =?utf-8?B?dU9RZnZNMnNIV2RPejNZZ0U3amlIblJXbUtRa3krOHJyVG9TaUhKdWpGL2Z3?=
 =?utf-8?B?Ni9vUThNdVdwdGxLS09wTTFqaWVjMU11MTNhTmhMZlFXZUNFWUJGQnZHUHFt?=
 =?utf-8?B?eTh0K3pCTTRyTmNZdUlrenVBNnJXeUYvaktiRUtXUmxNM29mc0lEUVFpV0xZ?=
 =?utf-8?B?RlFhdVNTSnNQMEphb3Vac2RVMFU1U2pzMDRteGU3cUg2N05ySU9IUnpRbCtm?=
 =?utf-8?B?emdVK0pkaW1KN25tTEdlUFVTM1lPWXhGalJRV043YVNVT3VVYm81NjBFTDZE?=
 =?utf-8?B?ejZsS0VXTXc3ZWE1SWoyWEdYSisrdWppQ0JtbUZhUzRRUTZBMWJUL0FJVmFh?=
 =?utf-8?B?cHQrTVFJMXp2WUJvM1YvNTNpMHJVZU9XM3N2MFg4bUtoWUpQTDF2UFZBVm5r?=
 =?utf-8?B?RE5WQlgza1l6eWhLOXEzdFhNODc3aGJJNkhXREdrZlRMUnVCeXNUWEJ1ekxD?=
 =?utf-8?B?R01xckpvVTJHamhma0J0d1FhYm5neUNrclpjcWZvbThYMmR1WWZsWURFeDBl?=
 =?utf-8?Q?suntMM9hx6cax?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12cbab2a-5131-49f5-356a-08d925a46e48
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 08:57:20.6844 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1OaWAuFR+gKBsynbIK3A58P+dAhMir1ao4w/eWtfwwteTTpxjnfWv1kYijRe2oIb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4690
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

CgpBbSAwMi4wNi4yMSB1bSAxMDo1NCBzY2hyaWViIERhcywgTmlybW95Ogo+Cj4gT24gNi8yLzIw
MjEgMTA6MzAgQU0sIENoYW5nZmVuZyB3cm90ZToKPj4gRnJvbTogY2hhbmd6aHUgPENoYW5nZmVu
Zy5aaHVAYW1kLmNvbT4KPj4KPj4gRnJvbTogQ2hhbmdmZW5nIDxDaGFuZ2ZlbmcuWmh1QGFtZC5j
b20+Cj4+Cj4+IEl0IHdpbGwgY2F1c2UgZXJyb3Igd2hlbiBhbGxvYyBtZW1vcnkgbGFyZ2VyIHRo
YW4gMTI4S0IgaW4KPj4gYW1kZ3B1X2JvX2NyZWF0ZS0+a3phbGxvYy4KPgo+Cj4gSSB3b25kZXIg
d2h5IEkgZGlkbid0IHNlZSB0aGUgZXJyb3Igb24gbXkgbWFjaGluZS4gSXMgdGhlcmUgYW55IGNv
bmZpZyAKPiBJIG1pZ2h0IGJlIG1pc3NpbmcgPwoKVk0gcGFnZSB0YWJsZSBsYXlvdXQgZGVwZW5k
cyBvbiBoYXJkd2FyZSBnZW5lcmF0aW9uLCBBUFUgdnMgZEdQVSBhbmQgCmtlcm5lbCBjb21tYW5k
IGxpbmUgc2V0dGluZ3MuCgpJIHRoaW5rIHdlIGp1c3QgbmVlZCB0byBzd2l0Y2ggYW1kZ3B1X2Jv
X2NyZWF0ZSgpIGZyb20ga3phbGxvYyB0byAKa3ZtYWxsb2MgKGFuZCBrZnJlZSB0byBrdmZyZWUg
aW4gYW1kZ3B1X2JvX2Rlc3Ryb3kgb2YgY291cnNlKS4KClNob3VsZG4ndCBiZSBtb3JlIHRoYW4g
YSB0d28gbGluZSBwYXRjaC4KClJlZ2FyZHMsCkNocmlzdGlhbi4KCj4KPgo+IFRoYW5rcywKPgo+
IE5pcm1veQo+Cj4+IENhbGwgVHJhY2U6Cj4+IMKgwqDCoCBhbGxvY19wYWdlc19jdXJyZW50KzB4
NmEvMHhlMAo+PiDCoMKgwqAga21hbGxvY19vcmRlcisweDMyLzB4YjAKPj4gwqDCoMKgIGttYWxs
b2Nfb3JkZXJfdHJhY2UrMHgxZS8weDgwCj4+IMKgwqDCoCBfX2ttYWxsb2MrMHgyNDkvMHgyZDAK
Pj4gwqDCoMKgIGFtZGdwdV9ib19jcmVhdGUrMHgxMDIvMHg1MDAgW2FtZGdwdV0KPj4gwqDCoMKg
ID8geGFzX2NyZWF0ZSsweDI2NC8weDNlMAo+PiDCoMKgwqAgYW1kZ3B1X2JvX2NyZWF0ZV92bSsw
eDMyLzB4NjAgW2FtZGdwdV0KPj4gwqDCoMKgIGFtZGdwdV92bV9wdF9jcmVhdGUrMHhmNS8weDI2
MCBbYW1kZ3B1XQo+PiDCoMKgwqAgYW1kZ3B1X3ZtX2luaXQrMHgxZmQvMHg0ZDAgW2FtZGdwdV0K
Pj4KPj4gQ2hhbmdlLUlkOiBJMjllNDc5ZGI0NWVhZDM3YzM5NDQ5ZTg1NjU5OWZkNGY2YTBlMzRj
ZQo+PiBTaWduZWQtb2ZmLWJ5OiBDaGFuZ2ZlbmcgPENoYW5nZmVuZy5aaHVAYW1kLmNvbT4KPj4g
LS0tCj4+IMKgIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jIHwgMjcgKysr
KysrKysrKysrKysrLS0tLS0tLS0tLS0KPj4gwqAgMSBmaWxlIGNoYW5nZWQsIDE2IGluc2VydGlv
bnMoKyksIDExIGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYW1kZ3B1X3ZtLmMgCj4+IGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3ZtLmMKPj4gaW5kZXggMTkyM2YwMzU3MTNhLi43MTRkNjEzZDAyMGIgMTAwNjQ0Cj4+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4+ICsrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV92bS5jCj4+IEBAIC04OTQsNiArODk0LDEw
IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3ZtX3B0X2NyZWF0ZShzdHJ1Y3QgCj4+IGFtZGdwdV9kZXZp
Y2UgKmFkZXYsCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBudW1fZW50cmllcyA9IDA7Cj4+IMKgIMKg
wqDCoMKgwqAgYnAuYm9fcHRyX3NpemUgPSBzdHJ1Y3Rfc2l6ZSgoKnZtYm8pLCBlbnRyaWVzLCBu
dW1fZW50cmllcyk7Cj4+ICvCoMKgwqAgaWYgKGJwLmJvX3B0cl9zaXplID4gMzIqQU1ER1BVX0dQ
VV9QQUdFX1NJWkUpIHsKPj4gK8KgwqDCoMKgwqDCoMKgIERSTV9JTkZPKCJDYW4ndCBhbGxvYyBt
ZW1vcnkgbGFyZ2VyIHRoYW4gMTI4S0IgYnkgdXNpbmcgCj4+IGt6YWxsb2MgaW4gYW1kZ3B1X2Jv
X2NyZWF0ZVxuIik7Cj4+ICvCoMKgwqDCoMKgwqDCoCBicC5ib19wdHJfc2l6ZSA9IHNpemVvZihz
dHJ1Y3QgYW1kZ3B1X2JvX3ZtKTsKPj4gK8KgwqDCoCB9Cj4+IMKgIMKgwqDCoMKgwqAgaWYgKHZt
LT51c2VfY3B1X2Zvcl91cGRhdGUpCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBicC5mbGFncyB8PSBB
TURHUFVfR0VNX0NSRUFURV9DUFVfQUNDRVNTX1JFUVVJUkVEOwo+PiBAQCAtOTY1LDE1ICs5Njks
MTkgQEAgc3RhdGljIGludCBhbWRncHVfdm1fYWxsb2NfcHRzKHN0cnVjdCAKPj4gYW1kZ3B1X2Rl
dmljZSAqYWRldiwKPj4gwqDCoMKgwqDCoCBzdHJ1Y3QgYW1kZ3B1X2JvX3ZtICpwdDsKPj4gwqDC
oMKgwqDCoCBpbnQgcjsKPj4gwqAgLcKgwqDCoCBpZiAoZW50cnktPmJhc2UuYm8pIHsKPj4gLcKg
wqDCoMKgwqDCoMKgIGlmIChjdXJzb3ItPmxldmVsIDwgQU1ER1BVX1ZNX1BUQikKPj4gLcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgZW50cnktPmVudHJpZXMgPQo+PiAtwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHRvX2FtZGdwdV9ib192bShlbnRyeS0+YmFzZS5ibyktPmVudHJpZXM7Cj4+
IC3CoMKgwqDCoMKgwqDCoCBlbHNlCj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGVudHJ5LT5l
bnRyaWVzID0gTlVMTDsKPj4gLcKgwqDCoMKgwqDCoMKgIHJldHVybiAwOwo+PiArwqDCoMKgIGlm
IChjdXJzb3ItPmxldmVsIDwgQU1ER1BVX1ZNX1BUQiAmJiAhZW50cnktPmVudHJpZXMpIHsKPj4g
K8KgwqDCoMKgwqDCoMKgIHVuc2lnbmVkIG51bV9lbnRyaWVzOwo+PiArwqDCoMKgwqDCoMKgwqAg
bnVtX2VudHJpZXMgPSBhbWRncHVfdm1fbnVtX2VudHJpZXMoYWRldiwgY3Vyc29yLT5sZXZlbCk7
Cj4+ICvCoMKgwqDCoMKgwqDCoCBlbnRyeS0+ZW50cmllcyA9IGt2bWFsbG9jX2FycmF5KG51bV9l
bnRyaWVzLAo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBzaXplb2YoKmVudHJ5LT5lbnRyaWVzKSwKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgR0ZQX0tFUk5FTCB8IF9fR0ZQX1pFUk8pOwo+PiArwqDCoMKg
wqDCoMKgwqAgaWYgKCFlbnRyeS0+ZW50cmllcykKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
cmV0dXJuIC1FTk9NRU07Cj4+IMKgwqDCoMKgwqAgfQo+PiDCoCArwqDCoMKgIGlmIChlbnRyeS0+
YmFzZS5ibykKPj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiAwOwo+PiArCj4+IMKgwqDCoMKgwqAg
ciA9IGFtZGdwdV92bV9wdF9jcmVhdGUoYWRldiwgdm0sIGN1cnNvci0+bGV2ZWwsIGltbWVkaWF0
ZSwgJnB0KTsKPj4gwqDCoMKgwqDCoCBpZiAocikKPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVy
biByOwo+PiBAQCAtOTg0LDEwICs5OTIsNiBAQCBzdGF0aWMgaW50IGFtZGdwdV92bV9hbGxvY19w
dHMoc3RydWN0IAo+PiBhbWRncHVfZGV2aWNlICphZGV2LAo+PiDCoMKgwqDCoMKgIHB0X2JvID0g
JnB0LT5ibzsKPj4gwqDCoMKgwqDCoCBwdF9iby0+cGFyZW50ID0gYW1kZ3B1X2JvX3JlZihjdXJz
b3ItPnBhcmVudC0+YmFzZS5ibyk7Cj4+IMKgwqDCoMKgwqAgYW1kZ3B1X3ZtX2JvX2Jhc2VfaW5p
dCgmZW50cnktPmJhc2UsIHZtLCBwdF9ibyk7Cj4+IC3CoMKgwqAgaWYgKGN1cnNvci0+bGV2ZWwg
PCBBTURHUFVfVk1fUFRCKQo+PiAtwqDCoMKgwqDCoMKgwqAgZW50cnktPmVudHJpZXMgPSBwdC0+
ZW50cmllczsKPj4gLcKgwqDCoCBlbHNlCj4+IC3CoMKgwqDCoMKgwqDCoCBlbnRyeS0+ZW50cmll
cyA9IE5VTEw7Cj4+IMKgIMKgwqDCoMKgwqAgciA9IGFtZGdwdV92bV9jbGVhcl9ibyhhZGV2LCB2
bSwgcHQsIGltbWVkaWF0ZSk7Cj4+IMKgwqDCoMKgwqAgaWYgKHIpCj4+IEBAIC0xMDE3LDYgKzEw
MjEsNyBAQCBzdGF0aWMgdm9pZCBhbWRncHVfdm1fZnJlZV90YWJsZShzdHJ1Y3QgCj4+IGFtZGdw
dV92bV9wdCAqZW50cnkpCj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBhbWRncHVfYm9fdW5yZWYoJnNo
YWRvdyk7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBhbWRncHVfYm9fdW5yZWYoJmVudHJ5LT5iYXNl
LmJvKTsKPj4gwqDCoMKgwqDCoCB9Cj4+ICvCoMKgwqAga3ZmcmVlKGVudHJ5LT5lbnRyaWVzKTsK
Pj4gwqDCoMKgwqDCoCBlbnRyeS0+ZW50cmllcyA9IE5VTEw7Cj4+IMKgIH0KCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0
CmFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Au
b3JnL21haWxtYW4vbGlzdGluZm8vYW1kLWdmeAo=
