Return-Path: <SRS0=eSA1=JK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E8DCC433ED
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 18:30:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D21C9613BD
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Apr 2021 18:30:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D21C9613BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8616D6E85E;
	Tue, 13 Apr 2021 18:30:47 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E90D6E85D
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Apr 2021 18:30:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jCEUk6OyFl69EtwNIxSOilLHsXjO1STn5xPf+0k6tBowP1kNvlF6QeIDodo4puoVlqMOcNhYiP7jMzyPmcvNMUI3EuIBNkNulXd2JenGtZk/0ExjXuXwRWzY7RWjRMcEG2ira4Xzs+n21Hak73IhT2ca26huj4h5yczvMeHa2nejk/MPkUm9NWB6NKit9i6jIgwj7KfxF70xn8Eysaln6pv6Q6QEXs35SdGXjoyLtaB1IspIs7libD4//GRlEWxRpK4dxyQFJnakwS+ubPj4PYC+ZCDibtK+fCWfPnzG5wpK4qUpQPswyiYvXXtv63wpxNI8FljcVhJPqR9rln3vhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3zAk8QQHHvN+0TX0mfu9MGHhY9anyCnFC9mFxJpOwY=;
 b=gf2pZ83IY9vWEIsBoO8uNjA+D5r8QENuIxHI7swIyiH3tbLHmOTgW+sOwTm5zTcBYC0OFSNgrxdkpQ3JG1F7R8K2izpHQRhOXWv7ebVXEBmsp6JG2RjVwSZEHqMTiwON2dFalmiGYfThJVsaWSkTB8MV5y02mAaFUGsxVkvTts5A1dpMPZsJfyHbNgxBQuU+EXbqFJAmgduYAZa7fwuyP8iNx6q31uQQGeUHkBRbtifJ06m+rnvVgNvZy6nEIhPn84mRHfTUyy0JFxoKDZwgeoRFnKRlq07jEcjI9mvdwyWzjKy79pQ6qHV4MDeUlV96nz5E9Yl3/QqWRpoXXfnkxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3zAk8QQHHvN+0TX0mfu9MGHhY9anyCnFC9mFxJpOwY=;
 b=jfL4ekCHYHqckF48pOSsnQqF2NRADlNZKSTq7GcyJ0C/GdYfugWI4Izw8YuEzzsVXG20iyFo1ZQ+p3/IQQutSgBv+40cayJNqeRK7Zd2TzAHR2w0pdjJsssYl6mZ7Jr6lP8dAFlFkiHhDVngYyiUz+sTTTs5iNw63R22/0qwRjA=
Authentication-Results: ffwll.ch; dkim=none (message not signed)
 header.d=none;ffwll.ch; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SN1PR12MB2397.namprd12.prod.outlook.com (2603:10b6:802:27::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Tue, 13 Apr
 2021 18:30:42 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::89b0:10d7:12d3:efde]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::89b0:10d7:12d3:efde%5]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 18:30:42 +0000
Subject: Re: [PATCH 0/4] Refine GPU recovery sequence to enhance its stability
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Li, Dennis" <Dennis.Li@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>, Daniel Vetter <daniel@ffwll.ch>
References: <20210318072339.28736-1-Dennis.Li@amd.com>
 <32b2ab00-7514-43ce-cb28-a437c194c16a@gmail.com>
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
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <65cd86df-b660-6c8a-348e-d511b61d91d4@amd.com>
Date: Tue, 13 Apr 2021 14:30:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <e37d6954-46e7-e7eb-22c3-a5b19829fe6c@amd.com>
Content-Language: en-US
X-Originating-IP: [2607:fea8:3edf:49b0:9da9:a38:3558:d1d1]
X-ClientProxiedBy: YT1PR01CA0118.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::27) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:9da9:a38:3558:d1d1]
 (2607:fea8:3edf:49b0:9da9:a38:3558:d1d1) by
 YT1PR01CA0118.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.21 via Frontend Transport; Tue, 13 Apr 2021 18:30:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aae1a43b-dcf2-4d43-d5ca-08d8feaa3eb6
