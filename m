Return-Path: <SRS0=uLL/=J3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF93C433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Apr 2021 13:32:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDEAE6140C
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Apr 2021 13:32:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDEAE6140C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91B876F4C2;
	Fri, 30 Apr 2021 13:32:42 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66FFB6F4C2
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Apr 2021 13:32:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PUrTv7VvxfKU9NTdHA0byozsvy1MRfmuzoA1svK+gexFXT6Qo+5D3VWf4+wVdh23e3YtvdonaIxh+VTaGh2sr2G5CNVXRw20Xaafd6XPXsQqqHWfr5wFExevO3drzktck5Rc9I3GP0nC4wghNW/xqkClgZ60iQu1dANwdbJX85CYxwbuLXzEY3nblzbfZLW+s0kEg2xU7Xm9PVp2oKLZgWc70Cv8NiDdQ/JkR79Kiw2opBF7NRTGarok0/JaqhU9Wneotis4lubQJqG3c0LizXleOlZX50ZwudGxpLbqCzWrADiv6YDreXDHCUBk9yFh8153mFhHCZuw0UhLAlFxZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LO5IiTlRLuhhukriUtOcirTw11UAQfK5frZwkrCy4Qw=;
 b=Gxg6xNNXHSHNYKZR3Gn54nZb+uanEa2SkwJMF6Qbkgv67WaXKSuVTIxLmyKMLMTmVWAx9/+f5+jE/ZGy7P31UkE8YvPVV5VVb1VBzw9WZ+DfEl1r6fxmFJnkXY7ZQrqv63tUCS5JUdQAeFN5aZAWmIvFs46/keoPXD8D3ijtsVr2Gjc221EgidjsCGBGzZGrY8SsAxWnAURCNcQfVbPRNN36HVxzPo97NyYg4DXxP/zgNztsTOmMgv9hakXi5OQR9eyi63KCn5GDAhgwe8veMyI/Txburl7HVGGCqE6ieKCTdUonfNYvA0aMN1P07h4Nq6Im47Tae3wfpsSmHjdzxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LO5IiTlRLuhhukriUtOcirTw11UAQfK5frZwkrCy4Qw=;
 b=cOVWVrh0wiZ1AzHjKFWUw5D6R8yM1hAgCe4GtukA/i/LegbVmYi4Wy2TxNf1YkXTOm5nVlZlMa9s6PF95FwNf2K2uWSd4PkMry9MZX7rIomwGhj+jX79ZeDmM4EdBfkLhDm4RupP5KH9zuHmHtI+jzFMn7jD1v0qUvPrC8cy5qM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR1201MB0053.namprd12.prod.outlook.com (2603:10b6:910:23::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Fri, 30 Apr
 2021 13:32:39 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630%9]) with mapi id 15.20.4065.026; Fri, 30 Apr 2021
 13:32:39 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/1] drm/amdgpu: remove excess function parameter
