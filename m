Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EAB6C43334
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jun 2022 16:13:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1039D10E6F7;
	Wed, 29 Jun 2022 16:13:08 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com
 [205.220.165.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84AD410E6F7
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jun 2022 16:13:06 +0000 (UTC)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25TFEI10018657;
 Wed, 29 Jun 2022 16:13:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=nbw4IMGrkMaR5/zWJDMg58ihVyxS0TOaVb0Ujb+v/PI=;
 b=IDq59WpRjjsbL4uzuMlCMSfACX93iHDSeWAWCXWBUSzJSsznXkdGt9UbAcOxraZgQthM
 E4yhy/KMSjpR048IdksSFlMPFVs5sYyGjuzoaubh0VMIbeRwH5KCXDfgonbG2RzsQAag
 jAtvau/9ClbnFGGneJ42nKV2Imq7TNJwSGnTQXNLB7j3IIP0hW7Gz2dTXuREWHfvuopJ
 cf/w67OGpkras89m2VoCaGOzTrO/aIhZwUqvdT643wNfxZDXY9hvQ5HWH4jU4mudXhFJ
 jTURquoPKh59ZRxjaxbibnAZpz+DjVfSUrOplBJT/3FsC9lCR9dtDcmjmb2HZubvW0tl Pg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gwtwu9rvc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Jun 2022 16:13:02 +0000
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2)
 with SMTP id 25TG6wfU039176; Wed, 29 Jun 2022 16:13:01 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id
 3gwrt3np7x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 29 Jun 2022 16:13:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CsY2XA7bEhWkYbrYwXQ7mSYNZ8jZIMZvsAtIVDt35LCLeDkIeQElidgOd7tXysF6Xu0Swn7fUEnd2XadZ8IAhQhqpZkIO+2ESt8tfNgzKonCgqUQszyIN5w7AfrTTHE9Km8hgUWFMKfOaslLKJ/dvtHQQ6OKy8c+n3bZfBDzxjD13ZH0Hoj56OEYUtLOLb43NwUiN0DYSuf0+xTpBlocR0DHTxJNvnmJPb0tfpt7AqUa0crWtqnP+RQ5gI8ojlRcB3orrbKRYpvk7dbAg0QU6eb2diBO62dsjHMy6cfpzfyzqlULs3PJpWnBYXkyrwZGhGH3we8pTqRQDF7k8Z2Y1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nbw4IMGrkMaR5/zWJDMg58ihVyxS0TOaVb0Ujb+v/PI=;
 b=PTVtWaoIAsaDjrUcuWh3uB/tae7e5thxkqDssRkdvtnwpQllMJyBsQRn7yEniZrWTUkU6N+Ivn5rLVsjxb1UMBb5t3xVnPu8tFr5jrbL2AXsSKRa/0jwzmrGZkgrGrp3x5VqoeNFaUSY3HTPrPARr58lhBNnTbfFCcdlZP7JdUI5kK/ow93UrZVJiv0tGIdVS4WaDR8LKLLLNFx9htMaYYjAB1+i3w5HJfh2B4TfEISorQHA8kQiYkxL2LwDx3AV14Sp8D6rE3X9Uf3c9GfD33UNcFcBCLTXXwdJB5p1Vubi4yZheW5gfak4UG7Wd0rfpkBuW17sVmiS7CvhXitqlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nbw4IMGrkMaR5/zWJDMg58ihVyxS0TOaVb0Ujb+v/PI=;
 b=a+P0BspPF1PcXzZDPM6P5A6sV+aL+fVSVFnvARzSiFCD5V8KELFLFxV7qN1agg4FNTlnxZyzKw+I51hd6QDQtCrwJFX4V071WtqIOk5ahGaJJxX3XcnQkLJ+c5XO7+zDzZeJFsx9r3fQw14ia9ypRCQqHRjwm1EzUufdiG1GTb4=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN6PR10MB2033.namprd10.prod.outlook.com
 (2603:10b6:404:102::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 29 Jun
 2022 16:12:59 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5020:9b82:5917:40b%6]) with mapi id 15.20.5395.014; Wed, 29 Jun 2022
 16:12:59 +0000
