Return-Path: <SRS0=drzA=JM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5682C433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Apr 2021 15:09:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9717961131
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Apr 2021 15:09:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9717961131
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5941A6EA67;
	Thu, 15 Apr 2021 15:09:12 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2075.outbound.protection.outlook.com [40.107.223.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 02E226EA67
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Apr 2021 15:09:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oUGW28M10fWgwUGTRoqdOsTX4A3TXbkya3s0jndvThKW4sMIBMVABLsCCAwmgq9oubH3eXeWlFmvSV5KHh/ahmNAFnEYwZMKr4fTFeF7259RIx7+jvDKitPLOFC/1zdlvaMIj0wfGXblOM1+FkmfjQNBqdqrkhZuxYWs4Ri0xyjERVwjO7c+diSeUcH5+P4IHGPfq4QBeCLQBWgkXXBKgFhNxE2Lb8Y6MLoEv8ccWiSq7C0z3xoT7vZiShF5+c44nM4G3D3+d56AFSoLKE2JYrIswkGHdshhjYfjoZs7dZUrWRdz9paWhB3G3rTp97AxqIKoxGkYMtNv0F4/RHSatw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=od2DLl0mAFB9YKI0QuPeLXMrxVL4SpfBZyQgd3f+GXM=;
 b=BR40vDkzSZkJ2betPSMaIG8NkICmCxOzmzdx8OpSdy7+aGqiFuBKeOoFmtTfl86jX7rtc21un7kgbhQwLMgtfhuV4OewPn4kBdWAnqoiaa1H29/0gfz+YJJD79jB6bNaFP3WwXgM3ChK4Ab4E8FqSuVFxFg5cfcnr7pH+TnA4D4+oUod5E+pvc7qel5iPxU+mBN+KPdY4IlZ8Qc/Pf+g98LfXvRC7juhNU+PYZtovNPcEd70fZJas9ALzd/Xy9GcQvbWH68mvu7OGQzmZqOYXedU3/wIskLOvFPe0QwFVy67FGC+mnZStqRf/VQUGTNHgg023n6aNDo2fnJ99zaJjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=od2DLl0mAFB9YKI0QuPeLXMrxVL4SpfBZyQgd3f+GXM=;
 b=mHztYRKkxdH/tEbtLvZyjUH+Fxt78QSKSJ/naXGgHN1uN9P/s20IQK4uBMdybqijGtRyQEjCqTr5qww6kpkEJlPzskh2OKTYQ+Uveg6GsSSe59ZMde0GNcOYa4wzp/o0OxmbWDMKrN7TGIgZGm8tP3R9q7sDvyneW86HPvfrW+A=
Authentication-Results: ffwll.ch; dkim=none (message not signed)
 header.d=none;ffwll.ch; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB4690.namprd12.prod.outlook.com (2603:10b6:208:8e::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Thu, 15 Apr
 2021 15:09:06 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6d4d:4674:1cf6:8d34%6]) with mapi id 15.20.4020.025; Thu, 15 Apr 2021
 15:09:06 +0000
Subject: Re: [PATCH 0/4] Refine GPU recovery sequence to enhance its stability
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Li, Dennis" <Dennis.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>, Daniel Vetter <daniel@ffwll.ch>
References: <20210318072339.28736-1-Dennis.Li@amd.com>
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
 <b30c75cf-9b00-b52d-1ac1-ccd33e02bfe3@amd.com>
 <3dab0504-b834-add7-1f2f-0237b0f0c20d@amd.com>
 <bb13794d-1067-6b91-c2dc-138118c3ef0d@amd.com>
 <cd66c76d-5678-f495-75a8-b8c4f6458353@gmail.com>
 <1b35efc3-87c8-7ec3-1ad3-bb7c9ab515ba@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <c96838ae-9fcd-ce32-2bf7-a0324016ebb8@amd.com>