Date: Fri, 30 Apr 2021 15:32:27 +0200
Message-Id: <20210430133227.23338-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.2
X-Originating-IP: [217.86.127.183]
X-ClientProxiedBy: AM0PR10CA0092.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::45) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.127.183) by
 AM0PR10CA0092.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::45) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4087.27 via Frontend Transport; Fri, 30 Apr 2021 13:32:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df6798b6-2d2f-4ce6-28ac-08d90bdc6c38
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0053:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB005343580FEEB27A3AE474E88B5E9@CY4PR1201MB0053.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v0eY40hhkkHNX7IxrQhVUXb8aWFmmH9EQHbtZdvwjTGxUqXRAmYUhiZW2ojobomdwwH0P3ozS2LPAnQR9zeArvS0hFUi2bF+ixut21v1ucpaf63hVZ2DzWcPJ/Dy2ZAB1i2ivFBYcmYr2Bea4C2uVlpPrL5gidSiDrAddNSJacugestwXpKngz3E1x82pqbRcVsrFkIudYXPcuWvTGzOIk753oNB7QT4VMk3345hDBYTq9MJJnF9JRg9kwVVIwa9RyC6/3syKwYkD2Su/KCl38W8mcNj8JlxhE67eaNlxYCnd0MNrjQehU+c6TC68o/lMyhpC9w+Mfe3yBSY1C9SNR41vzMeJ9+k5n5e9dN3XGX1QEKOj1vg7OIArIKKdcPBkwqh04U+0wWpun868v08kEr8JcnlPCPknPQmlY19/Wb9F9HjAoud4GVmkJ5RFE5NwyrOsJpMYwfXWAUthtYeJrrEmXcUP7PprUayCA1q/eNsSlWvlehwB5Gq8hxtDhL80o4xKIm+YpWKw+zSMHYn5W13nVcsuXmyPVgJDvo/Wqo90ENgvACm4wvZmQtzOxuI5GpfmO8OE0hmUT/Q1u4vs7VdVIXbCxIzatBonN/1k3Y4VEmYD43SRbP9Y8Yt2KTxBDaPgnJJ6i0k2hp3/w6Myg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(136003)(396003)(366004)(4744005)(38350700002)(2906002)(316002)(6506007)(1076003)(6486002)(5660300002)(26005)(44832011)(36756003)(83380400001)(478600001)(186003)(66946007)(38100700002)(2616005)(6512007)(52116002)(6916009)(16526019)(66476007)(86362001)(66556008)(8676002)(6666004)(4326008)(8936002)(956004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?UDv71gQdWDiw5cPZjNycOAu1EyQ1Dj2QilKLjDMWZbG8Ex8nJ0PzYlkj9bSK?=
 =?us-ascii?Q?J6NHbp0uP9K4fgKoDxfy6N68ueqbaZfqY0w1bW3ecpOAxLdJzVo7yWrzHC5a?=
 =?us-ascii?Q?WD1BdLD5Wac3zlkBMbjGJCoRgadBQq2gmOiUJL+dxLc6gEMZdcy7/tnikHhe?=
 =?us-ascii?Q?O0utSBhF7hDWmvqMHtktFXMezYLIGb7YNgbI9d2tzb3Ev+xBQlrnEOAFRObW?=
 =?us-ascii?Q?j+4CjNwG8dQcjD+8infkJwLuTOjfDb1eRbXPJZQKyYKVwftt9xkzb5662tnP?=
 =?us-ascii?Q?0LHSyxH0NwfAph/EXX/K1UZFD7Vkb6/tqOlR2JdZe0Dcek7+qeGXrBD2qYg+?=
 =?us-ascii?Q?FY9eiZariM2hK6zTScOcPsBiWWfoBgpBp+hzRFsEN0puJ8WlAh1ikKbroTfS?=
 =?us-ascii?Q?gW9seuwn3Ec3PaPrvKpIQQRvouUWliuxKWG2rkigRTqQEVHYVlj5KMk4Ya9J?=
 =?us-ascii?Q?YhZk4ccRfz0gc1qGShdXKJ/bFwlSmFi1sojEoNvMXgy0TppdQjK7ESBm3aPo?=
 =?us-ascii?Q?YewOuArQ1VKqSPoQblBiCVIEz1NpKxpycGP9NorGyYZLlS9T3iaKiDZbb7Zy?=
 =?us-ascii?Q?Bya0ye+1Ni72OvVUGP5RVYZGw/fcWKRtTbXUrgLUqYZXAGd172KRKt9QFIs4?=
 =?us-ascii?Q?iq6HVOdEuDI8dKrYnyBQQkG2YN+TJRRugmsxmF3U9gfJRtKnjsmIYaTINoTe?=
 =?us-ascii?Q?7eTvCUdKwwbY1JbIhF7XRKzEKXpPFq4NEwwSRpGHhJd5JlaiqaJ3mfPOcAGO?=
 =?us-ascii?Q?3WuI1Cm9eF1d/Om/dPDGkFMuES1WFq5GFeEuXH3uwPMMfEbEysXvU+nYAqpG?=
 =?us-ascii?Q?dSfZQjQ4YQTqvuweN+KMkfQXhXl0t6e4UpG06d/9trk0WCYyuXNQTCx96hww?=
 =?us-ascii?Q?vgWoinYhCYMMQbwsLfg3VNMp5GLWUEiZl2LSXD3NKbhHpo3c17C88L/wg07L?=
 =?us-ascii?Q?g9xkQmMba228UG+AvMadjDitqdyfh8nlgR/s1CTYmpNkOyepfr5XDMrQjGas?=
 =?us-ascii?Q?/ZYMbuwYHxfDor+wodm4FyB/9FRqprT0rvdU9OnNXOG05Grev11gUl6udKSS?=
 =?us-ascii?Q?gYlaXoG1iPe4jf3h9j45vMkse8SUdDRTyBAva/okwV4JsT3PivXFZuoJzKYi?=
 =?us-ascii?Q?VINolCWKx2MQxwcS+hIL+vvQIn1thkMpmr5BT09e5v+LqDiM9oK9llnTgubs?=
 =?us-ascii?Q?kPp9zQFjM7mKMn/AQCMHqHd2pwRFLMqC+eBOMqoK22JuZ2R4PQlPVehYNZqN?=
 =?us-ascii?Q?IT5z/CmvTOppcKc3JMhFt4l94+L3oVE4BlMmQnGYFpvC3XmX+P/0EmWKfIC0?=
 =?us-ascii?Q?u+rNWzlvbU/XV3zasesMXMUR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df6798b6-2d2f-4ce6-28ac-08d90bdc6c38
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2021 13:32:38.9544 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wFTX2IYS3ElJ2q814vE8x3oXjo4j8pGWMnULgsoLhuyGeC/iPMmj6sA8/Gdoi/FkrO72ZDCm9aiNL3eFORZSuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0053
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
Cc: alexander.deucher@amd.com, Nirmoy Das <nirmoy.das@amd.com>,
 Rodrigo.Siqueira@amd.com, Christian.Koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix below htmldocs build warning:

drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:2808:
warning: Excess function parameter 'vm_context' description in 'amdgpu_vm_init'

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index dae51992c607..f2513be72980 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2796,7 +2796,6 @@ long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout)
  *
  * @adev: amdgpu_device pointer
  * @vm: requested vm
- * @vm_context: Indicates if it GFX or Compute context
  * @pasid: Process address space identifier
  *
  * Init @vm fields.
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
