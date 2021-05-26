Return-Path: <SRS0=Zxj3=KV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC96C47082
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 16:43:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB64061248
	for <amd-gfx@archiver.kernel.org>; Wed, 26 May 2021 16:43:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB64061248
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99C1B6E1A3;
	Wed, 26 May 2021 16:43:36 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FA076E170
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 May 2021 16:43:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N5CylM+P4beJLUhDztkItUG1FtYL2s3dU1G4nfhycFhhi/4RwV9O+VR/tw5Q728P6n4ad0LUVYeDEAlMaK0PPBe0d9vo1kf33PFhk786Q7RH0oaW77KMdzihpMqBsbcwHVYSvE/gQL+1t7qOAHhUhPZS5Q1GRlK5t0x+BUHDin5aWNghBqwxw9aCKTr5ifE25BhEpaFpH6ME3HLe+zOJE4vNG+OarxxqtLb+ivedkz7c4H2yA3wfTBlq+RWmE6lYpL6zaPoO3SqQFYBNXugTi/KMdNb6UzN8mC3NPowa9ixTZ2F/w1tnrNh9fhKPo9y+yucuZikMpwrcGS5IK9A9fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L10UlcXTkYbWlVemZeH//qq2qZoO00sIqmyfY4u3rIo=;
 b=EkKy+CNDOrppCAK0UOe9Es1CMInE/YY1ZrTZFxukSysKyWGVVqVE+l5qTqIPG3zRHU2JHzWJ7UOMu+FdEPzA+jcS3zkDHMVa2RKygOz0tJMOvJzmnXDkzMLUBm0KNgHWiF986N9CZJVJxJOIOkqaKr+9+0mKw3QZNGoCBh93OQ+PxPy8A43iFM9ua0LG+oY2m5CXlrZypWrMAXvhbaMEHw7x55+NjRYrAMsLaH6CksVDPYhrGoUbVO/HspmHfauMy5ZRLkC2D6BjjIBTuf9tVSGAHhsn03/Vpz1bHA92PMqU81hilibOUrFt4qhDl4t1HPlOTqh9cWbNkktOlRPsBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L10UlcXTkYbWlVemZeH//qq2qZoO00sIqmyfY4u3rIo=;
 b=5c8sJg/+VWV19S0MmqObCBMNnj8eFmd+WaQCXJwl673JvkvkB1rh2dU7wZOhpW7mMzOhT/IU7AsUeOwdFYuoMQd3Y7q9QJ2pbpikjJR4HxnCH25Fsp3B1RZIu/zTXbvAyRT6Sc5DG4+Wx7Dd9OkVcC+4G91s2Nl90UnftfTntQs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21)
 by DM6PR12MB4942.namprd12.prod.outlook.com (2603:10b6:5:1be::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Wed, 26 May
 2021 16:43:32 +0000
Received: from DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0]) by DM6PR12MB3962.namprd12.prod.outlook.com
 ([fe80::142:82e3:7e9d:55a0%6]) with mapi id 15.20.4150.027; Wed, 26 May 2021
 16:43:32 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/3] drm/amdgpu: Use delayed work to collect RAS error counters