Date: Wed, 29 Jun 2022 19:12:41 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Felix Kuehling <felix.kuehling@amd.com>
Subject: Re: [PATCH] drm/amdkfd: Fix warnings from static analyzer Smatch
Message-ID: <20220629161241.GM11460@kadam>
References: <20220628232538.1316250-1-Ramesh.Errabolu@amd.com>
 <846ecd13-edaf-c0eb-44a9-5232dca997c7@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <846ecd13-edaf-c0eb-44a9-5232dca997c7@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0017.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::22)
 To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ecd05d5-9d8c-41e1-9183-08da59ea3c0e
X-MS-TrafficTypeDiagnostic: BN6PR10MB2033:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C6SMyoEsLdm8+ONAGus677VDg0EKv1vAq17qhSuTbNoCK6JY5wgZk4wcdvP1p4wigNLgV7+3JYuNG0SBaYWDo04SUG4fTnp+SVUu2li79umBUXvNjVZP95fL3+e2fBwsU0+Ys7RIkNV0PObEQR6317CTdZS8kD1GVCu+HgkoVcSmH9UrWadzJcWQOQpMa+/gq0QClPWByYlBLcON2WZHsmelOyPP6EZJ5p2zqw+5YZsIh5kkYsDfsrqGBKvnmVU8Kn+a3dVPWw5GiCX6U8BuvCVWlB/FEUFFxb4mD1efJee2NFAWuTKIwY/Q5c/izffqt/ts1YqMw48Q2th0rSAwCCv/GkMRE8ZOCbXbC6uQ9tRmE0cQTmhv5E7+z7I8nVLhPfwXC9hUwJERMP3ndfGb8hXo1k3dULk0jaKVyp+jemk4Zx65aztMB920bKidbhugBcYFAoJTlRnqxhhPiGXoSNeagcJ9t+GSVE0DP+Ddfz6lMNqYhme/bEIv2hfFDuJCHKH59g5VaApHSzCrGu9XAQRFtuWOkKZcN6ie9FRsoGgSTm8vSSbqu66lnMtptZd1VeK0BoCl46L9uF0gx+vSqUHBjqHrNqkE2HDurDefevVmTJi6T379Zy+m6fgKf5miC/w5it7lF0CiFeDX0tRWf6y9DiquQxkgVAHVUZVhqOIEk01BAOWmUgy7dgsyGv0PAARf/bk6ZeIC1vsBX4cf/mmsPr2F7IC+CB3Ebfw/vuKil7mZHvw3Aiw3VZ5ZF42BCVEr6BIJC/w2P85hQW5NimZyE2RxFM16VbjIVAHDtPmjrD2JLzighQfSQDS6cdmC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1001MB2365.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(7916004)(366004)(346002)(39860400002)(136003)(376002)(396003)(6512007)(1076003)(6916009)(8936002)(186003)(66946007)(4326008)(9686003)(6486002)(8676002)(66476007)(26005)(66556008)(316002)(52116002)(83380400001)(38100700002)(38350700002)(41300700001)(6666004)(6506007)(86362001)(33716001)(478600001)(2906002)(33656002)(44832011)(5660300002)(5716014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Km7pjV2U+0MDfnWzKY7hZBYhL9LMaRLL6iInP4OD0aYGrdIx4uwa7QFLM1+v?=
 =?us-ascii?Q?WpUSdNlbDmzF5tJTbDzQiLhSfHN38oG/8UOD2V44kVUXweSErHvC+LUmgg7L?=
 =?us-ascii?Q?974YNHRqbZ5RLe3FRZ0w7HIRJhu7FcA8g/cziILWPr40E0qbXVD0PIWoXVjS?=
 =?us-ascii?Q?KLgbVm2yCyAcEmvhURxsAAIoLk/GSPvt6eCoEO0eJZnIP15tCL9dZ98E9cUW?=
 =?us-ascii?Q?5+usHJ3jkoU5H/DVEyIBb7qQg83mNcLe6ON7gZsRC1cqv3LII4F9VHXjEQhD?=
 =?us-ascii?Q?Tl8aWpZYJqL+fGjZv4XTvFcOJHCAivYLJl0SH8hgL0z/IeIlmje2RICj+lD/?=
 =?us-ascii?Q?ioxe1xRGFqpJgFsOTMRYZnCcC3r9q6BAH2+IRXF+mQApOhgwUFnHcqbq11Tu?=
 =?us-ascii?Q?jrb2G8kyeQG9PK/34gjrVuh4deSFtLXTrc8j5qz60fifeWqHnjCAGVvn2rq5?=
 =?us-ascii?Q?rTU767L6QjzyqpV0LLLRC8RdzpdadeqJnEoIczhlAyOxd7vxbRty3RAsStqw?=
 =?us-ascii?Q?tn0lv7RSerFTSuoP/7kh+VenhAWYW+0DxkrgvD7dVOL1H0vL0aXGKJDHfM65?=
 =?us-ascii?Q?RwRe7prL6HaO1djUFGQr1HXgRaBx1DmNLKYdIWdKN+gwIZeg5v6BnU7OV2PY?=
 =?us-ascii?Q?FuQ2sF58eX+kvUb48KeoWr/WtwVP6wCX3UX+T+NJmfYQSz1VvCJI9cy0QfAH?=
 =?us-ascii?Q?tMMK+Imfd0mpR2kzI0JAEr++fxcmUUSQuGzid1AeKq3FxoXd31VctNRRsvW7?=
 =?us-ascii?Q?Bti9TuCX9yyH+pW9iq4E4yAtk6sVfed9h6L3EODV1Wr0rfpjWrG+joR5coCS?=
 =?us-ascii?Q?koyZ7qE++Fj0lS63s04gVTcA3C6BNvCGv1Kz3bXYb/IjzX8fxGHgKv7v8Z3L?=
 =?us-ascii?Q?IXSCKQaQSEKAOBkt4lvOWHw6DiO23Xcnr7lAbnHPQXvUTJ2eYf2vWR29zMEN?=
 =?us-ascii?Q?+Cke2fUoheQ8tm5AGVR0dgebjR40/S/p82ODrFZ/BgP80g4Q7I/VtKckky15?=
 =?us-ascii?Q?WiEX7jf0D4KK/aHRKxxnu1lDuADVx5k7TYwwfkWYMYvtzHq2rhiLO07bZ0OZ?=
 =?us-ascii?Q?ucQSy+C+l6tQH17wAImcNG7tD9hNJ05/b49Y9XZHKWSybbBURT5lcFfqz97n?=
 =?us-ascii?Q?LdpnL/DGU/hEELL/N0LowHjOCxTW6gR9nKB/lybLP+c6B/kM37W78FoYRxU6?=
 =?us-ascii?Q?BW3+OVdFAHORQeApGfTyeyYFTATuZdXyEAFNcXyFYPTvQo/r7yl625QkgewQ?=
 =?us-ascii?Q?/Ol6zXPMsj8zAe6p/eCpjvAfZuU6OrIiWlUtV4wcqE+VsLF5LQ2hrWFVnUct?=
 =?us-ascii?Q?xvd1r1w/IYzO2zPYVJzTExDh/jE5MiNYIn2oIAuRrAUvoD4oSdhzi+raplUZ?=
 =?us-ascii?Q?I9USOEcJItcpuV+u1zdT3XCAR/H37J2IXE9nbwgxQpBbxfHZ9sxUqbkV0N+m?=
 =?us-ascii?Q?T5BZJ15ndiw30N+nK4GFlbIO+TcWk09BhX2mtPYDc5PdMYuJDwwYJSQR0Tnw?=
 =?us-ascii?Q?rArUaH3EpQ40a9ThxhoTu+cw+BIiuzZ65TkispLfk+plQzYPP7iYy5mQt4Sq?=
 =?us-ascii?Q?+JUrGT+nV6/A4JfqKDRVmH6tOef5On8j5yc1Z3uTP3/vWNETXyEQRN3Ladoz?=
 =?us-ascii?Q?/w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ecd05d5-9d8c-41e1-9183-08da59ea3c0e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 16:12:59.3028 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fap1jfg657O3BVx64R2Dm/8feGovx6SfBdp/NqLP3bHB0VmwvJ98F4nlU7znT204Da0rGYmGkqkd9UbK53zfONVjNVnsH1Eyj3UJ3OYlFXw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB2033
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517, 18.0.883
 definitions=2022-06-29_17:2022-06-28,
 2022-06-29 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 suspectscore=0
 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206290058
X-Proofpoint-ORIG-GUID: wLXBUyRxddkDMdj4tk7okY5_VSluho5Z
X-Proofpoint-GUID: wLXBUyRxddkDMdj4tk7okY5_VSluho5Z
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
Cc: Ramesh Errabolu <Ramesh.Errabolu@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Jun 28, 2022 at 07:41:09PM -0400, Felix Kuehling wrote:
> 
> Am 2022-06-28 um 19:25 schrieb Ramesh Errabolu:
> > The patch fixes couple of warnings, as reported by Smatch
> > a static analyzer
> > 
> > Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> >   drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 36 ++++++++++++-----------
> >   1 file changed, 19 insertions(+), 17 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> > index 25990bec600d..9d7b9ad70bc8 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> > @@ -1417,15 +1417,17 @@ static int kfd_create_indirect_link_prop(struct kfd_topology_device *kdev, int g
> >   		/* find CPU <-->  CPU links */
> >   		cpu_dev = kfd_topology_device_by_proximity_domain(i);
> > -		if (cpu_dev) {
> > -			list_for_each_entry(cpu_link,
> > -					&cpu_dev->io_link_props, list) {
> > -				if (cpu_link->node_to == gpu_link->node_to)
> > -					break;
> > -			}
> > -		}
> > +		if (!cpu_dev)
> > +			continue;
> > +
> > +		cpu_link = NULL;
> 
> This initialization is unnecessary. list_for_each_entry will always
> initialize it.
> 
> 
> > +		list_for_each_entry(cpu_link, &cpu_dev->io_link_props, list)
> > +			if (cpu_link->node_to == gpu_link->node_to)
> > +				break;
> > -		if (cpu_link->node_to != gpu_link->node_to)
> > +		/* Ensures we didn't exit from list search with no hits */
> > +		if (list_entry_is_head(cpu_link, &cpu_dev->io_link_props, list) ||
> > +			(cpu_link->node_to != gpu_link->node_to))
> 
> The second condition is redundant. If the list entry is not the head, the
> node_to must have already matched in the loop.
> 
> But I'm no sure this solution is going to satisfy the static checker. It
> objects to using the iterator (cpu_link) outside the loop. I think a proper
> solution, that doesn't make any assumptions about how list_for_each_entry is
> implemented, would be to declare a separate variable as the iterator, and
> assign cpu_link in the loop only if there is a match.

This patch will silence the Smatch warning.  Smatch is can parse the
code well enough to know that:

	list_entry_is_head(cpu_link, &cpu_dev->io_link_props, list)

and:

	cpu_link->node_to != gpu_link->node_to

are equivalent.  Or actually it's the reverses which are equivalent.  If
the cpu_link is at list_head then we can't know if they're equal or not
but if it's not a list_head then they must be equal.   Ugh...
Complicated to explain in English but easy to see in code.  If add some
Smatch debug code:

#include "/home/dcarpenter/smatch/check_debug.h"

...

		if (!list_entry_is_head(cpu_link, &cpu_dev->io_link_props, list))
			__smatch_compare(cpu_link->node_to, gpu_link->node_to);

Then it will display that:

drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c:1431 kfd_create_indirect_link_prop() cpu_link->node_to == gpu_link->node_to

*happy face*  Smatch knows that they are ==.

But your review comments are correct.  These days we prefer to just use
another pointer:

	found = NULL;

	list_for_each_entry() {
		if (entry == correct){
			found = entry;
			break;
		}
	}
	if (!found)
		return -ENODEV;

regards,
dan carpenter

