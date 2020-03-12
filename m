Return-Path: <SRS0=KrIT=45=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E34C10DCE
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 07:34:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C326B20578
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 07:34:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="p+1g5gPe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C326B20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D89E6E087;
	Thu, 12 Mar 2020 07:34:02 +0000 (UTC)
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4ECC86E087
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2020 07:34:01 +0000 (UTC)
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02C7TR8u079371;
 Thu, 12 Mar 2020 07:33:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=UrxjIf+z9KgVwEX8xgv2pXmC/uwFNN1BIl77V8uGR9I=;
 b=p+1g5gPeI3HjchWv9mkaTOCIgqIaYgWACeBUQUZViqXZht3fJVQStelDWWE3NVZ6O0up
 TBkjpu5n42TWYrYNCsQcovj6VGTWK8IlUedwbY6q6IEL80bScaA4IVk6n9i5WzQKt1Qs
 OgHg1acnncnPyN4poA30Nvz8XvYXJlb/PH8wRreuigMlysj5KpgnJahHK5B4eAeftD5E
 piL9Ygx4NQBJJi7MXniF08b0oRg2nsdHrwofKQ9rnp5wMHkuRaR3O/TXP3itD5xkwTlI
 Htef/SblbyN/74WBlhE0LTsgdVMjGCeP2d5yWkxe3+qdxbOP+8VexGzYvua6QRpekvNZ Jg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 2yp7hmc8hp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Mar 2020 07:33:58 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02C7WGlD135991;
 Thu, 12 Mar 2020 07:33:57 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3020.oracle.com with ESMTP id 2yp8p6c4cu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 12 Mar 2020 07:33:57 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02C7Xuv1018819;
 Thu, 12 Mar 2020 07:33:56 GMT
Received: from mwanda (/41.57.98.10) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 12 Mar 2020 00:33:56 -0700
Date: Thu, 12 Mar 2020 10:33:51 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: tao.zhou1@amd.com
Subject: [bug report] drm/amdgpu: add function to creat all ras debugfs node
Message-ID: <20200312073351.GA29451@mwanda>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9557
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0 phishscore=0
 spamscore=0 malwarescore=0 adultscore=0 suspectscore=1 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003120039
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9557
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0
 priorityscore=1501 clxscore=1011 mlxscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=1 phishscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003120039
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
Cc: amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hello Tao Zhou,

The patch f9317014ea51: "drm/amdgpu: add function to creat all ras
debugfs node" from Mar 6, 2020, leads to the following static checker
warning:

	drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:1132 amdgpu_ras_debugfs_create_all()
	warn: variable dereferenced before check 'obj' (see line 1131)

drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
  1116  void amdgpu_ras_debugfs_create_all(struct amdgpu_device *adev)
  1117  {
  1118          struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
  1119          struct ras_manager *obj, *tmp;
  1120          struct ras_fs_if fs_info;
  1121  
  1122          /*
  1123           * it won't be called in resume path, no need to check
  1124           * suspend and gpu reset status
  1125           */
  1126          if (!con)
  1127                  return;
  1128  
  1129          amdgpu_ras_debugfs_create_ctrl_node(adev);
  1130  
  1131          list_for_each_entry_safe(obj, tmp, &con->head, node) {
  1132                  if (!obj)
                            ^^^^
There is no need to check for NULL here, so just remove the check.  The
other question is why is this using list_for_each_entry_safe() instead
of vanilla list_for_each_entry()?  It doesn't seem to be freeing "obj"
or removing "obj" from the list which are basically the only reasons
why _safe() is used.  Some people think _safe() has something to do with
locking but it doesn't.

Please remove the test and use vanilla list_for_each_entry().

  1133                          continue;
  1134  
  1135                  if (amdgpu_ras_is_supported(adev, obj->head.block) &&
  1136                          (obj->attr_inuse == 1)) {
  1137                          sprintf(fs_info.debugfs_name, "%s_err_inject",
  1138                                          ras_block_str(obj->head.block));
  1139                          fs_info.head = obj->head;
  1140                          amdgpu_ras_debugfs_create(adev, &fs_info);
  1141                  }
  1142          }
  1143  }

regards,
dan carpenter
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