Date: Thu, 15 Apr 2021 17:09:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <1b35efc3-87c8-7ec3-1ad3-bb7c9ab515ba@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:7291:d81e:8eb2:63ca]
X-ClientProxiedBy: PR0P264CA0103.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:19::19) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:7291:d81e:8eb2:63ca]
 (2a02:908:1252:fb60:7291:d81e:8eb2:63ca) by
 PR0P264CA0103.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:19::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.16 via Frontend Transport; Thu, 15 Apr 2021 15:09:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c42979f-0b2f-46d3-cea4-08d900206978
X-MS-TrafficTypeDiagnostic: BL0PR12MB4690:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB4690772E450A4AAC2DE336E3834D9@BL0PR12MB4690.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OtYAnrm4sYsg9Jgd/aanTYpprLg6ZOeNldVDubWgeimvpeXUov9MI5e3y4EPh/nmlZcfBoo32PTwogeW8CHK0+ApV7gkn+fQHZw6KkWD0NCs43cNmrA0eha7MjGbk0mz2F2eIQzm0879RVFz1ExSAfxK1UvxlRBuF6gdY+1v8hZ5f+9xRjey57whoHY8QA1rU1TZ9pMIg2eeDDGJb9/cRqa0rAjuQwb2O7MvHQPmyR0MEsKECdGKNA6D/2hz7A0T9dLiqEsLgsssjLla/vL1AgtWdKvlH0h5FGSqo+Coq1mgBaL+KV3yNwcp0fIyDkcM4u9YHrQ9+HDrL22y2Qm2j/isXw+cDdHL63MT0r+44ag0XCLH//Ta5hEhXAlYZIQu0VMi0yEx9+kXjpz7Z7ynEQtE/7+6GTQcHoTjIPbRDQAH/jIb7BmYszdKkmWhs/eIRNWojDNtkTUI0UB8dHmtNpfoRF9qE8YPla4S5eC3NVsdFpUwHetW9SlhVKsrJ92M5ntQ66H9i+9VHZeysHQwou+gkdSPGRSiMTExEMYQkcShnOKTVR0iBTzXRUqgdG9H104kgElcNhhyg5Ew3KzRF0fF1KqOaqIGMrATaKdDPxBbHBsku58Bt7wc3BMsiyuSP2RN/IUD3IUmIp55avL2IV1yZCsUXwLnvtvjgcdTl2cb6GkV01oeN84WTi0EPBKVFzuXveBdr2GAYXj9BxKBLS/dr5szhoxl7bIPywqdfTHkC88TrictTH8FSawvqPOd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(366004)(376002)(39860400002)(136003)(921005)(6486002)(8676002)(5660300002)(45080400002)(316002)(478600001)(31686004)(36756003)(31696002)(52116002)(83380400001)(8936002)(66946007)(2906002)(16526019)(2616005)(966005)(66476007)(66556008)(38100700002)(110136005)(6666004)(186003)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?c1JocVFjbEh2WUxYc01sZG03WFh1aW5BOUNiaTVYajkyeFBRbCtsZTY5MEpX?=
 =?utf-8?B?ZjVOSU9MNXp1b3I2YkFGZUt2MmdId1U4bVhzUkRIM3ptZS83K1QxTVZHZG93?=
 =?utf-8?B?b1dncUJuWExaVEZ2c28xQUJDeW9PdXcrOHB1cHRQbFRSYjQ4NmVrOVJOMFYw?=
 =?utf-8?B?NmM0bytqNHVrMmRCVkxhQVdsbytwdnhKWUE2WEZXM3JiV3Zlb2pRcDVqUkJR?=
 =?utf-8?B?ZlBEblBxZEhhaDgxelpFVklxZWZmVXZMNWxxMWg5L29uR0FhMEh2dWNTdFdn?=
 =?utf-8?B?SGRHbGJaSFZiTytzakdkc0RuVlBxU3dJdG5JaEREaGtEdFhrVFJTK2JMaE1l?=
 =?utf-8?B?RDNBQ2R3RitHWm81V2RBQjBaa08zaGxERG9pVzZ0aHFiczh3NWhDa3lDay9S?=
 =?utf-8?B?Nm9zd3dWMCtEbDFxVUlSN2ZKdWQxV05aRkZIaS9BaVBRL0FYOUx4dEhweDF3?=
 =?utf-8?B?aFFIRXBoREw1RjVnQXREVUoyUTloSmNNMHppSTdoZFFZWTY4eVpGRW5RQnRr?=
 =?utf-8?B?YzEwTnZidng3WU5NVVFkWTRjVTkycUJQN0lZUTREZnh3b3ZURkRBUElHWVRa?=
 =?utf-8?B?YlFBVkJJQm5RTDVqLy8rRE9GMVA2TXUvcS9PZkNoYW9vc0swamI5bHFENHNm?=
 =?utf-8?B?U0g0RGtIRkEwekZIOG5PWTc4a1g2Z3lVdDAxQXc0TDBteUVRdDc2bkdSUm5C?=
 =?utf-8?B?Rnc1VTRYWHpZTXNoV0ZLOW15SXRsZGJHeUV4cnk3SXFDYmE2MnBRdVZ0a1J5?=
 =?utf-8?B?U3p1RnVtc01ZUEl1eVY2QjNEYjVsUWxoZ044ZkdneFRUaXNrelNQNnRSemJv?=
 =?utf-8?B?L1VOU1k2bm5QVHVTY2N3SEtxdnpBVW16U2EySHphYldKRHFJLzJoUm1iOG5N?=
 =?utf-8?B?bDJaSm5DNmY3SE1KQko2NFlZdVRjaWNJM2VzK1B6OWFWSVJnN29SM0F2MG5z?=
 =?utf-8?B?WTVyM1JuQUtyK1NGNGNTVVR6aTV5VDlsbzNtOUZNMFEySmFSNVBOaVRGNDFq?=
 =?utf-8?B?WDVPbXpSSElDNnV2ZHVnZTVXVGtYOSsrYWZMUVZaOHprbkpLanpsdXZPZW5K?=
 =?utf-8?B?aEZPdEZBMzQzNmllS1dZRCtuRThzQ0c0SEI1bi9oRjNqdklrWGNaM0Z5clp2?=
 =?utf-8?B?T3JoYm1SZlozelhyRGtrVUFHcVdMNjA1ZGFXNjZ2VU1Jbk55dlFCNlAydmtT?=
 =?utf-8?B?OVJBN1REcnlrQUYxVEhUOHYvNFdmSHA1dHN5WWxxdnpiUmtCU2lMS2hZdmZ4?=
 =?utf-8?B?RFUwUXhaYVd1NmgrTnNPUUIvV1lueGkzTlFCbDhHc243ZWhSYWNMZjFwYnZm?=
 =?utf-8?B?WEZNMjZMVDE3cmpydkp2YitSSHpIa2czSGlKYjRUN2lOTEhITEpGQ3pmOHNY?=
 =?utf-8?B?WFdlQ3JUZmFvV3lnamlieDhkYTNJek5rbk85V0xQbmc2QlVBcW8rYTU3R0xu?=
 =?utf-8?B?cG5ESmxIbm5aRGNoWktCWm5Md0xndWxCWDgrQWpMc0s3UkdWM3N4Ymh1L1ZF?=
 =?utf-8?B?TlhQN1NnVHhiWDAzVjR0YzBXNzBZTjAxaXo5c0FjZEVENHNaRzRONWxEeGt5?=
 =?utf-8?B?dHdHSjlLQ1BtcWJBWUxEaVViSWxKd1R2d1JhK01rOWt6WUY0NE5oSTY3a1Mw?=
 =?utf-8?B?a1JHYjgrRVFmMHdjU3Y2QXVUM0RSQXNrYWtMS0dlS3I4eFh0MCt5TUNWQXgy?=
 =?utf-8?B?d1pTWUg0SnQrZVpjSzd0R0NFK0F5QWc5MWtnVkRaVmw3cjI2MFBqUUVhdG42?=
 =?utf-8?B?UmoxK2VoY2FWRU52RDhqTC91amVEWVpsd2xkeFp5YkNQQ1NueWFzQnFELzRL?=
 =?utf-8?B?TWFDYW42Z3YydTY2Z2t6MU5MTWVxNWtnV1pOa0g3VVBwalJhRksvUDQ0UjFW?=
 =?utf-8?Q?AAWNAVX72WhVV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c42979f-0b2f-46d3-cea4-08d900206978
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2021 15:09:05.9583 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LPtaOHV5KiS/NBES+9Yu41pGEMycUX1NRUO8mBu/IbiG49IzRK9Pkuymsl4tXzKk
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

