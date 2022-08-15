Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B271BC25B0E
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Aug 2022 11:25:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D9F099CBE;
	Mon, 15 Aug 2022 11:25:13 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9377D14A75F
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Aug 2022 11:24:20 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27FAGmBo031588;
 Mon, 15 Aug 2022 11:24:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=a0TeEGk4vncRKZ0r6bgfXXtAcYHMKsPfU8WMFRtDj0I=;
 b=Ep7XwF+G74VPPB3H/esA0Kyfk5wgL/TcI7TWk7psVb/o1249FJjOd81WcM96+IKrSJT1
 2/utUKen6dw9Z0l2y/X8JJyaiGDY6GAiFDX4ysR0HkQFU9afJOlF0v/XVQhUDqNZVBap
 3dQ5eGsb1e6UA9s9RmoPaqlnfoW9lsN4AmJuvjYqYhLlQKVY107QJZP7XKcpobZCgrF6
 F/0JGdXWw+QBwVy1SbIHY9NHP59jheP4UI+7fGWE+wlOI9nWSTy8TDb1msH9fMTCyoE2
 DImhMs2HXrEo0vntmGeWlNippal9AXgioWPxdXa/ZJad+oBw9Q3uynOCGHCdP8+D9Q5R Rg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hx2ccjs5t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 15 Aug 2022 11:24:17 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5)
 with ESMTP id 27F9tORr003948; Mon, 15 Aug 2022 11:24:16 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 3hx2d1a742-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 15 Aug 2022 11:24:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BboICSa6LkqQ68Q460F+lZyT0cCixPB2y1rJY96lCRjPIAMJT69MtA8IYWVI+nuwGFK80Uj9IELTKZa44lwz1Nc92Ce3/PuU6omzE2BhruPhKKt9DiPAgMddmuVfmxFbGXOzQ+AclymHTNUUJ/PF2/qcH2g/FIrxAudw/2HIMBidxekxN8R3f5fsZKqqOls70JfPjnQOx2DfEvYVYxADI+5rpi5JQoGZ+ULytwYTqYue8jOPfTElXsfX78usp7oisVIM0K4+m8x+3U44xQKj+ehqE+VdzyFGQb/jdoYiuHsYaLKqT/gX/aC0fWeQAh65v6NnHgFVIyPEIjD6ABdKWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a0TeEGk4vncRKZ0r6bgfXXtAcYHMKsPfU8WMFRtDj0I=;
 b=RPX4Chk65XIfjEffbuDJK2nFRpbaNQAjQPFennqGWqFAe6SVDrxYzfaJlGTyAR8hi9hSbGKZLflnhXrC8btUUKlAhuvpiDlC5Dp/wMu2Ro30/sNUziJomZUDEgy3S9WSpOlNTyUsSjEtU+YqrDpPhsnIrX7VjaGcrVYvvW2B8Xh2LpISOCeN7nDLY6YB/iGMEgIbZ2l5UqaE3pj8VhGS2EIyG7Adqc4KFa0SpRrqVfMIQVPA1xLc5Y+Cohkdyzrs/RwA/lSjHgd6fOFhn3l6A2GUs/C0dSUJr2LSVzsXhEEHfwg9eJ6uxCRbKNAGhyzzCowJNWP6IGeVKkZT47E8Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a0TeEGk4vncRKZ0r6bgfXXtAcYHMKsPfU8WMFRtDj0I=;
 b=lJq7UuGZseM0DbhTIe2ixCzK1PheFcGjSI3vLXAp5zh2ipkf63uYlQyACTxCqTAdDSSkKw+6YW7WShcG4MrS3EPiwo600D/KZW86pC89witYptlauqZ9Blj0nRAKwMNJ7kR4NKrr6FUMXy8o37NNvnHDmfN+Le056PHrcrTZwOw=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MN2PR10MB3407.namprd10.prod.outlook.com
 (2603:10b6:208:123::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Mon, 15 Aug
 2022 11:24:11 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::209e:de4d:68ea:c026%3]) with mapi id 15.20.5504.028; Mon, 15 Aug 2022
 11:24:11 +0000
Date: Mon, 15 Aug 2022 14:23:59 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Felix Kuehling <felix.kuehling@amd.com>
Subject: Re: [PATCH] drm/amdkfd: potential crash in
 kfd_create_indirect_link_prop()
Message-ID: <20220815112358.GA3460@kadam>
References: <YvXxSkLaaSMLU8fT@kili>
 <8fe840db-ccba-0dae-23fe-d08db0b35167@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fe840db-ccba-0dae-23fe-d08db0b35167@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR1P264CA0186.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:58::15) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 423828c4-3294-4f0b-5e8b-08da7eb0ad42