Date: Wed, 26 May 2021 12:43:16 -0400
Message-Id: <20210526164316.20547-3-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.31.1.527.g2d677e5b15
In-Reply-To: <20210526164316.20547-1-luben.tuikov@amd.com>
References: <20210526164316.20547-1-luben.tuikov@amd.com>
X-Originating-IP: [108.162.138.69]
X-ClientProxiedBy: YT1PR01CA0148.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::27) To DM6PR12MB3962.namprd12.prod.outlook.com
 (2603:10b6:5:1ce::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (108.162.138.69) by
 YT1PR01CA0148.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4150.27 via Frontend Transport; Wed, 26 May 2021 16:43:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 605b96a2-fa15-4086-f9b5-08d9206565ec
X-MS-TrafficTypeDiagnostic: DM6PR12MB4942:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB494230711B0572EBCEADB22999249@DM6PR12MB4942.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MrfXrb1OqtM8583gys432MUVe8ZcqFkDc4kMMD8VW37iJtgeogD4SX3Z8Vt0ku7yoYc+LAr7oEuUNRAf3G93E0LuK/1QYRNBEtSjaE3NyLsFlIcv1XU80A/MKgzKdXVJnNc1pkEZDTz8pWVKH/64KgMTwCBZP0tN6i6u91E0CmQOP3i+EOdWABVSeeefRJxeJCMjG/cfaD7YWxfl9pwGCZOGbSXDY2zlcjz3jiCzzOg71rHJEMH/Q74kP0WP76HvYIU6icMYRxWX+WqQzXmQm9aeBj561gvQA0mUA/j3bgD+A0Jp3HBP0uZACtLARjoqjuzw63yu4xIGP3oiFpqeNG3FFGBYE2kQkYNJVo0/rD7yObeUQA3DJp8T06Dfp4RiCwgUnn4u5nX7A2JBEFDpS6XOE4X1/B41ROHG3m5SWwNOyxvdoGNWxoBZJ7tKCHseicbskTjHdeQ+D2UDHWQXWhihQMaVoyuiGkjRI8uO+TariOj/DxhsWosFikvtVWUlhr0FhaAdFwqInEyEX4pNJnlEtk0g06Gmoz7Pa0pUsB1vj4ffqcdDfJeNnTEWQF//baUDRXuD1aaBHUxa70Lw8ZPyMdXqTrFaUPFfJmsb4utJT4sTCXRarV/A8oxyYmdYU+SLjtUJiTB7WK0k6c9rrQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3962.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(346002)(396003)(39860400002)(366004)(55236004)(52116002)(6506007)(38100700002)(38350700002)(83380400001)(54906003)(86362001)(316002)(66574015)(8936002)(6512007)(6666004)(8676002)(4326008)(6916009)(478600001)(6486002)(2616005)(956004)(2906002)(44832011)(16526019)(186003)(26005)(66476007)(66556008)(66946007)(5660300002)(36756003)(1076003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dGZBbEtnVW5hZTJ5cjNIZlhHa1lRb3NQbDRqYkh2M2hWY0ltWWFacmJzWXJL?=
 =?utf-8?B?QjVOVlQyOExpUkg1SEM2cHZmTFliSTJiTFZkZmFzek1GcUJ3d21sZ3ljLy9Y?=
 =?utf-8?B?aEt6bVc0Y3ZKWXExUUZXTll0bExlSlpWa0FkY0I5NitQcmVGWkVzTTVoT0ZJ?=
 =?utf-8?B?TDhzNGk2ZkltakY2YjFWbkV1bDBzVnFSLzZxNW52bFU1QVNYeGU2bzhRZEdz?=
 =?utf-8?B?ekIvL250bFRQVTF2V0NUcnArbXFOazFKa1hML1h5K1hOMjljVlBEaHdzdnFG?=
 =?utf-8?B?TzFWM2ovUU5lbFprUllGdHIvVEMyaWNGeFN2UjlBN2ppcEkvZm5ZREtTT1RN?=
 =?utf-8?B?SC80TFZMelZMUHpzTVJNdVA0QVNISXhqbGhFbk5lTzRiQ2VudUtMM3dRejNJ?=
 =?utf-8?B?ZTcyN0lTNi9EbytkNWJiMlI1Y042QnNEd3dZdjdmektFUFVMcFRkWGNSTGRz?=
 =?utf-8?B?WDFQSTdZWGhLVlYyNWZNTEFna09IcVFrUWxxLzdDcDgyNTVEa1EzdTdqNHdw?=
 =?utf-8?B?WkpjTE92dDNuN3lIdmVzMWdEU2pvOHQ3VDE4UEIwN090am53bzBKSjZpZ01Y?=
 =?utf-8?B?WWJzcUI3UFJjdVNFa0daZG4xNXRlSXBVS2FhdGtEWk5PQ1V2V25GdXhhUnp3?=
 =?utf-8?B?akhkUnJ5WjFOVmZxVXo5dk1ZcVYwR1BjTmJSVkdXandyWldkWmRWcTVLRk9H?=
 =?utf-8?B?bmNaeUJyRkh5RW9vdWtqdkwvVWVKUk1RY0JRS0FIaWIxYVFrQ2VHZ21uNkFY?=
 =?utf-8?B?SkF1MXdGdnQzS2hSb2ptRkZ0Unk1Nk55OEZGRVRuSXFma0wyYmh0d2Y2NXVo?=
 =?utf-8?B?Q2xhWGFiN2daNExlNnVDYTJKK3ZrUlFQRVNDYURYWCtrNEdyaTNYTEhjdDdx?=
 =?utf-8?B?QWJMTVYwN0hJd2JoN1dTUDJlU3RGVStQMVBFU0pBbGdYSkNPMXVXS20wZ2hC?=
 =?utf-8?B?OW1sTWN2Rnk1a0R0amFJNEh5dUg5SXRGUWNNdHZCVlZKVk4vbkZVV0dVLzFK?=
 =?utf-8?B?b3ozVE4vdWYvK25yMVNiTEdLeE11S3dCWU9KdUVhZ3pieC9wMGxJNFRZZnh0?=
 =?utf-8?B?OHJKTTVOWlNXRjVHSXM1azErZFlzQ1Fjc21TYU96dGh5aEw2S3Jtd3BjWU9w?=
 =?utf-8?B?ZEZKQnVtWG9zMzd3RzhXS0RlTldUd2dGbjJpVUdXYkpJK2pEYm9KZlJYWXNS?=
 =?utf-8?B?ZlBRQVhxWWZhZHl3TXFSbllOYXZsbGk4cnBmZWc1M2tSYlowRk56N3JORHBh?=
 =?utf-8?B?WDhnb3hrMC9GcFBaMHFXT1N1L2YzbXpJaERLcjZrN0JjY1VKREZ5emd1UjlS?=
 =?utf-8?B?OUxpbC9sdmtsV1ZabmtOVmZRNkZuVTFGQUxpdTBRZUM0MkVqVCtFSm9sZHNv?=
 =?utf-8?B?VXB1VkhXeXowZ3A4YnNsNUlzMWpad1djQWVEWlp0OU5ldkFDZDN1Rm4wcEhu?=
 =?utf-8?B?aEduOFZ5UE1oMEpBYnBWZUltZlA2K1NtcDNPcy9hUlNkUWNXZjl3eWo3REZZ?=
 =?utf-8?B?WDl4UFpRRkozMnZHejRFcHF0eVZhSHBEOHRieE9haHlickpPQkwyNGNqaEZR?=
 =?utf-8?B?YnZ2aUpKWnpCbkdicENvYkNjN2FlUVlQVGpBcTlBd3JXeHlpMG1KMGlRSCt2?=
 =?utf-8?B?NnRpUXM2N1NoY09NYVVJZDRzMlNqa2lBUHBLRnRlYVZ0QXBxZjhjTEpJUms0?=
 =?utf-8?B?NStCV3plRnc0UXBTU0l4OGp0K0NQMWtkeDc3QlA5cjRSeE9CeXJ6UU00d1lJ?=
 =?utf-8?Q?srkgaq6lVp1wHt1z2yNO6KP9rFKyNZQHft3z1Td?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 605b96a2-fa15-4086-f9b5-08d9206565ec
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3962.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2021 16:43:32.5229 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BRN2s/Vw5GfQxWGwWSARjllCoqrqAfn5mJ/Pjsf5SH7FSjKMWYFhMUVxAnRpRZK0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4942
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>, John Clements <john.clements@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

T24gQ29udGV4dCBRdWVyeTIgSU9DVEwgcmV0dXJuIHRoZSBjb3JyZWN0YWJsZSBhbmQKdW5jb3Jy
ZWN0YWJsZSBlcnJvcnMgaW4gTygxKSBmYXNoaW9uLCBmcm9tIGNhY2hlZAp2YWx1ZXMsIGFuZCBz
Y2hlZHVsZSBhIGRlbGF5ZWQgd29yayBmdW5jdGlvbiB0bwpjYWxjdWxhdGUgYW5kIGNhY2hlIHRo
ZW0gZm9yIHRoZSBuZXh0IHN1Y2ggSU9DVEwuCgp2MjogQ2FuY2VsIHBlbmRpbmcgZGVsYXllZCB3
b3JrIGF0IHJhc19maW5pKCkuCnYzOiBSZW1vdmUgY29uZGl0aW9uYWxzIHdoZW4gZGVhbGluZyB3
aXRoIGRlbGF5ZWQKICAgIHdvcmsgbWFuaXB1bGF0aW9uIGFzIHRoZXkncmUgaW5oZXJlbnRseSBy
YWN5LgoKQ2M6IEFsZXhhbmRlciBEZXVjaGVyIDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPgpD
YzogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpDYzogSm9obiBD
bGVtZW50cyA8am9obi5jbGVtZW50c0BhbWQuY29tPgpDYzogSGF3a2luZyBaaGFuZyA8SGF3a2lu
Zy5aaGFuZ0BhbWQuY29tPgpTaWduZWQtb2ZmLWJ5OiBMdWJlbiBUdWlrb3YgPGx1YmVuLnR1aWtv
dkBhbWQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jdHguYyB8
IDMxICsrKysrKysrKysrKysrKysrLS0KIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9yYXMuYyB8IDQwICsrKysrKysrKysrKysrKysrKysrKysrKysKIGRyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9yYXMuaCB8ICA1ICsrKysKIDMgZmlsZXMgY2hhbmdlZCwgNzQgaW5z
ZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfY3R4LmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9hbWRn
cHVfY3R4LmMKaW5kZXggYmIwY2ZlODcxYWJhLi5lN2EwMTBiN2NhMWYgMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jdHguYworKysgYi9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfY3R4LmMKQEAgLTMzMSwxMCArMzMxLDEzIEBAIHN0YXRpYyBp
bnQgYW1kZ3B1X2N0eF9xdWVyeShzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAlyZXR1cm4g
MDsKIH0KIAorI2RlZmluZSBBTURHUFVfUkFTX0NPVU5URV9ERUxBWV9NUyAzMDAwCisKIHN0YXRp
YyBpbnQgYW1kZ3B1X2N0eF9xdWVyeTIoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYsCi0Jc3Ry
dWN0IGFtZGdwdV9mcHJpdiAqZnByaXYsIHVpbnQzMl90IGlkLAotCXVuaW9uIGRybV9hbWRncHVf
Y3R4X291dCAqb3V0KQorCQkJICAgICBzdHJ1Y3QgYW1kZ3B1X2Zwcml2ICpmcHJpdiwgdWludDMy
X3QgaWQsCisJCQkgICAgIHVuaW9uIGRybV9hbWRncHVfY3R4X291dCAqb3V0KQogeworCXN0cnVj
dCBhbWRncHVfcmFzICpjb24gPSBhbWRncHVfcmFzX2dldF9jb250ZXh0KGFkZXYpOwogCXN0cnVj
dCBhbWRncHVfY3R4ICpjdHg7CiAJc3RydWN0IGFtZGdwdV9jdHhfbWdyICptZ3I7CiAKQEAgLTM2
MSw2ICszNjQsMzAgQEAgc3RhdGljIGludCBhbWRncHVfY3R4X3F1ZXJ5MihzdHJ1Y3QgYW1kZ3B1
X2RldmljZSAqYWRldiwKIAlpZiAoYXRvbWljX3JlYWQoJmN0eC0+Z3VpbHR5KSkKIAkJb3V0LT5z
dGF0ZS5mbGFncyB8PSBBTURHUFVfQ1RYX1FVRVJZMl9GTEFHU19HVUlMVFk7CiAKKwlpZiAoYWRl
di0+cmFzX2VuYWJsZWQgJiYgY29uKSB7CisJCS8qIFJldHVybiB0aGUgY2FjaGVkIHZhbHVlcyBp
biBPKDEpLAorCQkgKiBhbmQgc2NoZWR1bGUgZGVsYXllZCB3b3JrIHRvIGNhY2hlCisJCSAqIG5l
dyB2YXVlcy4KKwkJICovCisJCWludCBjZV9jb3VudCwgdWVfY291bnQ7CisKKwkJY2VfY291bnQg
PSBhdG9taWNfcmVhZCgmY29uLT5yYXNfY2VfY291bnQpOworCQl1ZV9jb3VudCA9IGF0b21pY19y
ZWFkKCZjb24tPnJhc191ZV9jb3VudCk7CisKKwkJaWYgKGNlX2NvdW50ICE9IGN0eC0+cmFzX2Nv
dW50ZXJfY2UpIHsKKwkJCWN0eC0+cmFzX2NvdW50ZXJfY2UgPSBjZV9jb3VudDsKKwkJCW91dC0+
c3RhdGUuZmxhZ3MgfD0gQU1ER1BVX0NUWF9RVUVSWTJfRkxBR1NfUkFTX0NFOworCQl9CisKKwkJ
aWYgKHVlX2NvdW50ICE9IGN0eC0+cmFzX2NvdW50ZXJfdWUpIHsKKwkJCWN0eC0+cmFzX2NvdW50
ZXJfdWUgPSB1ZV9jb3VudDsKKwkJCW91dC0+c3RhdGUuZmxhZ3MgfD0gQU1ER1BVX0NUWF9RVUVS
WTJfRkxBR1NfUkFTX1VFOworCQl9CisKKwkJc2NoZWR1bGVfZGVsYXllZF93b3JrKCZjb24tPnJh
c19jb3VudGVfZGVsYXlfd29yaywKKwkJCQkgICAgICBtc2Vjc190b19qaWZmaWVzKEFNREdQVV9S
QVNfQ09VTlRFX0RFTEFZX01TKSk7CisJfQorCiAJbXV0ZXhfdW5sb2NrKCZtZ3ItPmxvY2spOwog
CXJldHVybiAwOwogfQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1k
Z3B1X3Jhcy5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5jCmluZGV4
IGVkM2M0M2U4YjBiNS4uZWM5MzZjZGUyNzI2IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9hbWRncHVfcmFzLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUv
YW1kZ3B1X3Jhcy5jCkBAIC0yNyw2ICsyNyw3IEBACiAjaW5jbHVkZSA8bGludXgvdWFjY2Vzcy5o
PgogI2luY2x1ZGUgPGxpbnV4L3JlYm9vdC5oPgogI2luY2x1ZGUgPGxpbnV4L3N5c2NhbGxzLmg+
CisjaW5jbHVkZSA8bGludXgvcG1fcnVudGltZS5oPgogCiAjaW5jbHVkZSAiYW1kZ3B1LmgiCiAj
aW5jbHVkZSAiYW1kZ3B1X3Jhcy5oIgpAQCAtMjExNiw2ICsyMTE3LDMwIEBAIHN0YXRpYyB2b2lk
IGFtZGdwdV9yYXNfY2hlY2tfc3VwcG9ydGVkKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQog
CQlhZGV2LT5yYXNfaHdfZW5hYmxlZCAmIGFtZGdwdV9yYXNfbWFzazsKIH0KIAorc3RhdGljIHZv
aWQgYW1kZ3B1X3Jhc19jb3VudGVfZHcoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQoreworCXN0
cnVjdCBhbWRncHVfcmFzICpjb24gPSBjb250YWluZXJfb2Yod29yaywgc3RydWN0IGFtZGdwdV9y
YXMsCisJCQkJCSAgICAgIHJhc19jb3VudGVfZGVsYXlfd29yay53b3JrKTsKKwlzdHJ1Y3QgYW1k
Z3B1X2RldmljZSAqYWRldiA9IGNvbi0+YWRldjsKKwlzdHJ1Y3QgZHJtX2RldmljZSAqZGV2ID0g
JmFkZXYtPmRkZXY7CisJdW5zaWduZWQgbG9uZyBjZV9jb3VudCwgdWVfY291bnQ7CisJaW50IHJl
czsKKworCXJlcyA9IHBtX3J1bnRpbWVfZ2V0X3N5bmMoZGV2LT5kZXYpOworCWlmIChyZXMgPCAw
KQorCQlnb3RvIE91dDsKKworCS8qIENhY2hlIG5ldyB2YWx1ZXMuCisJICovCisJYW1kZ3B1X3Jh
c19xdWVyeV9lcnJvcl9jb3VudChhZGV2LCAmY2VfY291bnQsICZ1ZV9jb3VudCk7CisJYXRvbWlj
X3NldCgmY29uLT5yYXNfY2VfY291bnQsIGNlX2NvdW50KTsKKwlhdG9taWNfc2V0KCZjb24tPnJh
c191ZV9jb3VudCwgdWVfY291bnQpOworCisJcG1fcnVudGltZV9tYXJrX2xhc3RfYnVzeShkZXYt
PmRldik7CitPdXQ6CisJcG1fcnVudGltZV9wdXRfYXV0b3N1c3BlbmQoZGV2LT5kZXYpOworfQor
CiBpbnQgYW1kZ3B1X3Jhc19pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQogewogCXN0
cnVjdCBhbWRncHVfcmFzICpjb24gPSBhbWRncHVfcmFzX2dldF9jb250ZXh0KGFkZXYpOwpAQCAt
MjEzMCw2ICsyMTU1LDExIEBAIGludCBhbWRncHVfcmFzX2luaXQoc3RydWN0IGFtZGdwdV9kZXZp
Y2UgKmFkZXYpCiAJaWYgKCFjb24pCiAJCXJldHVybiAtRU5PTUVNOwogCisJY29uLT5hZGV2ID0g
YWRldjsKKwlJTklUX0RFTEFZRURfV09SSygmY29uLT5yYXNfY291bnRlX2RlbGF5X3dvcmssIGFt
ZGdwdV9yYXNfY291bnRlX2R3KTsKKwlhdG9taWNfc2V0KCZjb24tPnJhc19jZV9jb3VudCwgMCk7
CisJYXRvbWljX3NldCgmY29uLT5yYXNfdWVfY291bnQsIDApOworCiAJY29uLT5vYmpzID0gKHN0
cnVjdCByYXNfbWFuYWdlciAqKShjb24gKyAxKTsKIAogCWFtZGdwdV9yYXNfc2V0X2NvbnRleHQo
YWRldiwgY29uKTsKQEAgLTIyMzMsNiArMjI2Myw4IEBAIGludCBhbWRncHVfcmFzX2xhdGVfaW5p
dChzdHJ1Y3QgYW1kZ3B1X2RldmljZSAqYWRldiwKIAkJCSBzdHJ1Y3QgcmFzX2ZzX2lmICpmc19p
bmZvLAogCQkJIHN0cnVjdCByYXNfaWhfaWYgKmloX2luZm8pCiB7CisJc3RydWN0IGFtZGdwdV9y
YXMgKmNvbiA9IGFtZGdwdV9yYXNfZ2V0X2NvbnRleHQoYWRldik7CisJdW5zaWduZWQgbG9uZyB1
ZV9jb3VudCwgY2VfY291bnQ7CiAJaW50IHI7CiAKIAkvKiBkaXNhYmxlIFJBUyBmZWF0dXJlIHBl
ciBJUCBibG9jayBpZiBpdCBpcyBub3Qgc3VwcG9ydGVkICovCkBAIC0yMjczLDYgKzIzMDUsMTIg
QEAgaW50IGFtZGdwdV9yYXNfbGF0ZV9pbml0KHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2LAog
CWlmIChyKQogCQlnb3RvIHN5c2ZzOwogCisJLyogVGhvc2UgYXJlIHRoZSBjYWNoZWQgdmFsdWVz
IGF0IGluaXQuCisJICovCisJYW1kZ3B1X3Jhc19xdWVyeV9lcnJvcl9jb3VudChhZGV2LCAmY2Vf
Y291bnQsICZ1ZV9jb3VudCk7CisJYXRvbWljX3NldCgmY29uLT5yYXNfY2VfY291bnQsIGNlX2Nv
dW50KTsKKwlhdG9taWNfc2V0KCZjb24tPnJhc191ZV9jb3VudCwgdWVfY291bnQpOworCiAJcmV0
dXJuIDA7CiBjbGVhbnVwOgogCWFtZGdwdV9yYXNfc3lzZnNfcmVtb3ZlKGFkZXYsIHJhc19ibG9j
ayk7CkBAIC0yMzkwLDYgKzI0MjgsOCBAQCBpbnQgYW1kZ3B1X3Jhc19maW5pKHN0cnVjdCBhbWRn
cHVfZGV2aWNlICphZGV2KQogCWlmIChjb24tPmZlYXR1cmVzKQogCQlhbWRncHVfcmFzX2Rpc2Fi
bGVfYWxsX2ZlYXR1cmVzKGFkZXYsIDEpOwogCisJY2FuY2VsX2RlbGF5ZWRfd29ya19zeW5jKCZj
b24tPnJhc19jb3VudGVfZGVsYXlfd29yayk7CisKIAlhbWRncHVfcmFzX3NldF9jb250ZXh0KGFk
ZXYsIE5VTEwpOwogCWtmcmVlKGNvbik7CiAKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9h
bWQvYW1kZ3B1L2FtZGdwdV9yYXMuaCBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdw
dV9yYXMuaAppbmRleCAxMGZjYTAzOTMxMDYuLjI1NmNlYTVkMzRmMiAxMDA2NDQKLS0tIGEvZHJp
dmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X3Jhcy5oCisrKyBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvYW1kZ3B1L2FtZGdwdV9yYXMuaApAQCAtMzQwLDYgKzM0MCwxMSBAQCBzdHJ1Y3QgYW1k
Z3B1X3JhcyB7CiAKIAkvKiBkaXNhYmxlIHJhcyBlcnJvciBjb3VudCBoYXJ2ZXN0IGluIHJlY292
ZXJ5ICovCiAJYm9vbCBkaXNhYmxlX3Jhc19lcnJfY250X2hhcnZlc3Q7CisKKwkvKiBSQVMgY291
bnQgZXJyb3JzIGRlbGF5ZWQgd29yayAqLworCXN0cnVjdCBkZWxheWVkX3dvcmsgcmFzX2NvdW50
ZV9kZWxheV93b3JrOworCWF0b21pY190IHJhc191ZV9jb3VudDsKKwlhdG9taWNfdCByYXNfY2Vf
Y291bnQ7CiB9OwogCiBzdHJ1Y3QgcmFzX2ZzX2RhdGEgewotLSAKMi4zMS4xLjUyNy5nMmQ2Nzdl
NWIxNQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1k
LWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9s
aXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==
