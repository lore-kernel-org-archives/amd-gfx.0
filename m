Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F148C00140
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Aug 2022 06:21:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 125C611B1AE;
	Fri, 12 Aug 2022 06:21:26 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37B1911BF57
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Aug 2022 06:21:18 +0000 (UTC)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27C50TwH008538;
 Fri, 12 Aug 2022 06:21:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=p6A4u2K+9rLW9cZ7khEaHvRwAzhWYh2GNh4POZkI1d4=;
 b=TqpY5Kf0IWOmYoATpS/Hw9BsRlXUOy0EqFHXRkZvvfLpK/Fs6hxNySeDpXSEFMzgKUqG
 klbhDLnC8QfgFvygJzC4ffeUsugKzvCpp7htP3bx0igASS+zNzHEOCqEzZgeKat69ui6
 BFXe/PTEr3O0kqeE1rFUXxgDZ6bJz08nq30cEjfp45LNMJo2AFJQJHJ5+I7Ionr/ZptL
 fx6RwTZXviuBiYLdZ+NsPvY5D0OncyrKfjcx0OjUbOZ1LOtwJOIFSAVFptd8sZyKVU0D
 3f2vCRCbHKHIz7PtJ9H6cLFlU217zDjDShPQKvuYVK0kjvDFMoMJYpUM/LpsvTsjaYZC cg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3huwqj6ghw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Aug 2022 06:21:13 +0000
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 27C1fDJK035322; Fri, 12 Aug 2022 06:21:11 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 3huwqkvaub-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 12 Aug 2022 06:21:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fwt+Nzw+zRuZPgQemgPHUHzZzbVnEkMA89HZ3tmxqL81Rez+LDLjJ/M4iEV0lg405oens5X34+wM56DJZ8arbzBGk2WSLf9id1580Bc1cTtEbmyhcTiUSyG3EUPit8VuNnFGt5hJTDTQlK/UA6iBnz1IhqjmaH5oZ9EEY/9EQw1PLVDH5je1gvhQEnJHNOfrH/QRz3MQ5VWJcNmxZ9L3hZkpBzfoTh9xL7/1jPe7I7Z8KbWGtzsUHOAOoOGoKAl6ldMGJx3uWzFhCCCxzgA9vQlHwXpOr2w9M6uTnZ8e8fhH2g1vaRUD2D/dz/RQBv0KmjVms6+r2zs8GipRWvbDfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p6A4u2K+9rLW9cZ7khEaHvRwAzhWYh2GNh4POZkI1d4=;
 b=SbDTwJHoN49poEqbw8vWxIJRg3kD4y3hZ+42old6B+gEGpo+6dK23O4YlF8mnd1zxpaA4LVeCD9W8X3ILRF/2kbcLVe2Cd+7PfK7bs6niMfrMbrafA7cZWluu6+ai8WS7Uw7NbnOUoFPPgisU2EFG0L0gsaFhDqT5xX/CVfa9giXHZ1zEKtyYcSU8yJdMHfbRKh/bU0zeRhA1XdjrBDesdAtVqkPKGWK2JQe4ETWg5jbQGGerziiNjFrPH5JwBsYfOO2mjKq1daM/9VxoZtWlOPAUqtIIA05DtfCIUrPaDsg7t5tyF46+Ev1M99cWWA6iW7kp6HEYwszOJfz5Yur9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p6A4u2K+9rLW9cZ7khEaHvRwAzhWYh2GNh4POZkI1d4=;
 b=xNYrNFY+z9DmQmmSMI/JTah3tiPv5O20vUUkLiq/IibrEDj1MOAWAOD96J0puSIa5u0FKzn62f+IfdRPgfPXun7f2cd3uN2ncqaJV9+pF6DBuKhI3cOQD83j9s3VLXlwX/R/npO2udOmu77iCTE8cSSYdgPaLvAIF4i4k5vNpqU=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BLAPR10MB4962.namprd10.prod.outlook.com
 (2603:10b6:208:327::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Fri, 12 Aug
 2022 06:21:09 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5504.024; Fri, 12 Aug 2022
 06:21:09 +0000
Date: Fri, 12 Aug 2022 09:20:58 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Felix Kuehling <Felix.Kuehling@amd.com>,
 Ramesh Errabolu <Ramesh.Errabolu@amd.com>
Subject: [PATCH] drm/amdkfd: potential crash in kfd_create_indirect_link_prop()
Message-ID: <YvXxSkLaaSMLU8fT@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR0P278CA0001.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::11) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c732533-25fe-4182-39c6-08da7c2ad87d
X-MS-TrafficTypeDiagnostic: BLAPR10MB4962:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ufe9ZXuH+ReKK5lkSNC8qT9IHLb92sEZlkQYU5Alz1UUX4hBT6Mh0TmHyPT8y7xwd5ZT+T2VHvtyZfYFmKOrxzyLd/cUP4+RP1B+Ff8fW05xXyVjNc8RYqt+4Px0q6+8/ney/mOMrFy5bkJtdCAPJm3QjbZYoThkOuFxT63cflQA+HY/QEd5T/fE4ywuGMNnJsbcYltJ5RfmmynW8FJC446Ok2U18ZLwFcQ6ZF9PcWg6WTid2xjLf2vtF+njFXOZYcQ2i5+mNxBtyDzolNt4kn07kHRy2b5ToXx2OvEkjWSSOQuv8Vupfykke/1JQF3o8WiDXttYy/mBC78lW3kiHgh5xUK3Jco4EESTTWEWxOJJunkL5PVvFaaRRl57JibymdkrWurvsfAlkrYGoQB0EqDFaRykmMX5lP1K7qDdnc9aLZsdIup0OmcUA7rdzPKmmvswJnaNRyy44Kx60KhOn/U88s8bzZ8hENn+qe5B65/PAyGisy3PXj8zwyW4Jozdumt8gSboyAmEB7diKh35dLmq9xNlT8bn+FPDlDCCQpR74zWXsPNca581CceYXZ2NpPm7PRSlOamLMYH0oiJEIaqLe6V19Zo1ewMmnK5uomSvR0T/aesddayKRNJCbiw3eJ3l3BV9LZgMZt+9cIAEp3gh2OLtnvsZvRO8ZWYPSBnj7H4dfa3dyKu+lfcP8YxpbGu5y0b+7p5rDC16pquWnnH6r8IZOgHHSwOPJPKI8fhrwvlbwVVv2C9QGoc0vL4bAZIPqsHDRm6tnINg1UHD6Zlsy95vBuRtVkXRvI6aANs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1001MB2365.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(7916004)(366004)(376002)(396003)(346002)(39860400002)(136003)(186003)(83380400001)(33716001)(38100700002)(478600001)(38350700002)(6486002)(110136005)(66556008)(6666004)(41300700001)(316002)(54906003)(44832011)(5660300002)(52116002)(6512007)(2906002)(8936002)(26005)(66946007)(9686003)(8676002)(66476007)(4326008)(86362001)(6506007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ql7R1KTduX6oeqIMV/pQRS886G0mOqbzsi5qB8E5lrdCFi40MNbTjYtbB66j?=
 =?us-ascii?Q?fih5WS/d2HVFd3c1qcXpFeS5QS2kghDroAr5ifoELE+gh/3Ri9/Oia5W1XdC?=
 =?us-ascii?Q?8Yo1frjZDKKk1bdyc+sygckrMOxgY1NJ/RQ6jaL3Eu035GZ4gPZ9psq/gVDb?=
 =?us-ascii?Q?Kghd96nAhxRVJh+bZ02s/IwMRwZgHVXp2qw8IuWpwDMZP3e6LBmR0qiaUcVF?=
 =?us-ascii?Q?HPoq3GKSaqSavqLyqX6FMvUZCoc1ndgRiwEW9yyhoK3fWXlV28uIRA5KE7W0?=
 =?us-ascii?Q?CK4NNlr9IbtCNSzFrOrVY+xzRplrXkb6NshHoRr8cW18VuzMTOtEbUTjmErZ?=
 =?us-ascii?Q?Bwm8KLOMWLwvdUpmn3dyHg+g6WPM+BfDRPJTms4Avov9vqCzozoeHNx8FXt9?=
 =?us-ascii?Q?qVyeaCk9wmblx7xQVZUulbX7Hv4YbR3QTniho3Zz73ykydiY9Ju1B377Aioe?=
 =?us-ascii?Q?QSRmXTYVC6OGvdVvGGtYFXFY75VEvWewarizad0KEcqAH2LTiqZ+FDyIrSdo?=
 =?us-ascii?Q?IAImo1+VmKVM3FxiM8ybxyJAF8o5O9NJkYGuLl7RoPNW5RNvWDIZaM5tBCmi?=
 =?us-ascii?Q?j6Em/XmyB1WuxoogdK8q/jSu+Jp72CCpFqC4GMhWTYX74UYNAtCmMYiPGp61?=
 =?us-ascii?Q?kJ7F91IEueeoQ0Q5fBQ3vPuXZM/sTWrNy6c/CnrnIG6aLmyvFIJgyaUzlhPu?=
 =?us-ascii?Q?spYBaNTXY5pA5VF5e2RaLVIquw66MehPBMuIdxQxE3P5KZXw5z8eaF4xVfEZ?=
 =?us-ascii?Q?cpxmfh5oi1RIKW3rD/rFnmpw8gGpYgX2DYziDTT1FyV+Gi+GOVSsDZPIuLz4?=
 =?us-ascii?Q?RCF86E6PXyhY22hBqOdNO38YrvcifLhDhaYyv7ph7UgZd5qkSDFp8UJCfJ4e?=
 =?us-ascii?Q?2V+cuZmw9B/i0X4HcYGwUCIWz5Lyn8uOGt9MctuG8HgFmJ0S5V4R27TVBI3G?=
 =?us-ascii?Q?aCFHEYnCbWxtxwk6orEeNlXZFmZkNNWxLGy4P13OVABWrRgZ8R3os81Uwx3v?=
 =?us-ascii?Q?ztkrq+B2nOshHBFvgt14hDWInpRwVK2Pk+Ag3a7RABk8w0eO6dPgo+eLHyDT?=
 =?us-ascii?Q?Z5ecJleyKOzSCdADfRslnUojhdZczA8hBw8LAyr3TgTJASGVUd2J06pcrCQM?=
 =?us-ascii?Q?aNsQExGyAlcxaQaV0+JhlgHFO2FOgvKsYnYgH09dBgsrIUOFk7v9UBO7rsXn?=
 =?us-ascii?Q?Nzc6tQOJfJsLLfrx2VcDG9OFOGz6U5rvTz9QbWWNFa2rtABO7KXqEDxWNUjM?=
 =?us-ascii?Q?HKNBIwWeEb/Yh5FHVzp5WZdNizMjV3mQpnGMh6mqrsaVCWdQqrn350Xnr3uE?=
 =?us-ascii?Q?mKByJ4HHVmU3ZdYilHvV1Ce5k79TfU9qgsBeHV1ye+HKDgJ09MBwIGaUkYA0?=
 =?us-ascii?Q?cxBjX4MjpGdf0lB+xZTZWUG3NFmduA/ZQntAcYS4tw3JjgQqTVoXb7z1OHGa?=
 =?us-ascii?Q?9+yrdPOXGAjA2s7wb7TCSoGSO6Yv6vdhsvctilfNE+5S9hfZ/WtgflnyOGPH?=
 =?us-ascii?Q?ZOnOcI+A521NiDAZN0zFifIXHYMWLJhEVJyjrN9bbb0aGckdZMrWv9BZevZN?=
 =?us-ascii?Q?37XAZpOnGjDqx7vig9cZtHWCYowgPgjIxDj0uIb3Wogu1dPZRFNoIlVoBLvR?=
 =?us-ascii?Q?ag=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?dbxdmcz6dmbGyee29lCq08s+ODwe4SIjkyEzws7BbKGb6uSL+tfALl5fIXbE?=
 =?us-ascii?Q?FD+S/PUdN75pHGLFAEX9NzXkRJbcpU13nBYSVrplnOwxFPSPdTLCGDPFtsWG?=
 =?us-ascii?Q?KFptX8uF1xIQGwME4Br5kez/kROWKk6l3KZx+p2AZM6bQAp/RiKn/HfOxm6b?=
 =?us-ascii?Q?1GGx3YK9jmSViRJU1ZKTDms5H33t4wDcyK4fPQ0DxKsMYUxHmGmxJMcK2CxJ?=
 =?us-ascii?Q?etNdaBX26qdaMpMIHQE3MH7diS6yCe58Nr7I67Ukc52DSKwjp4+QbK0SRI66?=
 =?us-ascii?Q?0n0XJXAZm5qnlZV48CFvDQOw1o9bpjUfzcBhsAecN0edyUa0Gd1PGSq7LSXv?=
 =?us-ascii?Q?P+xJX4oYwUoAEgr7WFEmwQQw0485PH2Fa66ikeArx18MnyKxvZUf2qUkhjeH?=
 =?us-ascii?Q?d7/SciuFmFJuXuOZp6ZF7yFjC0NCceiDL4EgMBbZXO+1/t5oE4zGbHOvg+1j?=
 =?us-ascii?Q?FcExjRrVqRgopwgXWjOVUKTi+pcECIt0/Lo5uzQWxDJEox+fqAyVmf5//6tK?=
 =?us-ascii?Q?7j9iXlE6pZeVAXzhgeQ7j7o+CdTdAYVPx0n4oPdMVlHZ2PvqO2tZ8OQbRdg7?=
 =?us-ascii?Q?nW8D4nvDUlKyZ7e6Kb03S+RVY02N9tX5TqRMypeWdolv+DSoFCDvMM1uvm2+?=
 =?us-ascii?Q?S73RGNKlMieZWVyCrjaJy0l9bssipxxesOeR7LqyXFMsxPDVYLBn+L5qp6TT?=
 =?us-ascii?Q?oV6Ui7fmPLy4F5gLGNyd1HXZBKHge9gm2duU6ohl38TQY/4CNfgLc+zC70bt?=
 =?us-ascii?Q?emShvOhIyRvtRK4mxkVRF0TUB5XnftUN3QdSvRPJFIJ10ytE42lDJ6DP2Cw9?=
 =?us-ascii?Q?W+0qQd7+93lOHkBcNZkfrPwa4+iFE/dYKa0E2B3VRFLtYjlFevKjMbwMv46V?=
 =?us-ascii?Q?06NOwGHlT8ctXrW5Hu2KFA6p7bHFEku26TVRhnhqsDbcZebZAYr8BxucYQ0G?=
 =?us-ascii?Q?BNZ2JE1j1h7i+U9Q6XluIKGNw+mDYmrcGsDJj23iTyYaXmASqkvptEyTBDM3?=
 =?us-ascii?Q?hsRK8cZKQF+lDTM3J+qpK4GGQLgISdY6LCce801ShW9wmj76zaxM3xWHtiUe?=
 =?us-ascii?Q?bX98YzdHAeDl4mpKW2fI2HWVhIlh7lHBZ64HlAJ+TmyrgIEeg3k2/mRZWtnD?=
 =?us-ascii?Q?xLtg2szvCzJxNLCf/sNYUKY8OqIeOOaKtmLq4WdwyaUp4qWljtqwbtG780ue?=
 =?us-ascii?Q?tiPiq+g1EolpreUoDvOSspdzp3o/ae0Pf/e9Wg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c732533-25fe-4182-39c6-08da7c2ad87d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 06:21:09.2496 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mSG24LUxg2EA4174+yz5N7jf7l3mYUpYTnaLlM4DgtioEpc6f8tWsam3a9PVOE27hNQNnWk4CHYcMn6muisALF1mOoM4ijV+pIaDN9tix0I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4962
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-12_04,2022-08-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 spamscore=0 mlxscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208120016
X-Proofpoint-ORIG-GUID: Q3mQodcOsIpeRzI-Yx7eA0IFNvZqIe8u
X-Proofpoint-GUID: Q3mQodcOsIpeRzI-Yx7eA0IFNvZqIe8u
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
Cc: David Airlie <airlied@linux.ie>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 kernel-janitors@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This code has two bugs.  If kfd_topology_device_by_proximity_domain()
failed on the first iteration through the loop then "cpu_link" is
uninitialized and should not be dereferenced.

The second bug is that we cannot dereference a list iterator when it
points to the list head.  In other words, if we exit the
list_for_each_entry() loop exits without hitting a break then "cpu_link"
is not a valid pointer and should not be dereferenced.

Fix both of these problems by setting "cpu_link" to NULL when it is invalid
and non-NULL when it is valid.  That makes it easier to test for
valid vs invalid.

Fixes: 0f28cca87e9a ("drm/amdkfd: Extend KFD device topology to surface peer-to-peer links")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
I reported these in June but never heard back.

 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 25990bec600d..3f0a4a415907 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1392,8 +1392,8 @@ static int kfd_build_p2p_node_entry(struct kfd_topology_device *dev,
 
 static int kfd_create_indirect_link_prop(struct kfd_topology_device *kdev, int gpu_node)
 {
+	struct kfd_iolink_properties *gpu_link, *tmp_link, *cpu_link;
 	struct kfd_iolink_properties *props = NULL, *props2 = NULL;
-	struct kfd_iolink_properties *gpu_link, *cpu_link;
 	struct kfd_topology_device *cpu_dev;
 	int ret = 0;
 	int i, num_cpu;
@@ -1416,16 +1416,19 @@ static int kfd_create_indirect_link_prop(struct kfd_topology_device *kdev, int g
 			continue;
 
 		/* find CPU <-->  CPU links */
+		cpu_link = NULL;
 		cpu_dev = kfd_topology_device_by_proximity_domain(i);
 		if (cpu_dev) {
-			list_for_each_entry(cpu_link,
+			list_for_each_entry(tmp_link,
 					&cpu_dev->io_link_props, list) {
-				if (cpu_link->node_to == gpu_link->node_to)
+				if (tmp_link->node_to == gpu_link->node_to) {
+					cpu_link = tmp_link;
 					break;
+				}
 			}
 		}
 
-		if (cpu_link->node_to != gpu_link->node_to)
+		if (!cpu_link)
 			return -ENOMEM;
 
 		/* CPU <--> CPU <--> GPU, GPU node*/
-- 
2.35.1