X-MS-TrafficTypeDiagnostic: MN2PR10MB3407:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l0FZ8EcswsQjSrtqt665lpYC0hRWjxWJoWOZWThBX+8jpIEC+zT/Gm1QtbvxlRGFPn4cq2uth5ocUSQiwM7+p4Az0F+m/4u7oVIYLp4ltFNvlp4/fyyBBov6xj08NHoEppLTTp3ShalC2WsqHIHsMtONRltKKFuXPS9JCLZwN8hTrDVANpmC9p70aA530AcZKzTn3O6DGNpnHy9WQ0mzoAhhtQoU1PP+Wxigli7h0iZ2xAXSSVbET8u2ojURysI8XN+AMLAxtA17SvGtzrNAaDL1YwxWZKHTkS96slg72wZ91Pb8EZ1OHFsdpvu6CobRsrWn7A9xn11h4xITmpv1jHCOJpKk8gfmSwPGswjyH3czT2yhUb3Q2sVS7tPi3tTgaoID/jpGSekYAivmzXMmvp5IJ1xztSKbUKWd6guDWiWwBWYwvjKMgzbJyKTzqxIyl78doV4cLfxkBu8cssOWTl8+CwrsK88hkHfWF+t/d/9zCxlmJdSKuUoFeSP8cBhuTfn5TiRceoyZqDWOlcxYxAxZsjKlZpqwiKn4twpRe0jmU3k134AQz0815FM8ozcy96GhKWLcF+vb3QyCWlkqSR2j+MS0OLO/pNMlp3n75IqVr0QCvUebCCLiawEcKXagHNApn85qch6dWFLkYjSQy0thYZuGwgJejDy0OeXZdYN/kPR1DUJGeoyK+c4g0miM+K4UTSid9qAZnnEduiA/AGrZz51xDETcFYl3FQ6ONv78s+8rahOA37GZvtes9viTjWhN0Mt704sP7fkA4cjIpwhIlybuw03hBDKUp4cpPGxJn57nAuvhckQtLTtaxbE4n3W29YHioMAplRLdTaCEOMCRydd68PzfZcofFTpUbtXm7N2EN9a6WXCODfUOOm7I
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1001MB2365.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(7916004)(346002)(366004)(396003)(376002)(136003)(39860400002)(66556008)(66476007)(186003)(1076003)(6512007)(6506007)(9686003)(26005)(52116002)(53546011)(478600001)(66946007)(966005)(6486002)(41300700001)(33716001)(33656002)(6666004)(86362001)(4326008)(8936002)(38100700002)(5660300002)(6916009)(44832011)(2906002)(38350700002)(316002)(8676002)(54906003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xiN5on2dIrL0UPzkG+ykYzEdJbd8KkmuZ53BD8vLjmPMLGf0xB0jIuP/KGk7?=
 =?us-ascii?Q?u4ZaTyIeOgW4WMJTdu+QNwA676TfrctSJqafj3YA9jylCIDzwmk/LJq5tY76?=
 =?us-ascii?Q?rIMUh1QATmtfqS7lmas4zj/eZxDfRaCBaNh1q0OaRwPiKoCkpFCxYJlnSw4h?=
 =?us-ascii?Q?0fYiWrNU73VLTfbQkd3g4P242Kk48G4GfAFPL/gDK5blyklzWT6thTAttj+G?=
 =?us-ascii?Q?pHBcZ2DlQFURyFnebktb2J713nu22YaLJuZAFzduFiakCmHJ2F/xEnZgWOBM?=
 =?us-ascii?Q?vKeTqtxeqfUjajEC/qwEp7sRks2SOUNawVC29tCOK7V5uummzo1qdwIlNKHm?=
 =?us-ascii?Q?jK2+ZwcY5BOQtD3ZAD/viqig71+QzArKFsZ2KD0o3h46YP8hQz8vGOzrvzXw?=
 =?us-ascii?Q?ZJWf7FaFR2rn2Il/O7QbcmRYIvjPYeMhFsRJlxDHuJo2d8w/fnwFQtuumTm+?=
 =?us-ascii?Q?x3HYCIrWki3/c9RH8EDkmw2fkRP2Pip/BvaP4jlv6iYcYBivmozAcTsDj9mi?=
 =?us-ascii?Q?FnEX5+9+O6YpKbq8aKAIrs3oWvPEbpsLpsMew136mhBCVbzhT1EHh977pZgf?=
 =?us-ascii?Q?KJTBpXrxZ2q5dQ5f0T/eNnsjl4PoUWGSv6jfGFeQjHByuSCLR1U5Mqtz0LiH?=
 =?us-ascii?Q?b+2VNk3BmszTswyTwkbjnBlb82h7bXOeQxLcipxEMVUp0t0O/vo57nN9skdH?=
 =?us-ascii?Q?zKcaP6G+oJtopLlV+kRgzpQdC3pTHPJUOFGAjE++qr5/0TVOvExTsLtTC5Jl?=
 =?us-ascii?Q?F+PTNLIcPY/r9M69mULcRGyf247ajNcvNXLq9L0Eh6Pzdbpe2kZRLOXCs0dK?=
 =?us-ascii?Q?D5uI6iHqOnEJcv23DIfCbwKvMZ14NGp5AEeOHDIQ2ZnKPBKUXIdy4+J0Ns2I?=
 =?us-ascii?Q?UQrGvWxuj2n6/CD03QfnCPgq63gvW+bouQcH07wRW276Y70DdxWgragqZnJk?=
 =?us-ascii?Q?Y93wl7qyGSWOj6DEiAn4cSfSXBHcyLiv6IqVW9EJURcVM8J4KoV9lL3VrgDD?=
 =?us-ascii?Q?1oe4pX+cciT6hfxmW7Ye/R9QhnKR6MAAmhwBcl1mHEhu+VHiuXCaCsUWDt7v?=
 =?us-ascii?Q?upQ7VSyDA55JNN5MSWfKRiRr5jTtwuKTbfyEVasHAe56wnm0L5R2N+WVezry?=
 =?us-ascii?Q?gb29PmJ+8SqCcYd5/sXb0P0q5qDQyRqLLbRpaI8qjLyn03hLDKStEJLzI/5V?=
 =?us-ascii?Q?gxdVWofZ9DGvkY+Tvjz/2DMuV4yfxvFFk26xlL8kebX+fRbZ8zb1bfJOtVPD?=
 =?us-ascii?Q?0Ak9fOBO2CJRq5H7GLBwLSjwOEsT/yW3Mcc1rjYbA8Iqavi6nLloGp/aI2v3?=
 =?us-ascii?Q?4zifrNCq2lYRwP/oUHeBiYEGKynYB6kfsmj1rsgE29Ck6zitjMuwQNkrGIs6?=
 =?us-ascii?Q?Xa1nTfix6Gf1z4y6oHAfWi8QI9EscyHSIk+ibtfH7nWJW7+uizaOJS8kxG/Y?=
 =?us-ascii?Q?iQtmYy70rrep+YI9CvRWihw0AYgpwuw0Hi4yC8Li/GguQh005B2216af0XGL?=
 =?us-ascii?Q?3Wcftw2Xe9EoA8bjKckNCUtQK+1sW9iyDCKRAZe9r/votSiD9+rZcZjku41i?=
 =?us-ascii?Q?lJhqf7s2LfDXdbVCs3LIj6OKSJa2LEI+OJ5C9294?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?DyHlOfxUbWMOSZ04bNk2PfNQZ1g+3oXUg6l3auGcoVut5kbeY6C49EmmYgJb?=
 =?us-ascii?Q?1l7+lO1I6uJ2HD0XdaM/uSvIIYlipMym1OSpe+J2Fcg7rxbJBKPzELuXUdjY?=
 =?us-ascii?Q?zyBoWlp3f5xDpg4r1EVQg3+y6NyF3h5rVLnkPgYzhnaFHXrZhjKv/WJtUBfA?=
 =?us-ascii?Q?p/+UQWTc97njvioi+pMz31wyOzkBR8kOG/doKoISfFUCiLtnBl1FkHtbNz0K?=
 =?us-ascii?Q?5MCyM8v3V4r7Cmb4UOpnJMnTRW/GnxlfwsmrBsnDAuREFTJEX/i8XnHpolfY?=
 =?us-ascii?Q?PEjPTs84BY2Jaxtq0G8mQMeLtux5OqW3XCBkPWddJBWxOurSec52TzK0CCRd?=
 =?us-ascii?Q?yOJXb05xBRPQVbFz3CRfCdDNbHmF3bE6wQErX2fHOwYavaThtvaCjWhCV2ut?=
 =?us-ascii?Q?Y+xhBEqrBb/V/LUiD2dtiV3Nmw0vBcgM9lR6rNvbh3+VTqbFbsjADGoB/Xe4?=
 =?us-ascii?Q?QPWEAr6qzhq3BXguuO1Wb1mdmFA7LAiCOG4rNAbZa+kSv+YHt9BW5fqCOeYX?=
 =?us-ascii?Q?dde+rDD6StESnzf+qmW+/zamFkCmxNJHFcItdvJD2H+7IuhJTi9hIx2Noowt?=
 =?us-ascii?Q?4SX9vzvF8kF9VnVpDiQOkpc7Ftlj0Ob/5kKidQbOOU/Xn9cUJOROtUFXsECN?=
 =?us-ascii?Q?PRNoOap0pDbWwVXt9s+JNFEgWK5IUd23wW/0NcwLdAmtsIaGXXDfM1e4XpFs?=
 =?us-ascii?Q?Z0ppcdHR+PqkL9SZyqDVRfPDa7heYKWWIsJYDezmIJ6eoDgtZQAXzNzs/A1f?=
 =?us-ascii?Q?fP/UbQlnp617beWotchJ6RbAFKtRaw9UQjdJg/AAIHEz3tAm9+svVXGMD/b1?=
 =?us-ascii?Q?sV0EinKtOh2+7utC69cDxIdW5o87UxUxEBPV2Ir1vSXbID6brEQSeDtAa1+N?=
 =?us-ascii?Q?2mmcbV0G/ZS9IsksC0wvwjSXeKQjWL6nc0jQ545wrOvp8i0BZR2Akzh3yoBs?=
 =?us-ascii?Q?ex2Gp75hMa2aCTJy8TvQTXbZg6rJNeHyywqiuFqX93DqefbDfpZoWmQmD2SN?=
 =?us-ascii?Q?rdpFByXTM8ceZYNE3FmGIDzFqPiSHwKg0UDOGFYEmJofadkBUmPuT55OoARu?=
 =?us-ascii?Q?QDJFKojf4n621GyBJuhdag1VmhpMQsuD2LMcJ6FWdQhFeaSW74vAwBx8HNSQ?=
 =?us-ascii?Q?kv1Ya1Wgi0maN6iHHFPuqk5chQzQE2hmIqmHnlXBO59nFZazEqhC/HC74lUx?=
 =?us-ascii?Q?DF3gahONgwLv5cRzipXOUpJ+nelzRvjWNoJElA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 423828c4-3294-4f0b-5e8b-08da7eb0ad42
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 11:24:11.6404 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XtK5Wo2zTmotr3sNwfs1n169J/lEP3AEmNEXPzUKcAW7wmqrxRHnsHr54seMnOeZ9s9XpKa2kTew8UwoVAvw/hgHKBdqo/hEVMJjiF5/SfI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3407
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-15_06,2022-08-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208150043
X-Proofpoint-GUID: iJqWXrvoMH2hgFL5zN_0kIiv_n6_UddY
X-Proofpoint-ORIG-GUID: iJqWXrvoMH2hgFL5zN_0kIiv_n6_UddY
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
 Ramesh Errabolu <Ramesh.Errabolu@amd.com>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Aug 12, 2022 at 05:10:51PM -0400, Felix Kuehling wrote:
> On 2022-08-12 02:20, Dan Carpenter wrote:
> > This code has two bugs.  If kfd_topology_device_by_proximity_domain()
> > failed on the first iteration through the loop then "cpu_link" is
> > uninitialized and should not be dereferenced.
> > 
> > The second bug is that we cannot dereference a list iterator when it
> > points to the list head.  In other words, if we exit the
> > list_for_each_entry() loop exits without hitting a break then "cpu_link"
> > is not a valid pointer and should not be dereferenced.
> > 
> > Fix both of these problems by setting "cpu_link" to NULL when it is invalid
> > and non-NULL when it is valid.  That makes it easier to test for
> > valid vs invalid.
> > 
> > Fixes: 0f28cca87e9a ("drm/amdkfd: Extend KFD device topology to surface peer-to-peer links")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> > I reported these in June but never heard back.
> 
> I thought Ramesh implemented a fix for this:
> https://lore.kernel.org/all/20220706183302.1719795-1-Ramesh.Errabolu@amd.com/
> 
> You commented on a version of his patch:
> https://lore.kernel.org/all/20220629161241.GM11460@kadam/

Oh, Sorry!  I appologize for forgetting that.

> 
> Did this get lost somehow? Anyway, your patch looks good to me and I'm going
> to apply it to amd-staging-drm-next now.
> 
> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>

Looking at Ramesh's patch now, he added a continue if
kfd_topology_device_by_proximity_domain() failed.  That is a behavior
change, but it might also be a bug fix.

My patch does not change the behavior except for eliminating the crash
so I stand by my patch, but adding the continue might be a good thing to
do as a separate step.  I don't know the code well enough to say one way
or the other.

regards,
dan carpenter

