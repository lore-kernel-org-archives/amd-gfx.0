Return-Path: <SRS0=uqvu=KN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C34EC433ED
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 18:18:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A82D61059
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 18:18:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A82D61059
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D2F46EC6A;
	Tue, 18 May 2021 18:18:39 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6887C6EC6A
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 May 2021 18:18:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LrmKfFEK0F1YNaFuZcHgiaPJNS85pAqVXhu2GhbVBA87IWJoR4DQOFp8rxPqTNBmzoVGzovVKyGH1fEprwolxIsBOwnILD/e78cDFJ3abCnBLrifd3N7e9sTJKyEfk73TVZTLkhyt/DYB/n7v6/agVLRrlhtnrm4X+dbbKXTBQ+tmRYBHdAxpfn8oWA0G8z1nIEYM8NRNAohgPUF0xSBvoKk/dLqDJcxnI0QqihQwK1yFKA3StCIGve+nEHcQeqZeyXZkOVCWxOm3kPu1MROBpHDlBIaa4j0/7dym3eJqV4afmvJfLbsRr16wFbLCJRsrCtOMt9i+MJGYEg06yj/jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bssnD/ap6NiJx0ijYg5hGUfTEIb67aGnkFvvEpdGC8s=;
 b=MT07ypGGhJnq3wRDWLTaJELWBg7PxdQorBlKiCy+fhFEcg2vT86V0ifnZoCCvkU5gLLiToHdBmUkT/aHfgx8hlUjKKuMBn+iitxA/f25lGs+EeiBUVSnd4JgwUmvcM2uFDRzxfeDwFOxfoE+AvL0NeztWL+5ffP/biw7Vf34nITI6sCM1oZUNrNf6yLmtH2kr/O732nVbf1Kg9EiGRtB3AD2oYyozQ02RS1SxpCB2hjlqIEkSuqu42blRHGvlfc3SSEo/kICIefp/qhJImQE0G0nv4Ke7fBPCvdnOMcr2f3cMqrCGR6XbtqN/3bx0gK97immFnhfywj7kONAoe+LgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bssnD/ap6NiJx0ijYg5hGUfTEIb67aGnkFvvEpdGC8s=;
 b=zoi3vf+1W3NeYcZ78B1jihQfkPkOWUUq6VZaExVjjpJJaJzFMZqsr97oAdqCGmYj06z3Wx1eAcf53cVERjXedYuroCKsLHitTO38rKI+wMPOM7fhB8s0ncYByZvq30RrtL1OLc3KtXHfdpjDNoLTlqQAxXSoOAbdbn9s4Vp7Vhc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) by
 DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.26; Tue, 18 May 2021 18:18:35 +0000
Received: from DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::8d83:baf6:c6c6:9ac3]) by DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::8d83:baf6:c6c6:9ac3%3]) with mapi id 15.20.4129.032; Tue, 18 May 2021
 18:18:35 +0000
