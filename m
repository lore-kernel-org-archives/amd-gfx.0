Return-Path: <SRS0=JxR8=6U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F00BC28CBC
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2020 09:17:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0ADC20714
	for <amd-gfx@archiver.kernel.org>; Wed,  6 May 2020 09:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="q1mOJxer"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0ADC20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78FDC89E65;
	Wed,  6 May 2020 09:17:48 +0000 (UTC)
Received: from aserp2120.oracle.com (aserp2120.oracle.com [141.146.126.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E422889E65
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 May 2020 09:17:46 +0000 (UTC)
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0469DAhF149002;
 Wed, 6 May 2020 09:17:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=maFuIe9HNv+sS7TiR4TBps12ILr3/mf0dEb9OsbfPc0=;
 b=q1mOJxer6KhupOXYTUuZdDaJBuVl3mTNHqaqBPeyXwGXW5T1of140p9GSrokO1bpXWbJ
 /Ie9CwtO6yQdq/R9ZU0LWaBLpXrS52YCPeyB6LInSUCuq9uDaNVbesBQP1d3Jk4i4ELi
 Z74HKcWvnZ3UqiSnMiFjn7fqVeQddzzKdP4jmv0Y9gcWIkMBhSD/GKPtvjH668i8mNVh
 VTrpckYq7sGdR9pvGJ21vVowhfhcW9I/42vAjK9eA9TVHqqo+MzENuQ/GT1oVhyoaEj1
 AwSR+sFvUBZZrNWLR2KdzYrnmS1y6hhSJf4I02QhAKeJ5J+0Lc7EHyq/TDJS65kvKAA8 aQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 30usgq0c65-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 06 May 2020 09:17:43 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0469CZDI112344;
 Wed, 6 May 2020 09:17:42 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3020.oracle.com with ESMTP id 30us7m4y49-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 06 May 2020 09:17:42 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0469HfsQ016523;
 Wed, 6 May 2020 09:17:41 GMT
Received: from kadam (/41.57.98.10) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 06 May 2020 02:17:40 -0700
Date: Wed, 6 May 2020 12:17:34 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: Re: [bug report] drm/amdgpu: add amdgpu_ras.c to support ras (v2)
Message-ID: <20200506091734.GH1992@kadam>
References: <20200505091239.GA117990@mwanda>
 <BYAPR12MB288896162E5761D45A5077DFB0A40@BYAPR12MB2888.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR12MB288896162E5761D45A5077DFB0A40@BYAPR12MB2888.namprd12.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9612
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 adultscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005060073
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9612
 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 clxscore=1011
 mlxlogscore=999 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005060073
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
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, May 06, 2020 at 07:26:16AM +0000, Zhou1, Tao wrote:
> [AMD Public Use]
> 
> Hi Dan:
> 
> Please check the following piece of code in amdgpu_ras_debugfs_ctrl_parse_data:
> 
> 	if (op != -1) {
> 		if (amdgpu_ras_find_block_id_by_name(block_name, &block_id))
> 			return -EINVAL;
> 
> 		data->head.block = block_id;
> 
> amdgpu_ras_find_block_id_by_name will return error directly if someone try to provide an invalid block_name intentionally via debugfs.
> 

No.  It's the line after that which are the problem.

drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
   147  static int amdgpu_ras_debugfs_ctrl_parse_data(struct file *f,
   148                  const char __user *buf, size_t size,
   149                  loff_t *pos, struct ras_debug_if *data)
   150  {
   151          ssize_t s = min_t(u64, 64, size);
   152          char str[65];
   153          char block_name[33];
   154          char err[9] = "ue";
   155          int op = -1;
   156          int block_id;
   157          uint32_t sub_block;
   158          u64 address, value;
   159  
   160          if (*pos)
   161                  return -EINVAL;
   162          *pos = size;
   163  
   164          memset(str, 0, sizeof(str));
   165          memset(data, 0, sizeof(*data));
   166  
   167          if (copy_from_user(str, buf, s))
   168                  return -EINVAL;
   169  
   170          if (sscanf(str, "disable %32s", block_name) == 1)
   171                  op = 0;
   172          else if (sscanf(str, "enable %32s %8s", block_name, err) == 2)
   173                  op = 1;
   174          else if (sscanf(str, "inject %32s %8s", block_name, err) == 2)
   175                  op = 2;
   176          else if (str[0] && str[1] && str[2] && str[3])
   177                  /* ascii string, but commands are not matched. */

Say we don't write an ascii string.

   178                  return -EINVAL;
   179  
   180          if (op != -1) {
   181                  if (amdgpu_ras_find_block_id_by_name(block_name, &block_id))
   182                          return -EINVAL;
   183  
   184                  data->head.block = block_id;
   185                  /* only ue and ce errors are supported */
   186                  if (!memcmp("ue", err, 2))
   187                          data->head.type = AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
   188                  else if (!memcmp("ce", err, 2))
   189                          data->head.type = AMDGPU_RAS_ERROR__SINGLE_CORRECTABLE;
   190                  else
   191                          return -EINVAL;
   192  
   193                  data->op = op;
   194  
   195                  if (op == 2) {
   196                          if (sscanf(str, "%*s %*s %*s %u %llu %llu",
   197                                                  &sub_block, &address, &value) != 3)
   198                                  if (sscanf(str, "%*s %*s %*s 0x%x 0x%llx 0x%llx",
   199                                                          &sub_block, &address, &value) != 3)
   200                                          return -EINVAL;
   201                          data->head.sub_block_index = sub_block;
   202                          data->inject.address = address;
   203                          data->inject.value = value;
   204                  }
   205          } else {
   206                  if (size < sizeof(*data))
   207                          return -EINVAL;
   208  
   209                  if (copy_from_user(data, buf, sizeof(*data)))
                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This lets us set the data->head.block to whatever we want.  Premusably
there is a trusted app which knows how to write the correct values.
But if it has a bug that will cause a crash and we'll have to find a
way to disable it in the kernel for kernel lock down mode etc so either
way we'll need to do a bit of work.

   210                          return -EINVAL;
   211          }
   212  
   213          return 0;
   214  }

regards,
dan carpenter

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