X-MS-TrafficTypeDiagnostic: SN1PR12MB2397:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2397C89C6F5B5E92B4A9376BEA4F9@SN1PR12MB2397.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qrha43wswR7enc9ERkqRZ0QKPEpAiR7i/LIgQ4mI5SFaFbZmG55PM962ERh/6wDMrlmUiECAOijzGh7yYRYGth1015BH5ur0jtvVchi4CNFjDq82zlWwj4JsN0hZbH+5lr6o3/lex6+BU/SqqWnPyAEtPmRfycw/uiEO/u4l6NSB9UYNQuqHadgUxsEpJvMzH2z9ib6ran89yJ/XxhNOlO8rZgZgWZQcnzmIN26Z0dUludokYNjbIXDolHmt2QCcjhCS46zQedIFqj1ZVx7Ondluxhm5J3pjuKuUBhZMgvqlASu8PwHVJpIYHx08TengnfVC2jaP9p5OtET6vuCiJMU31Og4T0rlBgzkiZKwVlKFxQaree+mbEj9sd/isrQLNj/j/c0nFp9AR9NKCDq9vm3Hhrn0sa/qhwfbl3KObsWaAoILSNaqt6bIOjRZYQ5mmijYdKgp/PR9q1XBbFI9aawHH9XQcve4EJHn/28BXT1qoH3dY5P2P77C8kT0Zlh+ux3wMH1m30gxTWZwQzfEqsh6YUDx1jFQp6q2+Q5OQsCD2+au3+TXANr0vDle3hcZMNsCnZszfwoZissX16DyjE1tZnCLBCKfWt9Nr8Fs3KeiyaN8E74YlHz4ws74e9rm/IhxWgoD3RWAm2TwVL8wqo3wCwc4jUqL94EJRHMyIOWPaj8ekwEL1u+Z6EyNYKprGgWek8xXjODJETStl+KaWMxMof9EIJF4zLNvbTgduzdwUBa0lE6MpWbMMsPBodK96h//Sq6TrUgMi5ot9226kg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(366004)(396003)(346002)(136003)(44832011)(5660300002)(8936002)(8676002)(316002)(45080400002)(186003)(53546011)(66556008)(36756003)(110136005)(16526019)(478600001)(966005)(38100700002)(6486002)(66476007)(66946007)(31696002)(2906002)(52116002)(83380400001)(86362001)(31686004)(66574015)(921005)(2616005)(60764002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ejRsMmFvVTY4a1c1OFBZZGNCUW9HUFIrK01DRnV3dGxFL1ZjVi9WUmlBam1T?=
 =?utf-8?B?dnRYUnozTXpIdzZTYlV0YUJtRTVXRUJ3MndPaHhmeEJyZ3lka3pxQlJtbDlU?=
 =?utf-8?B?eVRaamxvWjdLRWxqNEJlVGk5VXlsSnVLVXlxcS92b3d4Z2VpejJZaXZ1WDFz?=
 =?utf-8?B?V3VKdm5OWmljVHEvZm84ZDJhaFdpV1A4bUVZcis4NmpaMGtLU0s4eEFaTmV1?=
 =?utf-8?B?RXY5WXdYajNCSHNGZHlWR0RzSGxtMWNmL2I4cTVtT1BrdlBFRk1UbXh6MzVB?=
 =?utf-8?B?M2FBUkF1d1MvY2VQS2E0a3FiNGpqYmpCNEhFdzRaMkpOOXFXdjBDM0t4d0dB?=
 =?utf-8?B?eWdTVVZsOEVqWHNEWXNNbElJNVRzaU1xazRRSXRVN09GWnBEeHVtMTlvWEtj?=
 =?utf-8?B?RitEaEhMRkYwRmdISnpPYkJBOGx2cjRWaXRJOXB4b2ZmSlBzVEZYYlloOUlt?=
 =?utf-8?B?WGpaQ1FKUG1UaHAxRDBkS3pybkNrL0hHc1F6MEJFNng3QitvdFI5VVZEbmFX?=
 =?utf-8?B?MnJuKy96MVJDcW9td0c2aGtDZnB2VWttc2plcmZQU2RKeTFUY3h5dlY5Sm93?=
 =?utf-8?B?UTh0MjlVekZybjBrUEI4VjVOcEUydS9pNERQNFJaSjhHZ0R2OERCL1hCeGxS?=
 =?utf-8?B?QWZ3enlPRUJqTFFoZU1IMVBtSGFwYkxOcHdHdGJ5ejZzSlhxbWhBaFNMbi81?=
 =?utf-8?B?MmFBK2wxS05TbUJUc0kvU2J1OVZCWmpza1lsWldJY2JGMURGcHJMWWRLS01s?=
 =?utf-8?B?U2FsNGp3aFhnWDRmOVpoclVXdkQ0T0NCaWN4MlBuOUdCRnp5YTEyV2p6WU82?=
 =?utf-8?B?dE9RcVFOV3AxNFM5cFNnelpRZytuMGxQelFzSUMzV1l3b00wRXo4YStRMHFG?=
 =?utf-8?B?ZmxKZnNxRHlRVlZBUURpWitLejJyQS8yL1UxNVV0aTUrQkFydkRLL3g2SU9W?=
 =?utf-8?B?YXY3M05rRjB5bVlDM1gvT0hCOHdkQk43RHpVaWhVczFjV3FFNzZkdVl5eldQ?=
 =?utf-8?B?SUE5NVRPU0VYaGMzZS9iQ2hqcjZOVHFHWU5wcXpKcUFRMkdwcGt0OEk5QmJG?=
 =?utf-8?B?cC9TeUtrTjgwa0RZSHJDdFVyWEM5SmtUT0NOV1g2N1gzclFXL1paekRKTVpr?=
 =?utf-8?B?cFhralhucXphTklSZnNCbW0zdmpjZnB6Y21CNVpRMzRSMzR3akF0eWJwUUVu?=
 =?utf-8?B?bDBwYlNFTGl4Q0NPQ01mSU9mL3MxdmI3WFBDK2ZqdDBVRit2c1FmcWpKeFox?=
 =?utf-8?B?NDgwa1pLL1cxSHh5V2hqTDhnMXVqaHB3cUxlVUtWVkxWb3o5MGxpRWRkNE5P?=
 =?utf-8?B?L2UzYXFmdjhyTi9mREc0S3ZLMHVlTHpYRHJrclVCajY2MWEvT2RML3E1eG5o?=
 =?utf-8?B?V0hjYnkreGFiRFMxZ0M0Zk9YdGsvYklNUUxFN1N0dWNOeTR4aGZVUjlLbTRU?=
 =?utf-8?B?U2lQTkxwT05BcUhIZU4vT3RQQTZEc1dBZ1B4NVpVZG1EQmRJRFVCTU5menhQ?=
 =?utf-8?B?cndvVEhpNXdwbVFsT3RZRHVQa05uWFNqVXppM0ppZ2RCWnd0WEZ3WDExNUNC?=
 =?utf-8?B?OXlidEdnYXJ3N2ZZaStJV3RLY09FSXFqbnZlVU1PcTJiTnJvUlFBNWdRYm1p?=
 =?utf-8?B?YVI3bGVjTUdLYi90b1Z0VzlHcUt3OEpaQTh2bFhVZEJkdzFaUlVkMGlTYjhu?=
 =?utf-8?B?L2tCeld1eHhMRFZXWWc3b2RaTkxmYzZ3elYrbzF3UGpkekJNVllmNGM1ZVpM?=
 =?utf-8?B?azgxNlhyeVBjRVV5ZDJGbmk2Rkg3eDBZb0Ewa1NmY1J6U1h6M1ZheEJMWUpF?=
 =?utf-8?B?REluaGhhaG1mSC9mL3UrNU1mZzdaczVTKzFnbWlMV3duZW9DVjZXTEhnN1Vt?=
 =?utf-8?Q?h1hT9jyIhJBHS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aae1a43b-dcf2-4d43-d5ca-08d8feaa3eb6
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2021 18:30:42.4149 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2CE1+tjWKErX5G8IRqjgmgjAeOZl/tNu/6U3mKjHNNBrCDz6Bc11u2SsTvLmqsIRglHGvzkZ+Axzo8N8JIvzAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2397
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