Subject: Re: [PATCH] drm/amdgpu/vcn1: add cancel_delayed_work_sync before
 power gate
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
References: <1621350686-25923-1-git-send-email-James.Zhu@amd.com>
 <352509e8-a836-f803-fbda-e31e0283dc41@gmail.com>
 <af3751e7-c65b-b1d2-ac84-d88509ad9e31@amd.com>
 <bc35c564-0b25-3e9d-7bf7-04762405f640@gmail.com>
 <f2f9cd8e-2ed5-9b6f-6fd7-ee523c493061@amd.com>
 <efcc2430-836b-7fcd-71f9-b2ba45258177@gmail.com>
 <fb1e33bf-b597-baef-b7fe-094c8128f4c5@amd.com>
 <c2262f26-b83c-1290-a19e-fdb4905b2411@gmail.com>
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
Message-ID: <14cb4bcd-ae30-3377-834b-3d7746e60b2d@amd.com>
Date: Tue, 18 May 2021 14:18:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <c2262f26-b83c-1290-a19e-fdb4905b2411@gmail.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTXPR0101CA0048.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::25) To DM5PR12MB2517.namprd12.prod.outlook.com
 (2603:10b6:4:bb::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.230.192] (165.204.55.251) by
 YTXPR0101CA0048.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.30 via Frontend
 Transport; Tue, 18 May 2021 18:18:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be4d9271-a911-46e2-ea9f-08d91a295a03
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4202B6D0E503838DC300EA21E42C9@DM6PR12MB4202.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: imkkepeTIaaX2oFXF/JNPQYAqyzAVKPUSrizd9dAuyjZGriK/SwYVQI1FgxnNMMOjpgOZ1TLt/Hx3R+t9eW3mW3Sfhp3WsXzn+LdsGStWNsNCdquuiE/ZnQL3hfj6aldK0t0tBy4JpRstYMGma1J9wAa7TS5sVClnQCauf2dTNBzVNma6fT4P4FW1XYdvCGbtG3TU8WlJjiJezftqe1nWZSB+4owX1OrbhEG7JEJtG2DdOrVH048UkQbpoL5kmAoeDFRCfoSuGC7Sx9305EDY88MHihNpefOcVftM7+pYfn9noPDGR5QZ1BUQHiyAYx4YVmJLxyH7xhiVHTt3UjdbgS+he/qE8R4zYA8jrXVdOG3ITAQqDqEhOAqwAaOgMlT79WgccNbjkliFFu5d8u08FpjK5qSs/NTGo/LZ6kFos9FrwMNtRhCKeB2J0Z9MxFi4/odKmRz7PvACHvTzHKFBgA0gy3V4daPzW7b6jiI5dWFJJlED+p7/CMnG495rVE22b8sKtHdYelHB+AqeKfiHVQM0HuBR/IoHGZI+dD/8RJ7yWdH1H+QdPcV5MpLnn/bi5irYRo9J293So3A26jiyh1/MPv5xALFHrC5NrfLpXe0k923ieJ+w602uTJLDBPH2qU/ZS56vOwKr6fulKylQIENLna36i1/5UmO7cgFjXainhAzchj9AitYtuMWcUB3Z2ZGNJTb67l2OMcA+r1BgXXMmmSlvjP11wxfARdjrwg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(136003)(346002)(376002)(396003)(366004)(53546011)(478600001)(5660300002)(16526019)(2616005)(31696002)(110136005)(16576012)(956004)(186003)(316002)(66574015)(52116002)(66946007)(36916002)(66556008)(66476007)(36756003)(8936002)(38350700002)(26005)(6486002)(38100700002)(83380400001)(2906002)(8676002)(31686004)(3714002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cjBoOG91NUVDam9hdlV4MUlyeVd3enJpYnNVK1A3dWV1TlhPUDFsbWtHMEFm?=
 =?utf-8?B?anIzOFBoZGRMWWIrNXkzR3BKVmx5TW1wQ2cvbGQ4Vk5RWm9jR3pZNlBwU2NV?=
 =?utf-8?B?ZUtxQkNWcG5aM0xYNDB1d0xoU3o3NVVENjU4cUlzYkZRVUtVTm53Um82eURP?=
 =?utf-8?B?NUZaSGJPdEs4RWJXTzl1STliOG9VOUxrT0F4dEY0ZEVmQWRTYkZxV1ZQUUQv?=
 =?utf-8?B?dk5jd1hvZ0JuZTFJNU53dUc5bXdRY2orcEtYbDArNDlHL1JEYklLY3lZNDJR?=
 =?utf-8?B?NnUyeDFnanZkZE0ycDBRVktnZE5uRFZ3UEV1cVpuS1NzemdVT2VSUm9iTFVq?=
 =?utf-8?B?M1hsYTlzSlppYlhlWG5nVDVYa3RYT29ON0JndFR6bVNVTkxOaS9vMXVUZzdZ?=
 =?utf-8?B?TzUrYkE3UkFQd040RTRLazhUazhWQ1NJb3BQbmFhRXN3OFhzWWMrNjZhS0ll?=
 =?utf-8?B?MWt5OFMzWE1uU3FURE5jcjBYeWVMT2I3NFZlZ3NhVmtLdVRWWUxzNlVmbFYx?=
 =?utf-8?B?ZTJtNkpqdlZTSStEbGZJZDhiRkVrcWdxRWlhZGRtY2JaZ3cvUFQ3ZHI1aGVQ?=
 =?utf-8?B?K2JGTm44Z043MDA0ZjRmT01mRXhGWldvQ0F3QVhSZDB4ZHhHeENiTEpON3Fm?=
 =?utf-8?B?WWJYanJ2ZXd0RUl6V1pYeldUSUNKVy9CYmlpeHA0UzRRUHpXYmJCOXkxTlFn?=
 =?utf-8?B?MXBqMW9TMlRKdlNtNnY1bi9qMlduejh3S08wV1lQSFREdnR5VjFQNmRLTks3?=
 =?utf-8?B?WEhnSGtjMk53L0dCSFZGanViNzVDNGF0UldpdERBck4rNktMZWFWQ1U3SWF6?=
 =?utf-8?B?L2RCWUk0WjdKM2VXQktvUzA2dWxLSFRuTUJDSXo2NFVNR0dRYTU2eVdOaTN2?=
 =?utf-8?B?ZjNGYkNUZjlSTnh5VXVXSTBvajA5eGVNdzZTaXlJY3BEQXpoR0E4ODJKZTFS?=
 =?utf-8?B?OFBtTlUzSVFOYVRBWElUOGlyakFGdGpDY2gvbHV2UStGd3JaVldybjZETzZm?=
 =?utf-8?B?UGZqVmhpVFdWVEtRc1Y1dlluVzJKUnZuWGh4d2Q0Tm5wSWdoTExjQkx2ek5U?=
 =?utf-8?B?MFRRSFYxTDNBcE9OUVh5enc1a2NIaENoZnFRaWVGOUw0azF4QU9veHZPN05W?=
 =?utf-8?B?WHVWNGpid25sd3pEMk11LzVlTGRDZkpTNWY1V2hXUzBDQjVySlM4bkJMa2dt?=
 =?utf-8?B?YVJMT0k0RnptcTlKUjFjbzhia3FRb3hEQlZKQnZoSXVJZHpkWll5cGJaRUZv?=
 =?utf-8?B?VDJnNTVJdWxQNlFhRkpRcSsraXVIWXdiVkNIcmRRMFVEYXVOWVJkaDE5UEdh?=
 =?utf-8?B?eVBES3RxNVhkSEkwRk1sOG9BNDBGZ1pobjJtRklUMDRGbUhSMkpoODVnb3RP?=
 =?utf-8?B?VXJvK1E4bW1LVVM2cnlPT095OEVFMHVkUGpqYnM2WVJReWhGYU9waGlXK3Bk?=
 =?utf-8?B?YzV0d1BNV0lZODlET0Z1T0dIajMvRUg1dk1WMG5OZ2RFc1pTMUdKbmo5enVY?=
 =?utf-8?B?YmIxbHNCaXJIcGVMREwyUksrRUZGTVFCa3RuTENEeG9yVzhKeGdjbklmR3lH?=
 =?utf-8?B?VDlONUNvRjFlUS90NFY5VmIrbCtLSDF6ZFFJb2RVeDJHVzU0dmc1KzhyeFJF?=
 =?utf-8?B?bitHZGV3TkJDYmVlVjJjT0YyRFhIU3BtSGVoSU1jUWI1emN5cFNHT1R5Z2d2?=
 =?utf-8?B?RXF6aDRRbm5pMXZRRVJYajdMVzBSTXdTRzkycU1sek9iWWJUZk95ckRScXph?=
 =?utf-8?Q?TOMkYFCrdJlIMURmiriyD9mBb8gNtVM9hTyfrS9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be4d9271-a911-46e2-ea9f-08d91a295a03
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2021 18:18:35.7282 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yqdgkgsdAaocaTV9xgyj1SJ7QNXX5ai4LmXSYUv4e7H5K9io7C/jIDykBsVM+Mqf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4202
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

Ck9uIDIwMjEtMDUtMTggMjowNiBwLm0uLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+IEFtIDE4
LjA1LjIxIHVtIDE5OjA0IHNjaHJpZWIgSmFtZXMgWmh1Ogo+Pgo+PiBPbiAyMDIxLTA1LTE4IDEy
OjM2IHAubS4sIENocmlzdGlhbiBLw7ZuaWcgd3JvdGU6Cj4+PiBBbSAxOC4wNS4yMSB1bSAxNzo1
OSBzY2hyaWViIEphbWVzIFpodToKPj4+Pgo+Pj4+IE9uIDIwMjEtMDUtMTggMTE6NTQgYS5tLiwg
Q2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPj4+Pj4KPj4+Pj4KPj4+Pj4gQW0gMTguMDUuMjEgdW0g
MTc6NDUgc2NocmllYiBKYW1lcyBaaHU6Cj4+Pj4+Pgo+Pj4+Pj4gT24gMjAyMS0wNS0xOCAxMToy
MyBhLm0uLCBDaHJpc3RpYW4gS8O2bmlnIHdyb3RlOgo+Pj4+Pj4+IEFtIDE4LjA1LjIxIHVtIDE3
OjExIHNjaHJpZWIgSmFtZXMgWmh1Ogo+Pj4+Pj4+PiBBZGQgY2FuY2VsX2RlbGF5ZWRfd29ya19z
eW5jIGJlZm9yZSBzZXQgcG93ZXIgZ2F0aW5nIHN0YXRlCj4+Pj4+Pj4+IHRvIGF2b2lkIHJhY2Ug
Y29uZGl0aW9uIGlzc3VlIHdoZW4gcG93ZXIgZ2F0aW5nLgo+Pj4+Pj4+Pgo+Pj4+Pj4+PiBTaWdu
ZWQtb2ZmLWJ5OiBKYW1lcyBaaHUgPEphbWVzLlpodUBhbWQuY29tPgo+Pj4+Pj4+PiAtLS0KPj4+
Pj4+Pj4gwqAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvdmNuX3YxXzAuYyB8IDE5ICsrKysr
KysrKysrKysrKysrKy0KPj4+Pj4+Pj4gwqAgMSBmaWxlIGNoYW5nZWQsIDE4IGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb24oLSkKPj4+Pj4+Pj4KPj4+Pj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92MV8wLmMgCj4+Pj4+Pj4+IGIvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvdmNuX3YxXzAuYwo+Pj4+Pj4+PiBpbmRleCAwYzFiZWVmLi42YzVjMDgzIDEw
MDY0NAo+Pj4+Pj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS92Y25fdjFfMC5j
Cj4+Pj4+Pj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L3Zjbl92MV8wLmMKPj4+
Pj4+Pj4gQEAgLTIzMCwxMCArMjMwLDI3IEBAIHN0YXRpYyBpbnQgdmNuX3YxXzBfaHdfaW5pdCh2
b2lkICpoYW5kbGUpCj4+Pj4+Pj4+IMKgIHN0YXRpYyBpbnQgdmNuX3YxXzBfaHdfZmluaSh2b2lk
ICpoYW5kbGUpCj4+Pj4+Pj4+IMKgIHsKPj4+Pj4+Pj4gwqDCoMKgwqDCoCBzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqYWRldiA9IChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqKWhhbmRsZTsKPj4+Pj4+Pj4g
K8KgwqDCoCBzdHJ1Y3QgYW1kZ3B1X3JpbmcgKnJpbmc7Cj4+Pj4+Pj4+ICvCoMKgwqAgaW50IGk7
Cj4+Pj4+Pj4+ICsKPj4+Pj4+Pj4gK8KgwqDCoCByaW5nID0gJmFkZXYtPnZjbi5pbnN0LT5yaW5n
X2RlYzsKPj4+Pj4+Pj4gK8KgwqDCoCByaW5nLT5zY2hlZC5yZWFkeSA9IGZhbHNlOwo+Pj4+Pj4+
PiArCj4+Pj4+Pj4+ICvCoMKgwqAgZm9yIChpID0gMDsgaSA8IGFkZXYtPnZjbi5udW1fZW5jX3Jp
bmdzOyArK2kpIHsKPj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIHJpbmcgPSAmYWRldi0+dmNuLmlu
c3QtPnJpbmdfZW5jW2ldOwo+Pj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgcmluZy0+c2NoZWQucmVh
ZHkgPSBmYWxzZTsKPj4+Pj4+Pj4gK8KgwqDCoCB9Cj4+Pj4+Pj4+ICsKPj4+Pj4+Pj4gK8KgwqDC
oCByaW5nID0gJmFkZXYtPmpwZWcuaW5zdC0+cmluZ19kZWM7Cj4+Pj4+Pj4+ICvCoMKgwqAgcmlu
Zy0+c2NoZWQucmVhZHkgPSBmYWxzZTsKPj4+Pj4+Pgo+Pj4+Pj4+IFRoaW5raW5nIG1vcmUgYWJv
dXQgdGhhdCB0aGlzIGlzIGEgcmVhbGx5IGJpZyBOQUsuIFRoZSBzY2hlZHVsZXIgCj4+Pj4+Pj4g
dGhyZWFkcyBtdXN0IHRvIHN0YXkgcmVhZHkgZHVyaW5nIGEgcmVzZXQuCj4+Pj4+Pj4KPj4+Pj4+
PiBUaGlzIGlzIGNvbnRyb2xsZWQgYnkgdGhlIHVwcGVyIGxheWVyIGFuZCBzaG91bGRuJ3QgYmUg
bWVzc2VkIAo+Pj4+Pj4+IHdpdGggaW4gdGhlIGhhcmR3YXJlIHNwZWNpZmljIGJhY2tlbmQgYXQg
YWxsLgo+Pj4+Pj4KPj4+Pj4+PiBbSlpdIEkgcG9ydGVkIHRoaXMgZnJvbSBjdXJyZW50IHZjbjMg
aHdfZmluaS4gSnVzdCB3YW50IHRvIG1ha2UgCj4+Pj4+Pj4gc3VyZSB0aGF0IG5vIG1vcmUgbmV3
IGpvYnMgd2lsbCBiZSBzY2hlZHVsZWQgYWZ0ZXIgc3VzcGVuZCAKPj4+Pj4+PiBwcm9jZXNzIHN0
YXJ0cy4KPj4+Pj4+IEl0IG1heSBhIHJlZHVuZGFuY3ksIHNpbmNlIHNjaGVkdWxlciBtYXliZSBh
bHJlYWR5IHN1c3BlbmQuIEkgY2FuIAo+Pj4+Pj4gcmVtb3ZlIHRob3NlIGlmIHlvdSBhcmUgc3Vy
ZSBubyBzaWRlIGVmZmVjdCwKPj4+Pj4KPj4+Pj4gV2VsbCwgd2UgKm11c3QqIHJlbW92ZSB0aG9z
ZS4gVGhpcyBmbGFnIGNvbnRyb2xzIGlmIHRoZSBoYXJkd2FyZSAKPj4+Pj4gZW5naW5lIGNhbiBi
ZSB1c2VkIGZvciBjb21tYW5kIHN1Ym1pc3Npb24gYW5kIGlzIG9ubHkgYmUgc2V0IHRvIAo+Pj4+
PiB0cnVlL2ZhbHNlIGR1cmluZyBpbml0aWFsIGRyaXZlciBsb2FkLgo+Pj4+Pgo+Pj4+PiBJZiB5
b3UgY2hhbmdlIGl0IHRvIGZhbHNlIGR1cmluZyBod19maW5pIHRoZSBlbmdpbmUgd29uJ3Qgd29y
ayAKPj4+Pj4gY29ycmVjdGx5IGFueSBtb3JlIGFmdGVyIEdQVSByZXNldCBvciByZXN1bWUuCj4+
Pj4gW0paXSBJZiBJIHJlY2FsbGVkIGNvcnJlY3RseSB0YXQgaHdfaW5pdCB3aWxsIGJlIGNhbGxl
ZCBldmVyeSB0aW1lIAo+Pj4+IGFmdGVyIEdQVSByZXNldCBvciBzdXNwZW5kL3Jlc3VtZSwKPj4+
Cj4+PiBZZXMgdGhhdCdzIGNvcnJlY3QuCj4+Pgo+Pj4gQnV0IGJlZm9yZSB0aGF0IGFuZCBkdXJp
bmcgR1BVIHJlc2V0IHRoZSByZWFkeSBmbGFnIGlzIHRoZW4gZmFsc2UgCj4+PiBmb3IgYSBzaG9y
dCBwZXJpb2Qgb2YgdGltZSB3aGljaCB3b3VsZCByZXN1bHQgaW4gdXNlcnNwYWNlIAo+Pj4gYXBw
bGljYXRpb25zIGNyYXNoaW5nIHdoZW4gdGhleSB0cnkgdG8gc3VibWl0IHNvbWV0aGluZy4KPj4g
W0paXcKgIEFwcGxpY2F0aW9uIHNob3VsZCBoYW5kbGUgc2l0dWF0aW9uIHdoZW4gc3VibWlzc2lv
biBmYWlsZWQgCj4+IHdpdGhvdXQgY3Jhc2guTWF5YmUgZHJpdmVyIHNob3VsZCByZXR1cm4gLUVB
R0FJTiB0byBhc2sgYXBwbGljYXRpb24gCj4+IHRvIHN1Ym1pdCBqb2IgbGF0ZXIgd2hlbiBncHUg
aXMgdW5kZXIgcmVzZXQvc3VzcGVuZC1yZXN1bWUuCj4KPiBObywgYnkgZGVzaWduIGRyaXZlciBz
aG91bGQgYWx3YXlzIGJlIGFibGUgdG8gYWNjZXB0IGpvYnMgZXhjZXB0IGZvciAKPiB0aGUgY2Fz
ZSB3aGVuIHRoZSBoYXJkd2FyZSBpcyB1bnJlY292ZXJhYmxlIGJyb2tlbi4KPgo+IFRoaXMgaXMg
aG93IHdlIGhhdmUgaW1wbGVtZW50ZWQgdXNlcnNwYWNlIGFscmVhZHkuCltKWl0gSSB3aWxsIHN1
Ym1pdCBuZXcgcGF0Y2hlcyB3aWhvdXQgcmluZy0+c2NoZWQucmVhZHkgaW4gaHdfZmluaSBhZnRl
ciAKdGVzdC4gdGhhbmtzIQo+Cj4+PiBUaGUgZmxhZyBlc3NlbnRpYWxseSBzYXlzIHRoYXQgdXNl
cnNwYWNlIGNhbiBzdWJtaXQgam9icyB0byB0aGUgCj4+PiBzY2hlZHVsZXIuIFByb2Nlc3Npbmcg
b2YgdGhvc2Ugam9icyBpcyBvZiBjb3Vyc2Ugb25seSBzdGFydGVkIGFmdGVyIAo+Pj4gdGhlIGhh
cmR3YXJlIGlzIHJlLWluaXRpYWxpemVkLCBidXQgcHVzaGluZyBqb2JzIGRvd24gdGhlIHBpcGUg
aXMgCj4+PiBzdGlsbCBwZXJmZWN0bHkgdmFsaWQgaW4gdGhhdCBzaXR1YXRpb24uCj4+IFtKWl0g
SSBhbSB3b25kZXJpbmcgaWYgaXQgaXMgcmVxdWVzdGVkIHRvIHN0b3Agc2NoZWR1bGluZyBuZXcg
am9icyAKPj4gYmVmb3JlIHNhdmUgYm8uCj4KPiBZZXMsIHRoYXQgaXMgZ3VhcmFudGVlZC4gVGhl
IGhhcmR3YXJlIGJhY2tlbmQgZG9lc24ndCBuZWVkIHRvIHdvcnJ5IAo+IGFib3V0IHRoaXMgaW4g
aHdfZmluaSgpIG9yIG90aGVyd2lzZSB3ZSBoYXZlIGEgYnVnLgo+Cj4gQ2hyaXN0aWFuLgo+Cj4+
Pgo+Pj4gQ2hyaXN0aWFuLgo+Pj4KPj4+Pj4KPj4+Pj4gSWYgeW91IGhhdmUgYW55IGlkZWEgaG93
IHRvIGRvY3VtZW50IHRoYXQgZmFjdCB0aGVuIHBsZWFzZSBzcGVhayAKPj4+Pj4gdXAsIGNhdXNl
IHdlIGhhZCB0aGlzIHByb2JsZW0gYSBjb3VwbGUgb2YgdGltZXMgbm93Lgo+Pj4+Pgo+Pj4+PiBK
dXN0IHNlbmQgb3V0IGEgcGF0Y2ggZml4aW5nIHZhcmlvdXMgb3RoZXIgb2NjYXNpb25zIG9mIHRo
YXQuCj4+Pj4+Cj4+Pj4+IFJlZ2FyZHMsCj4+Pj4+IENocmlzdGlhbi4KPj4+Pj4KPj4+Pj4+Cj4+
Pj4+Pj4gSSd2ZSByZW1vdmVkIGFsbCBvZiB0aG9zZSBhIGNvdXBsZSBvZiB5ZWFycyBhZ28uCj4+
Pj4+Pj4KPj4+Pj4+PiBSZWdhcmRzLAo+Pj4+Pj4+IENocmlzdGlhbi4KPj4+Pj4+Pgo+Pj4+Pj4+
PiArCj4+Pj4+Pj4+ICsgY2FuY2VsX2RlbGF5ZWRfd29ya19zeW5jKCZhZGV2LT52Y24uaWRsZV93
b3JrKTsKPj4+Pj4+Pj4gwqAgwqDCoMKgwqDCoCBpZiAoKGFkZXYtPnBnX2ZsYWdzICYgQU1EX1BH
X1NVUFBPUlRfVkNOX0RQRykgfHwKPj4+Pj4+Pj4gLcKgwqDCoMKgwqDCoMKgIFJSRUczMl9TT0Mx
NShWQ04sIDAsIG1tVVZEX1NUQVRVUykpCj4+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoCAoYWRldi0+
dmNuLmN1cl9zdGF0ZSAhPSBBTURfUEdfU1RBVEVfR0FURSAmJgo+Pj4+Pj4+PiArwqDCoMKgwqDC
oMKgwqDCoCBSUkVHMzJfU09DMTUoVkNOLCAwLCBtbVVWRF9TVEFUVVMpKSkgewo+Pj4+Pj4+PiDC
oMKgwqDCoMKgwqDCoMKgwqAgdmNuX3YxXzBfc2V0X3Bvd2VyZ2F0aW5nX3N0YXRlKGFkZXYsIEFN
RF9QR19TVEFURV9HQVRFKTsKPj4+Pj4+Pj4gK8KgwqDCoCB9Cj4+Pj4+Pj4+IMKgIMKgwqDCoMKg
wqAgcmV0dXJuIDA7Cj4+Pj4+Pj4+IMKgIH0KPj4+Pj4+Pgo+Pj4+Pgo+Pj4KPgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwphbWQtZ2Z4IG1haWxpbmcgbGlz
dAphbWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2FtZC1nZngK