Cj4+Pgo+Pj4+IFtTTklQXQo+Pj4+Pj4+Cj4+Pj4+Pj4gTWF5YmUganVzdCBlbXBpcmljYWxseSAt
IGxldCdzIHRyeSBpdCBhbmQgc2VlIHVuZGVyIGRpZmZlcmVudCAKPj4+Pj4+PiB0ZXN0IHNjZW5h
cmlvcyB3aGF0IGFjdHVhbGx5IGhhcHBlbnPCoCA/Cj4+Pj4+Pgo+Pj4+Pj4gTm90IGEgZ29vZCBp
ZGVhIGluIGdlbmVyYWwsIHdlIGhhdmUgdGhhdCBhcHByb2FjaCB3YXkgdG8gb2Z0ZW4gYXQgCj4+
Pj4+PiBBTUQgYW5kIGFyZSB0aGVuIHN1cnByaXNlZCB0aGF0IGV2ZXJ5dGhpbmcgd29ya3MgaW4g
UUEgYnV0IGZhaWxzIAo+Pj4+Pj4gaW4gcHJvZHVjdGlvbi4KPj4+Pj4+Cj4+Pj4+PiBCdXQgRGFu
aWVsIGFscmVhZHkgbm90ZWQgaW4gaGlzIHJlcGx5IHRoYXQgd2FpdGluZyBmb3IgYSBmZW5jZSAK
Pj4+Pj4+IHdoaWxlIGhvbGRpbmcgdGhlIFNSQ1UgaXMgZXhwZWN0ZWQgdG8gd29yay4KPj4+Pj4+
Cj4+Pj4+PiBTbyBsZXQncyBzdGljayB3aXRoIHRoZSBhcHByb2FjaCBvZiBoaWdoIGxldmVsIGxv
Y2tpbmcgZm9yIGhvdHBsdWcuCj4+Pj4+Cj4+Pj4+Cj4+Pj4+IFRvIG15IHVuZGVyc3RhbmRpbmcg
dGhpcyBpcyB0cnVlIGZvciBvdGhlciBkZXZpc2VzLCBub3QgdGhlIG9uZSAKPj4+Pj4gYmVpbmcg
ZXh0cmFjdGVkLCBmb3IgaGltIHlvdSBzdGlsbCBuZWVkIHRvIGRvIGFsbCB0aGUgSFcgZmVuY2Ug
Cj4+Pj4+IHNpZ25hbGxpbmcgZGFuY2UgYmVjYXVzZSB0aGUgSFcgaXMgZ29uZSBhbmQgd2UgYmxv
Y2sgYW55IFREUnMgCj4+Pj4+ICh3aGljaCB3b24ndCBoZWxwIGFueXdheSkuCj4+Pj4+Cj4+Pj4+
IEFuZHJleQo+Pj4KPj4+Cj4+PiBEbyB5b3UgYWdyZWUgdG8gdGhlIGFib3ZlID8KPj4KPj4gWWVh
aCwgSSB0aGluayB0aGF0IGlzIGNvcnJlY3QuCj4+Cj4+IEJ1dCBvbiB0aGUgb3RoZXIgaGFuZCB3
aGF0IERhbmllbCByZW1pbmRlZCBtZSBvZiBpcyB0aGF0IHRoZSBoYW5kbGluZyAKPj4gbmVlZHMg
dG8gYmUgY29uc2lzdGVudCBvdmVyIGRpZmZlcmVudCBkZXZpY2VzLiBBbmQgc2luY2Ugc29tZSBk
ZXZpY2UgCj4+IGFscmVhZHkgZ28gd2l0aCB0aGUgYXBwcm9hY2ggb2YgY2FuY2VsaW5nIGV2ZXJ5
dGhpbmcgd2Ugc2ltcGx5IGhhdmUgCj4+IHRvIGdvIGRvd24gdGhhdCByb3V0ZSBhcyB3ZWxsLgo+
Pgo+PiBDaHJpc3RpYW4uCj4KPgo+IFdoYXQgZG9lcyBpdCBtZWFuIGluIG91ciBjb250ZXh0ID8g
V2hhdCBuZWVkcyB0byBiZSBkb25lIHdoaWNoIHdlIGFyZSAKPiBub3QgZG9pbmcgbm93ID8KCkkg
dGhpbmsgd2UgYXJlIGZpbmUsIHdlIGp1c3QgbmVlZCB0byBjb250aW51ZSB3aXRoIHRoZSBhcHBy
b2FjaCBvZiAKZm9yY2VmdWxseSBzaWduYWxpbmcgYWxsIGZlbmNlcyBvbiBob3RwbHVnLgoKQ2hy
aXN0aWFuLgoKPgo+IEFuZHJleQo+Cj4KPj4KPj4+Cj4+PiBBbmRyZXkKPj4+Cj4+Pgo+Pj4+Pgo+
Pj4+Pgo+Pj4+Pj4KPj4+Pj4+IENocmlzdGlhbi4KPj4+Pj4+Cj4+Pj4+Pj4KPj4+Pj4+PiBBbmRy
ZXkKPj4+Pj4+Pgo+Pj4+Pj4+Cj4+Pj4+Pj4+Cj4+Pj4+Pj4+IENocmlzdGlhbi4KPj4+Pj4+Pj4K
Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+PiBBbmRyZXkKPj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+
PiBSZWdhcmRzLAo+Pj4+Pj4+Pj4+IENocmlzdGlhbi4KPj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pgo+
Pj4+Pj4+Pj4+PiBBbmRyZXkKPj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Cj4+
Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+
Pj4gQlRXOiBDb3VsZCBpdCBiZSB0aGF0IHRoZSBkZXZpY2UgU1JDVSBwcm90ZWN0cyBtb3JlIAo+
Pj4+Pj4+Pj4+Pj4+Pj4+IHRoYW4gb25lIGRldmljZSBhbmQgd2UgZGVhZGxvY2sgYmVjYXVzZSBv
ZiB0aGlzPwo+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+PiBJ
IGhhdmVuJ3QgYWN0dWFsbHkgZXhwZXJpZW5jZWQgYW55IGRlYWRsb2NrIHVudGlsIG5vdyAKPj4+
Pj4+Pj4+Pj4+Pj4+IGJ1dCwgeWVzLCBkcm1fdW5wbHVnX3NyY3UgaXMgZGVmaW5lZCBhcyBzdGF0
aWMgaW4gCj4+Pj4+Pj4+Pj4+Pj4+PiBkcm1fZHJ2LmMgYW5kIHNvIGluIHRoZSBwcmVzZW5jZSBv
ZiBtdWx0aXBsZSBkZXZpY2VzIAo+Pj4+Pj4+Pj4+Pj4+Pj4gZnJvbSBzYW1lIG9yIGRpZmZlcmVu
dCBkcml2ZXJzIHdlIGluIGZhY3QgYXJlIGRlcGVuZGVudCAKPj4+Pj4+Pj4+Pj4+Pj4+IG9uIGFs
bCB0aGVpciBjcml0aWNhbCBzZWN0aW9ucyBpIGd1ZXNzLgo+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+
Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4gU2hpdCwgeWVhaCB0aGUgZGV2aWwgaXMgYSBzcXVpcnJl
bC4gU28gZm9yIEErSSBsYXB0b3BzIHdlIAo+Pj4+Pj4+Pj4+Pj4+PiBhY3R1YWxseSBuZWVkIHRv
IHN5bmMgdGhhdCB1cCB3aXRoIERhbmllbCBhbmQgdGhlIHJlc3Qgb2YgCj4+Pj4+Pj4+Pj4+Pj4+
IHRoZSBpOTE1IGd1eXMuCj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+IElJUkMgd2UgY291
bGQgYWN0dWFsbHkgaGF2ZSBhbiBhbWRncHUgZGV2aWNlIGluIGEgZG9ja2luZyAKPj4+Pj4+Pj4+
Pj4+Pj4gc3RhdGlvbiB3aGljaCBuZWVkcyBob3RwbHVnIGFuZCB0aGUgZHJpdmVyIG1pZ2h0IGRl
cGVuZCAKPj4+Pj4+Pj4+Pj4+Pj4gb24gd2FpdGluZyBmb3IgdGhlIGk5MTUgZHJpdmVyIGFzIHdl
bGwuCj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+IENhbid0IHdlIHBy
b3Bvc2UgYSBwYXRjaCB0byBtYWtlIGRybV91bnBsdWdfc3JjdSBwZXIgCj4+Pj4+Pj4+Pj4+Pj4g
ZHJtX2RldmljZSA/IEkgZG9uJ3Qgc2VlIHdoeSBpdCBoYXMgdG8gYmUgZ2xvYmFsIGFuZCBub3Qg
Cj4+Pj4+Pj4+Pj4+Pj4gcGVyIGRldmljZSB0aGluZy4KPj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+
PiBJJ20gcmVhbGx5IHdvbmRlcmluZyB0aGUgc2FtZSB0aGluZyBmb3IgcXVpdGUgYSB3aGlsZSBu
b3cuCj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4gQWRkaW5nIERhbmllbCBhcyB3ZWxsLCBtYXli
ZSBoZSBrbm93cyB3aHkgdGhlIAo+Pj4+Pj4+Pj4+Pj4gZHJtX3VucGx1Z19zcmN1IGlzIGdsb2Jh
bC4KPj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+PiBSZWdhcmRzLAo+Pj4+Pj4+Pj4+Pj4gQ2hyaXN0
aWFuLgo+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+IEFuZHJleQo+Pj4+
Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4gQ2hy
aXN0aWFuLgo+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4gQW5kcmV5Cj4+Pj4+Pj4+Pj4+
Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+IENo
cmlzdGlhbi4KPj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+PiBBbmRyZXkKPj4+Pj4+
Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+
Pj4+Pj4+Pj4+Pj4gQW5kcmV5Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+
Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+PiBDaHJpc3RpYW4uCj4+
Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+PiAvKiBQYXN0IHRoaXMgcG9p
bnQgbm8gbW9yZSBmZW5jZSBhcmUgc3VibWl0dGVkIHRvIAo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4g
SFcgcmluZyBhbmQgaGVuY2Ugd2UgY2FuIHNhZmVseSBjYWxsIGZvcmNlIHNpZ25hbCAKPj4+Pj4+
Pj4+Pj4+Pj4+Pj4+Pj4+IG9uIGFsbCB0aGF0IGFyZSBjdXJyZW50bHkgdGhlcmUuCj4+Pj4+Pj4+
Pj4+Pj4+Pj4+Pj4+PiDCoMKgwqDCoCAqIEFueSBzdWJzZXF1ZW50bHkgY3JlYXRlZCBIVyBmZW5j
ZXMgd2lsbCBiZSAKPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+IHJldHVybmVkIHNpZ25hbGVkIHdpdGgg
YW4gZXJyb3IgY29kZSByaWdodCBhd2F5Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+PiDCoMKgwqDCoCAq
Lwo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+IMKgwqDCoCBmb3Jf
ZWFjaF9yaW5nKGFkZXYpCj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+PiBhbWRncHVfZmVuY2VfcHJvY2Vz
cyhyaW5nKQo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+IMKgwqDC
oCBkcm1fZGV2X3VucGx1ZyhkZXYpOwo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gwqDCoMKgIFN0b3Ag
c2NoZWR1bGVycwo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gwqDCoMKgIGNhbmNlbF9zeW5jKGFsbCB0
aW1lcnMgYW5kIHF1ZXVlZCB3b3Jrcyk7Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+PiDCoMKgwqAgaHdf
ZmluaQo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gwqDCoMKgIHVubWFwX21taW8KPj4+Pj4+Pj4+Pj4+
Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+PiB9Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+
Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+IEFuZHJleQo+Pj4+Pj4+
Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+
Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+
Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+PiBBbHRlcm5hdGl2
ZWx5IGdyYWJiaW5nIHRoZSByZXNldCB3cml0ZSBzaWRlIAo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+
Pj4+PiBhbmQgc3RvcHBpbmcgYW5kIHRoZW4gcmVzdGFydGluZyB0aGUgCj4+Pj4+Pj4+Pj4+Pj4+
Pj4+Pj4+Pj4+Pj4+IHNjaGVkdWxlciBjb3VsZCB3b3JrIGFzIHdlbGwuCj4+Pj4+Pj4+Pj4+Pj4+
Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+IENocmlzdGlhbi4KPj4+Pj4+
Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+
Pj4+Pj4+Pj4+Pj4+Pj4gSSBkaWRuJ3QgZ2V0IHRoZSBhYm92ZSBhbmQgSSBkb24ndCBzZWUgd2h5
IEkgCj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gbmVlZCB0byByZXVzZSB0aGUgR1BVIHJlc2V0
IHJ3X2xvY2suIEkgcmVseSBvbiAKPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+PiB0aGUgU1JDVSB1
bnBsdWcgZmxhZyBmb3IgdW5wbHVnLiBBbHNvLCBub3QgCj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+
Pj4gY2xlYXIgdG8gbWUgd2h5IGFyZSB3ZSBmb2N1c2luZyBvbiB0aGUgCj4+Pj4+Pj4+Pj4+Pj4+
Pj4+Pj4+Pj4+Pj4gc2NoZWR1bGVyIHRocmVhZHMsIGFueSBjb2RlIHBhdGNoIHRvIGdlbmVyYXRl
IAo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+IEhXIGZlbmNlcyBzaG91bGQgYmUgY292ZXJlZCwg
c28gYW55IGNvZGUgCj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gbGVhZGluZyB0byBhbWRncHVf
ZmVuY2VfZW1pdCBuZWVkcyB0byBiZSB0YWtlbiAKPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+PiBp
bnRvIGFjY291bnQgc3VjaCBhcywgZGlyZWN0IElCIHN1Ym1pc3Npb25zLCAKPj4+Pj4+Pj4+Pj4+
Pj4+Pj4+Pj4+Pj4+PiBWTSBmbHVzaGVzIGUudC5jCj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+
Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gWW91IG5lZWQgdG8gd29yayB0b2dldGhlciB3aXRoIHRo
ZSByZXNldCBsb2NrIAo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gYW55d2F5LCBjYXVzZSBhIGhv
dHBsdWcgY291bGQgcnVuIGF0IHRoZSBzYW1lIAo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gdGlt
ZSBhcyBhIHJlc2V0Lgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+
Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+PiBGb3IgZ29pbmcgbXkgd2F5IGluZGVlZCBub3cg
SSBzZWUgbm93IHRoYXQgSSAKPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gaGF2ZSB0byB0YWtlIHJl
c2V0IHdyaXRlIHNpZGUgbG9jayBkdXJpbmcgSFcgCj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+IGZl
bmNlcyBzaWduYWxsaW5nIGluIG9yZGVyIHRvIHByb3RlY3QgYWdhaW5zdCAKPj4+Pj4+Pj4+Pj4+
Pj4+Pj4+Pj4+Pj4gc2NoZWR1bGVyL0hXIGZlbmNlcyBkZXRhY2htZW50IGFuZCByZWF0dGFjaG1l
bnQgCj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+IGR1cmluZyBzY2hlZHVsZXJzIHN0b3AvcmVzdGFy
dC4gQnV0IGlmIHdlIGdvIAo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+PiB3aXRoIHlvdXIgYXBwcm9h
Y2ggdGhlbiBjYWxsaW5nIGRybV9kZXZfdW5wbHVnIAo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+PiBh
bmQgc2NvcGluZyBhbWRncHVfam9iX3RpbWVvdXQgd2l0aCAKPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+
Pj4gZHJtX2Rldl9lbnRlci9leGl0IHNob3VsZCBiZSBlbm91Z2ggdG8gcHJldmVudCAKPj4+Pj4+
Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gYW55IGNvbmN1cnJlbnQgR1BVIHJlc2V0cyBkdXJpbmcgdW5wbHVn
LiBJbiBmYWN0IAo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+PiBJIGFscmVhZHkgZG8gaXQgYW55d2F5
IC0gCj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+IGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3Rl
Y3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwczolMkYlMkZjZ2l0LmZyZWVkZXNrdG9wLm9yZyUy
Rn5hZ3JvZHpvdiUyRmxpbnV4JTJGY29tbWl0JTJGJTNGaCUzRGRybS1taXNjLW5leHQlMjZpZCUz
RGVmMGVhNGRkMjllZjQ0ZDI2NDljNWVkYTE2YzhmNDg2OWFjYzM2YjEmYW1wO2RhdGE9MDQlN0Mw
MSU3Q2FuZHJleS5ncm9kem92c2t5JTQwYW1kLmNvbSU3Q2E2NGIxZjVlMGRmMDQwM2E2NTY0MDhk
OGZmZGM3YmRiJTdDM2RkODk2MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYz
NzU0MDY2OTczMjY5MjQ4NCU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpXSWpvaU1DNHdMakF3
TURBaUxDSlFJam9pVjJsdU16SWlMQ0pCVGlJNklrMWhhV3dpTENKWFZDSTZNbjAlM0QlN0MxMDAw
JmFtcDtzZGF0YT1wTGNwbG5sRElFU1Y5OTh0TE83aXlkeEVvNWxoNzFCalFDYkFPeEtpZjJRJTNE
JmFtcDtyZXNlcnZlZD0wIAo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+
Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gWWVzLCBnb29kIHBvaW50IGFzIHdlbGwuCj4+
Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+PiBDaHJpc3RpYW4uCj4+
Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+
Pj4+Pj4+Pj4+Pj4gQW5kcmV5Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+
Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+
Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+IENocmlzdGlhbi4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+
Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+
PiBBbmRyZXkKPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+
Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+
Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gQ2hyaXN0aWFuLgo+Pj4+Pj4+Pj4+Pj4+Pj4+
Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+
Pj4+Pj4+Pj4+Pj4+IEFuZHJleQo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+
Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+
Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+IEFuZHJleQo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+
Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+
Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+
Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+
Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pgo+
Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pgo+Pj4+Pj4KPj4+
Pgo+PgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