Ck9uIDIwMjEtMDQtMTMgMjoyNSBwLm0uLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+Cj4KPiBB
bSAxMy4wNC4yMSB1bSAyMDoxOCBzY2hyaWViIEFuZHJleSBHcm9kem92c2t5Ogo+Pgo+PiBPbiAy
MDIxLTA0LTEzIDI6MDMgcC5tLiwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4+IEFtIDEzLjA0
LjIxIHVtIDE3OjEyIHNjaHJpZWIgQW5kcmV5IEdyb2R6b3Zza3k6Cj4+Pj4KPj4+PiBPbiAyMDIx
LTA0LTEzIDM6MTAgYS5tLiwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4+Pj4gQW0gMTIuMDQu
MjEgdW0gMjI6MDEgc2NocmllYiBBbmRyZXkgR3JvZHpvdnNreToKPj4+Pj4+Cj4+Pj4+PiBPbiAy
MDIxLTA0LTEyIDM6MTggcC5tLiwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4+Pj4+PiBBbSAx
Mi4wNC4yMSB1bSAyMToxMiBzY2hyaWViIEFuZHJleSBHcm9kem92c2t5Ogo+Pj4+Pj4+PiBbU05J
UF0KPj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+IFNvIHdoYXQncyB0aGUgcmlnaHQgYXBwcm9hY2ggPyBI
b3cgd2UgZ3VhcmFudGVlIHRoYXQgd2hlbiAKPj4+Pj4+Pj4+PiBydW5uaW5nIGFtZGdwdV9mZW5j
ZV9kcml2ZXJfZm9yY2VfY29tcGxldGlvbiB3ZSB3aWxsIHNpZ25hbCAKPj4+Pj4+Pj4+PiBhbGwg
dGhlIEhXIGZlbmNlcyBhbmQgbm90IHJhY2luZyBhZ2FpbnN0IHNvbWUgbW9yZSBmZW5jZXMgCj4+
Pj4+Pj4+Pj4gaW5zZXJ0aW9uIGludG8gdGhhdCBhcnJheSA/Cj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+
Cj4+Pj4+Pj4+PiBXZWxsIEkgd291bGQgc3RpbGwgc2F5IHRoZSBiZXN0IGFwcHJvYWNoIHdvdWxk
IGJlIHRvIGluc2VydCAKPj4+Pj4+Pj4+IHRoaXMgYmV0d2VlbiB0aGUgZnJvbnQgZW5kIGFuZCB0
aGUgYmFja2VuZCBhbmQgbm90IHJlbHkgb24gCj4+Pj4+Pj4+PiBzaWduYWxpbmcgZmVuY2VzIHdo
aWxlIGhvbGRpbmcgdGhlIGRldmljZSBzcmN1Lgo+Pj4+Pj4+Pgo+Pj4+Pj4+Pgo+Pj4+Pj4+PiBN
eSBxdWVzdGlvbiBpcywgZXZlbiBub3csIHdoZW4gd2UgcnVuIAo+Pj4+Pj4+PiBhbWRncHVfZmVu
Y2VfZHJpdmVyX2ZpbmlfaHctPmFtZGdwdV9mZW5jZV93YWl0X2VtcHR5IG9yIAo+Pj4+Pj4+PiBh
bWRncHVfZmVuY2VfZHJpdmVyX2ZpbmlfaHctPmFtZGdwdV9mZW5jZV9kcml2ZXJfZm9yY2VfY29t
cGxldGlvbiwgCj4+Pj4+Pj4+IHdoYXQgdGhlcmUgcHJldmVudHMgYSByYWNlIHdpdGggYW5vdGhl
ciBmZW5jZSBiZWluZyBhdCB0aGUgc2FtZSAKPj4+Pj4+Pj4gdGltZSBlbWl0dGVkIGFuZCBpbnNl
cnRlZCBpbnRvIHRoZSBmZW5jZSBhcnJheSA/IExvb2tzIGxpa2UgCj4+Pj4+Pj4+IG5vdGhpbmcu
Cj4+Pj4+Pj4+Cj4+Pj4+Pj4KPj4+Pj4+PiBFYWNoIHJpbmcgY2FuIG9ubHkgYmUgdXNlZCBieSBv
bmUgdGhyZWFkIGF0IHRoZSBzYW1lIHRpbWUsIHRoaXMgCj4+Pj4+Pj4gaW5jbHVkZXMgZW1pdHRp
bmcgZmVuY2VzIGFzIHdlbGwgYXMgb3RoZXIgc3R1ZmYuCj4+Pj4+Pj4KPj4+Pj4+PiBEdXJpbmcg
R1BVIHJlc2V0IHdlIG1ha2Ugc3VyZSBub2JvZHkgd3JpdGVzIHRvIHRoZSByaW5ncyBieSAKPj4+
Pj4+PiBzdG9wcGluZyB0aGUgc2NoZWR1bGVyIGFuZCB0YWtpbmcgdGhlIEdQVSByZXNldCBsb2Nr
IChzbyB0aGF0IAo+Pj4+Pj4+IG5vYm9keSBlbHNlIGNhbiBzdGFydCB0aGUgc2NoZWR1bGVyIGFn
YWluKS4KPj4+Pj4+Cj4+Pj4+Pgo+Pj4+Pj4gV2hhdCBhYm91dCBkaXJlY3Qgc3VibWlzc2lvbnMg
bm90IHRocm91Z2ggc2NoZWR1bGVyIC0gCj4+Pj4+PiBhbWRncHVfam9iX3N1Ym1pdF9kaXJlY3Qs
IEkgZG9uJ3Qgc2VlIGhvdyB0aGlzIGlzIHByb3RlY3RlZC4KPj4+Pj4KPj4+Pj4gVGhvc2Ugb25s
eSBoYXBwZW4gZHVyaW5nIHN0YXJ0dXAgYW5kIEdQVSByZXNldC4KPj4+Pgo+Pj4+Cj4+Pj4gT2ss
IGJ1dCB0aGVuIGxvb2tzIGxpa2UgSSBhbSBtaXNzaW5nIHNvbWV0aGluZywgc2VlIHRoZSBmb2xs
b3dpbmcgCj4+Pj4gc3RlcHMgaW4gYW1kZ3B1X3BjaV9yZW1vdmUgLQo+Pj4+Cj4+Pj4gMSkgVXNl
IGRpc2FibGVfaXJxIEFQSSBmdW5jdGlvbiB0byBzdG9wIGFuZCBmbHVzaCBhbGwgaW4gZmxpZ2h0
IEhXIAo+Pj4+IGludGVycnVwdHMgaGFuZGxlcnMKPj4+Pgo+Pj4+IDIpIEdyYWIgdGhlIHJlc2V0
IGxvY2sgYW5kIHN0b3AgYWxsIHRoZSBzY2hlZHVsZXJzCj4+Pj4KPj4+PiBBZnRlciBhYm92ZSAy
IHN0ZXBzIHRoZSBIVyBmZW5jZXMgYXJyYXkgaXMgaWRsZSwgbm8gbW9yZSBpbnNlcnRpb25zIAo+
Pj4+IGFuZCBubyBtb3JlIGV4dHJhY3Rpb25zIGZyb20gdGhlIGFycmF5Cj4+Pj4KPj4+PiAzKSBS
dW4gb25lIHRpbWUgYW1kZ3B1X2ZlbmNlX3Byb2Nlc3MgdG8gc2lnbmFsIGFsbCBjdXJyZW50IEhX
IGZlbmNlcwo+Pj4+Cj4+Pj4gNCkgU2V0IGRybV9kZXZfdW5wbHVnICh3aWxsICdmbHVzaCcgYWxs
IGluIGZsaWdodCBJT0NUTHMpLCByZWxlYXNlIAo+Pj4+IHRoZSBHUFUgcmVzZXQgbG9jayBhbmQg
Z28gb24gd2l0aCB0aGUgcmVzdCBvZiB0aGUgc2VxdWVuY2UgKGNhbmNlbCAKPj4+PiB0aW1lcnMs
IHdvcmsgaXRlbXMgZS50LmMpCj4+Pj4KPj4+PiBXaGF0J3MgcHJvYmxlbWF0aWMgaW4gdGhpcyBz
ZXF1ZW5jZSA/Cj4+Pgo+Pj4gZHJtX2Rldl91bnBsdWcoKSB3aWxsIHdhaXQgZm9yIHRoZSBJT0NU
THMgdG8gZmluaXNoLgo+Pj4KPj4+IFRoZSBJT0NUTHMgaW4gdHVybiBjYW4gd2FpdCBmb3IgZmVu
Y2VzLiBUaGF0IGNhbiBiZSBib3RoIGhhcmR3YXJlIAo+Pj4gZmVuY2VzLCBzY2hlZHVsZXIgZmVu
Y2VzLCBhcyB3ZWxsIGFzIGZlbmNlcyBmcm9tIG90aGVyIGRldmljZXMgKGFuZCAKPj4+IEtJUSBm
ZW5jZXMgZm9yIHJlZ2lzdGVyIHdyaXRlcyB1bmRlciBTUklPViwgYnV0IHdlIGNhbiBob3BlZnVs
bHkgCj4+PiBpZ25vcmUgdGhlbSBmb3Igbm93KS4KPj4+Cj4+PiBXZSBoYXZlIGhhbmRsZWQgdGhl
IGhhcmR3YXJlIGZlbmNlcywgYnV0IHdlIGhhdmUgbm8gaWRlYSB3aGVuIHRoZSAKPj4+IHNjaGVk
dWxlciBmZW5jZXMgb3IgdGhlIGZlbmNlcyBmcm9tIG90aGVyIGRldmljZXMgd2lsbCBzaWduYWwu
Cj4+Pgo+Pj4gU2NoZWR1bGVyIGZlbmNlcyB3b24ndCBzaWduYWwgdW50aWwgdGhlIHNjaGVkdWxl
ciB0aHJlYWRzIGFyZSAKPj4+IHJlc3RhcnRlZCBvciB3ZSBzb21laG93IGNhbmNlbCB0aGUgc3Vi
bWlzc2lvbnMuIERvYWJsZSwgYnV0IHRyaWNreSAKPj4+IGFzIHdlbGwuCj4+Cj4+Cj4+IEZvciBz
Y2hlZHVsZXIgZmVuY2VzIEkgYW0gbm90IHdvcnJpZWQsIGZvciB0aGUgc2NoZWRfZmVuY2UtPmZp
bmlzaGVkIAo+PiBmZW5jZSB0aGV5IGFyZSBieSBkZWZpbml0aW9uIGF0dGFjaGVkIHRvIEhXIGZl
bmNlcyB3aGljaCBhbHJlYWR5IAo+PiBzaWduYWxlZGZvciBzY2hlZF9mZW5jZS0+c2NoZWR1bGVk
IHdlIHNob3VsZCBydW4gCj4+IGRybV9zY2hlZF9lbnRpdHlfa2lsbF9qb2JzIGZvciBlYWNoIGVu
dGl0eSBhZnRlciBzdG9wcGluZyB0aGUgCj4+IHNjaGVkdWxlciB0aHJlYWRzIGFuZCBiZWZvcmUg
c2V0dGluZyBkcm1fZGV2X3VucGx1Zy4KPgo+IFdlbGwgZXhhY3RseSB0aGF0IGlzIHdoYXQgaXMg
dHJpY2t5IGhlcmUuIGRybV9zY2hlZF9lbnRpdHlfa2lsbF9qb2JzKCkgCj4gYXNzdW1lcyB0aGF0
IHRoZXJlIGFyZSBubyBtb3JlIGpvYnMgcHVzaGVkIGludG8gdGhlIGVudGl0eS4KPgo+IFdlIGFy
ZSByYWNpbmcgaGVyZSBvbmNlIG1vcmUgYW5kIG5lZWQgdG8gaGFuZGxlIHRoYXQuCgoKQnV0IHdo
eSwgSSB3cm90ZSBhYm92ZSB0aGF0IHdlIGZpcnN0IHN0b3AgdGhlIGFsbCBzY2hlZHVsZXJzLCB0
aGVuIG9ubHkgCmNhbGwgZHJtX3NjaGVkX2VudGl0eV9raWxsX2pvYnMuCgoKPgo+Pj4KPj4+IEZv
ciB3YWl0aW5nIGZvciBvdGhlciBkZXZpY2UgSSBoYXZlIG5vIGlkZWEgaWYgdGhhdCBjb3VsZG4n
dCAKPj4+IGRlYWRsb2NrIHNvbWVob3cuCj4+Cj4+Cj4+IFllYSwgbm90IHN1cmUgZm9yIGltcG9y
dGVkIGZlbmNlcyBhbmQgZG1hX2J1ZnMsIEkgd291bGQgYXNzdW1lIHRoZSAKPj4gb3RoZXIgZGV2
aWNlcyBzaG91bGQgbm90IGJlIGltcGFjdGVkIGJ5IG91ciBkZXZpY2UgcmVtb3ZhbCBidXQsIHdo
byAKPj4ga25vd3MuLi4KPj4KPj4gU28gSSBndWVzcyB3ZSBhcmUgTk9UIGdvaW5nIHdpdGggZmlu
YWxpemluZyBIVyBmZW5jZXMgYmVmb3JlIAo+PiBkcm1fZGV2X3VucGx1ZyBhbmQgaW5zdGVhZCB3
aWxsIGp1c3QgY2FsbCBkcm1fZGV2X2VudGVyL2V4aXQgYXQgdGhlIAo+PiBiYWNrLWVuZHMgYWxs
IG92ZXIgdGhlIHBsYWNlIHdoZXJlIHRoZXJlIGFyZSBNTUlPIGFjY2Vzc2VzID8KPgo+IEdvb2Qg
cXVlc3Rpb24uIEFzIHlvdSBzYWlkIHRoYXQgaXMgcmVhbGx5IHRoZSBoYXJkIHBhdGguCj4KPiBI
YW5kbGluZyBpdCBhbGwgYXQgb25jZSBhdCBJT0NUTCBsZXZlbCBjZXJ0YWlubHkgaGFzIHNvbWUg
YXBwZWFsIGFzIAo+IHdlbGwsIGJ1dCBJIGhhdmUgbm8gaWRlYSBpZiB3ZSBjYW4gZ3VhcmFudGVl
IHRoYXQgdGhpcyBpcyBsb2NrIGZyZWUuCgoKTWF5YmUganVzdCBlbXBpcmljYWxseSAtIGxldCdz
IHRyeSBpdCBhbmQgc2VlIHVuZGVyIGRpZmZlcmVudCB0ZXN0IApzY2VuYXJpb3Mgd2hhdCBhY3R1
YWxseSBoYXBwZW5zwqAgPwoKQW5kcmV5CgoKPgo+IENocmlzdGlhbi4KPgo+Pgo+PiBBbmRyZXkK
Pj4KPj4+Cj4+PiBSZWdhcmRzLAo+Pj4gQ2hyaXN0aWFuLgo+Pj4KPj4+Pgo+Pj4+IEFuZHJleQo+
Pj4+Cj4+Pj4KPj4+Pj4KPj4+Pj4KPj4+Pj4+Pgo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+IEJUVzogQ291
bGQgaXQgYmUgdGhhdCB0aGUgZGV2aWNlIFNSQ1UgcHJvdGVjdHMgbW9yZSB0aGFuIG9uZSAKPj4+
Pj4+Pj4+IGRldmljZSBhbmQgd2UgZGVhZGxvY2sgYmVjYXVzZSBvZiB0aGlzPwo+Pj4+Pj4+Pgo+
Pj4+Pj4+Pgo+Pj4+Pj4+PiBJIGhhdmVuJ3QgYWN0dWFsbHkgZXhwZXJpZW5jZWQgYW55IGRlYWRs
b2NrIHVudGlsIG5vdyBidXQsIHllcywgCj4+Pj4+Pj4+IGRybV91bnBsdWdfc3JjdSBpcyBkZWZp
bmVkIGFzIHN0YXRpYyBpbiBkcm1fZHJ2LmMgYW5kIHNvIGluIHRoZSAKPj4+Pj4+Pj4gcHJlc2Vu
Y2XCoCBvZiBtdWx0aXBsZSBkZXZpY2VzIGZyb20gc2FtZSBvciBkaWZmZXJlbnQgZHJpdmVycyB3
ZSAKPj4+Pj4+Pj4gaW4gZmFjdCBhcmUgZGVwZW5kZW50IG9uIGFsbCB0aGVpciBjcml0aWNhbCBz
ZWN0aW9ucyBpIGd1ZXNzLgo+Pj4+Pj4+Pgo+Pj4+Pj4+Cj4+Pj4+Pj4gU2hpdCwgeWVhaCB0aGUg
ZGV2aWwgaXMgYSBzcXVpcnJlbC4gU28gZm9yIEErSSBsYXB0b3BzIHdlIAo+Pj4+Pj4+IGFjdHVh
bGx5IG5lZWQgdG8gc3luYyB0aGF0IHVwIHdpdGggRGFuaWVsIGFuZCB0aGUgcmVzdCBvZiB0aGUg
Cj4+Pj4+Pj4gaTkxNSBndXlzLgo+Pj4+Pj4+Cj4+Pj4+Pj4gSUlSQyB3ZSBjb3VsZCBhY3R1YWxs
eSBoYXZlIGFuIGFtZGdwdSBkZXZpY2UgaW4gYSBkb2NraW5nIAo+Pj4+Pj4+IHN0YXRpb24gd2hp
Y2ggbmVlZHMgaG90cGx1ZyBhbmQgdGhlIGRyaXZlciBtaWdodCBkZXBlbmQgb24gCj4+Pj4+Pj4g
d2FpdGluZyBmb3IgdGhlIGk5MTUgZHJpdmVyIGFzIHdlbGwuCj4+Pj4+Pgo+Pj4+Pj4KPj4+Pj4+
IENhbid0IHdlIHByb3Bvc2UgYSBwYXRjaCB0byBtYWtlIGRybV91bnBsdWdfc3JjdSBwZXIgZHJt
X2RldmljZSA/IAo+Pj4+Pj4gSSBkb24ndCBzZWUgd2h5IGl0IGhhcyB0byBiZSBnbG9iYWwgYW5k
IG5vdCBwZXIgZGV2aWNlIHRoaW5nLgo+Pj4+Pgo+Pj4+PiBJJ20gcmVhbGx5IHdvbmRlcmluZyB0
aGUgc2FtZSB0aGluZyBmb3IgcXVpdGUgYSB3aGlsZSBub3cuCj4+Pj4+Cj4+Pj4+IEFkZGluZyBE
YW5pZWwgYXMgd2VsbCwgbWF5YmUgaGUga25vd3Mgd2h5IHRoZSBkcm1fdW5wbHVnX3NyY3UgaXMg
Cj4+Pj4+IGdsb2JhbC4KPj4+Pj4KPj4+Pj4gUmVnYXJkcywKPj4+Pj4gQ2hyaXN0aWFuLgo+Pj4+
Pgo+Pj4+Pj4KPj4+Pj4+IEFuZHJleQo+Pj4+Pj4KPj4+Pj4+Cj4+Pj4+Pj4KPj4+Pj4+PiBDaHJp
c3RpYW4uCj4+Pj4+Pj4KPj4+Pj4+Pj4gQW5kcmV5Cj4+Pj4+Pj4+Cj4+Pj4+Pj4+Cj4+Pj4+Pj4+
Pgo+Pj4+Pj4+Pj4gQ2hyaXN0aWFuLgo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+PiBBbmRyZXkKPj4+Pj4+
Pj4+Pgo+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+PiBBbmRyZXkKPj4+Pj4+Pj4+
Pj4+Cj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4gQ2hyaXN0aWFuLgo+
Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+IMKgwqDCoCAvKiBQYXN0IHRoaXMgcG9pbnQgbm8g
bW9yZSBmZW5jZSBhcmUgc3VibWl0dGVkIHRvIEhXIAo+Pj4+Pj4+Pj4+Pj4+PiByaW5nIGFuZCBo
ZW5jZSB3ZSBjYW4gc2FmZWx5IGNhbGwgZm9yY2Ugc2lnbmFsIG9uIGFsbCAKPj4+Pj4+Pj4+Pj4+
Pj4gdGhhdCBhcmUgY3VycmVudGx5IHRoZXJlLgo+Pj4+Pj4+Pj4+Pj4+PiDCoMKgwqDCoCAqIEFu
eSBzdWJzZXF1ZW50bHkgY3JlYXRlZMKgIEhXIGZlbmNlcyB3aWxsIGJlIAo+Pj4+Pj4+Pj4+Pj4+
PiByZXR1cm5lZCBzaWduYWxlZCB3aXRoIGFuIGVycm9yIGNvZGUgcmlnaHQgYXdheQo+Pj4+Pj4+
Pj4+Pj4+PiDCoMKgwqDCoCAqLwo+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+PiDCoMKgwqAg
Zm9yX2VhY2hfcmluZyhhZGV2KQo+Pj4+Pj4+Pj4+Pj4+PiDCoMKgwqAgwqDCoMKgIGFtZGdwdV9m
ZW5jZV9wcm9jZXNzKHJpbmcpCj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+IMKgwqDCoCBk
cm1fZGV2X3VucGx1ZyhkZXYpOwo+Pj4+Pj4+Pj4+Pj4+PiDCoMKgwqAgU3RvcCBzY2hlZHVsZXJz
Cj4+Pj4+Pj4+Pj4+Pj4+IMKgwqDCoCBjYW5jZWxfc3luYyhhbGwgdGltZXJzIGFuZCBxdWV1ZWQg
d29ya3MpOwo+Pj4+Pj4+Pj4+Pj4+PiDCoMKgwqAgaHdfZmluaQo+Pj4+Pj4+Pj4+Pj4+PiDCoMKg
wqAgdW5tYXBfbW1pbwo+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+PiB9Cj4+Pj4+Pj4+Pj4+
Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+IEFuZHJleQo+Pj4+Pj4+Pj4+Pj4+Pgo+
Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+
Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+IEFsdGVybmF0aXZl
bHkgZ3JhYmJpbmcgdGhlIHJlc2V0IHdyaXRlIHNpZGUgYW5kIAo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+
IHN0b3BwaW5nIGFuZCB0aGVuIHJlc3RhcnRpbmcgdGhlIHNjaGVkdWxlciBjb3VsZCAKPj4+Pj4+
Pj4+Pj4+Pj4+Pj4+PiB3b3JrIGFzIHdlbGwuCj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+
Pj4+Pj4+Pj4+PiBDaHJpc3RpYW4uCj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+
Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+IEkgZGlkbid0IGdldCB0aGUgYWJvdmUgYW5kIEkgZG9uJ3Qg
c2VlIHdoeSBJIG5lZWQgdG8gCj4+Pj4+Pj4+Pj4+Pj4+Pj4+PiByZXVzZSB0aGUgR1BVIHJlc2V0
IHJ3X2xvY2suIEkgcmVseSBvbiB0aGUgU1JDVSAKPj4+Pj4+Pj4+Pj4+Pj4+Pj4+IHVucGx1ZyBm
bGFnIGZvciB1bnBsdWcuIEFsc28sIG5vdCBjbGVhciB0byBtZSB3aHkgYXJlIAo+Pj4+Pj4+Pj4+
Pj4+Pj4+Pj4gd2UgZm9jdXNpbmcgb24gdGhlIHNjaGVkdWxlciB0aHJlYWRzLCBhbnkgY29kZSBw
YXRjaCAKPj4+Pj4+Pj4+Pj4+Pj4+Pj4+IHRvIGdlbmVyYXRlIEhXIGZlbmNlcyBzaG91bGQgYmUg
Y292ZXJlZCwgc28gYW55IGNvZGUgCj4+Pj4+Pj4+Pj4+Pj4+Pj4+PiBsZWFkaW5nIHRvIGFtZGdw
dV9mZW5jZV9lbWl0IG5lZWRzIHRvIGJlIHRha2VuIGludG8gCj4+Pj4+Pj4+Pj4+Pj4+Pj4+PiBh
Y2NvdW50IHN1Y2ggYXMsIGRpcmVjdCBJQiBzdWJtaXNzaW9ucywgVk0gZmx1c2hlcyBlLnQuYwo+
Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+PiBZb3UgbmVlZCB0byB3b3JrIHRvZ2V0
aGVyIHdpdGggdGhlIHJlc2V0IGxvY2sgYW55d2F5LCAKPj4+Pj4+Pj4+Pj4+Pj4+Pj4gY2F1c2Ug
YSBob3RwbHVnIGNvdWxkIHJ1biBhdCB0aGUgc2FtZSB0aW1lIGFzIGEgcmVzZXQuCj4+Pj4+Pj4+
Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+IEZvciBnb2luZyBteSB3
YXkgaW5kZWVkIG5vdyBJIHNlZSBub3cgdGhhdCBJIGhhdmUgdG8gCj4+Pj4+Pj4+Pj4+Pj4+Pj4g
dGFrZSByZXNldCB3cml0ZSBzaWRlIGxvY2sgZHVyaW5nIEhXIGZlbmNlcyBzaWduYWxsaW5nIAo+
Pj4+Pj4+Pj4+Pj4+Pj4+IGluIG9yZGVyIHRvIHByb3RlY3QgYWdhaW5zdCBzY2hlZHVsZXIvSFcg
ZmVuY2VzIAo+Pj4+Pj4+Pj4+Pj4+Pj4+IGRldGFjaG1lbnQgYW5kIHJlYXR0YWNobWVudCBkdXJp
bmcgc2NoZWR1bGVycyAKPj4+Pj4+Pj4+Pj4+Pj4+PiBzdG9wL3Jlc3RhcnQuIEJ1dCBpZiB3ZSBn
byB3aXRoIHlvdXIgYXBwcm9hY2jCoCB0aGVuIAo+Pj4+Pj4+Pj4+Pj4+Pj4+IGNhbGxpbmcgZHJt
X2Rldl91bnBsdWcgYW5kIHNjb3BpbmcgYW1kZ3B1X2pvYl90aW1lb3V0IAo+Pj4+Pj4+Pj4+Pj4+
Pj4+IHdpdGggZHJtX2Rldl9lbnRlci9leGl0IHNob3VsZCBiZSBlbm91Z2ggdG8gcHJldmVudCBh
bnkgCj4+Pj4+Pj4+Pj4+Pj4+Pj4gY29uY3VycmVudCBHUFUgcmVzZXRzIGR1cmluZyB1bnBsdWcu
IEluIGZhY3QgSSBhbHJlYWR5IAo+Pj4+Pj4+Pj4+Pj4+Pj4+IGRvIGl0IGFueXdheSAtIAo+Pj4+
Pj4+Pj4+Pj4+Pj4+IGh0dHBzOi8vbmFtMTEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5j
b20vP3VybD1odHRwczolMkYlMkZjZ2l0LmZyZWVkZXNrdG9wLm9yZyUyRn5hZ3JvZHpvdiUyRmxp
bnV4JTJGY29tbWl0JTJGJTNGaCUzRGRybS1taXNjLW5leHQlMjZpZCUzRGVmMGVhNGRkMjllZjQ0
ZDI2NDljNWVkYTE2YzhmNDg2OWFjYzM2YjEmYW1wO2RhdGE9MDQlN0MwMSU3Q2FuZHJleS5ncm9k
em92c2t5JTQwYW1kLmNvbSU3Q2M3ZmM2Y2I1MDVjMzRhZWRmZTZkMDhkOGZlNGIzOTQ3JTdDM2Rk
ODk2MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzUzODk0NjMyNDg1NzM2
OSU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJs
dU16SWlMQ0pCVGlJNklrMWhhV3dpTENKWFZDSTZNbjAlM0QlN0MxMDAwJmFtcDtzZGF0YT02NDM2
MlBSQzh4VGdSMlVqMlIyNTZiTWVnVm04WVdxMUtJJTJCQWp6ZVlYdjQlM0QmYW1wO3Jlc2VydmVk
PTAgCj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+PiBZZXMs
IGdvb2QgcG9pbnQgYXMgd2VsbC4KPj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+PiBDaHJp
c3RpYW4uCj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4g
QW5kcmV5Cj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+
Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+PiBDaHJpc3RpYW4uCj4+Pj4+Pj4+
Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gQW5kcmV5Cj4+
Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+
Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+PiBDaHJpc3RpYW4uCj4+Pj4+
Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+
Pj4gQW5kcmV5Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+
Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+PiBBbmRyZXkKPj4+Pj4+
Pj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+
Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+
Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4+Cj4+Pj4+
Pj4+Pgo+Pj4+Pj4+Cj4+Pj4+Cj4+Pgo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmFtZC1nZnggbWFpbGluZyBsaXN0CmFtZC1nZnhAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8v
YW1kLWdmeAo=
