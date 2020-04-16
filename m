Return-Path: <SRS0=B7jy=6A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B016C2BB55
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 13:24:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F17F206E9
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 13:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TZKdXzWm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F17F206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8BFA6E049;
	Thu, 16 Apr 2020 13:24:26 +0000 (UTC)
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 443916E049
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2020 13:24:25 +0000 (UTC)
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03GDO0OS051371;
 Thu, 16 Apr 2020 13:24:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=z5oZLHGYHlYr7HdqmMBBNIwCCTENNcdo6UVafcX9hm8=;
 b=TZKdXzWmeJMsoMmkGjBK1/W59Vrt59aSeOmT3EZO3UNaiEfXlkrH1/IMqJ2bgxJ3bUQI
 x5nw4B6eVBQmVvXkLBLB+zjgkrYuQOoJTwktIsZSawkIZSmdntbnEFU7Gdd6PBVtPfZI
 9XQSwsMt43K4OuixW2XV+IC80OnkfyQulGnA1CSU63c8e2rCNxnHh1KCGWe+Ia4n84pR
 ZfyaLu437S81TJ8y+3gQZ1Gd591veG/V9QMdqnMR/cu6ZLsF1mdw660vJlV0CpfDhMr4
 viFb3lubquuHUH6PYkzVzntFfFhgqA89Sj755WE4g/LXnCHjksCP28Dgutp1o2QXYrky jg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 30e0aa6vrp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Apr 2020 13:24:20 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03GDN83H016680;
 Thu, 16 Apr 2020 13:24:20 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3020.oracle.com with ESMTP id 30emen1sv3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Apr 2020 13:24:20 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03GDOJgF025997;
 Thu, 16 Apr 2020 13:24:19 GMT
Received: from mwanda (/41.57.98.10) by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 16 Apr 2020 06:24:18 -0700
Date: Thu, 16 Apr 2020 16:24:13 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Bhawanpreet.Lakha@amd.com
Subject: [bug report] drm/amd/display: Add HDCP module
Message-ID: <20200416132413.GA628534@mwanda>
MIME-Version: 1.0
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9592
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 suspectscore=3
 mlxlogscore=999 phishscore=0 spamscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004160095
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9592
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 clxscore=1015
 impostorscore=0 mlxlogscore=999 mlxscore=0 lowpriorityscore=0
 suspectscore=3 adultscore=0 spamscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004160095
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

Hello Bhawanpreet Lakha,

The patch 4c283fdac08a: "drm/amd/display: Add HDCP module" from Aug
6, 2019, leads to the following static checker warning:

	drivers/gpu/drm/amd/amdgpu/../display/dc/hdcp/hdcp_msg.c:132 hdmi_14_process_transaction()
	error: buffer overflow 'hdcp_i2c_offsets' 32 <= 32

drivers/gpu/drm/amd/amdgpu/../display/dc/hdcp/hdcp_msg.c
    77  
    78  static const uint8_t hdcp_i2c_offsets[] = {
    79          [HDCP_MESSAGE_ID_READ_BKSV] = 0x0,
    80          [HDCP_MESSAGE_ID_READ_RI_R0] = 0x8,
    81          [HDCP_MESSAGE_ID_READ_PJ] = 0xA,
    82          [HDCP_MESSAGE_ID_WRITE_AKSV] = 0x10,
    83          [HDCP_MESSAGE_ID_WRITE_AINFO] = 0x15,
    84          [HDCP_MESSAGE_ID_WRITE_AN] = 0x18,
    85          [HDCP_MESSAGE_ID_READ_VH_X] = 0x20,
    86          [HDCP_MESSAGE_ID_READ_VH_0] = 0x20,
    87          [HDCP_MESSAGE_ID_READ_VH_1] = 0x24,
    88          [HDCP_MESSAGE_ID_READ_VH_2] = 0x28,
    89          [HDCP_MESSAGE_ID_READ_VH_3] = 0x2C,
    90          [HDCP_MESSAGE_ID_READ_VH_4] = 0x30,
    91          [HDCP_MESSAGE_ID_READ_BCAPS] = 0x40,
    92          [HDCP_MESSAGE_ID_READ_BSTATUS] = 0x41,
    93          [HDCP_MESSAGE_ID_READ_KSV_FIFO] = 0x43,
    94          [HDCP_MESSAGE_ID_READ_BINFO] = 0xFF,
    95          [HDCP_MESSAGE_ID_HDCP2VERSION] = 0x50,
    96          [HDCP_MESSAGE_ID_WRITE_AKE_INIT] = 0x60,
    97          [HDCP_MESSAGE_ID_READ_AKE_SEND_CERT] = 0x80,
    98          [HDCP_MESSAGE_ID_WRITE_AKE_NO_STORED_KM] = 0x60,
    99          [HDCP_MESSAGE_ID_WRITE_AKE_STORED_KM] = 0x60,
   100          [HDCP_MESSAGE_ID_READ_AKE_SEND_H_PRIME] = 0x80,
   101          [HDCP_MESSAGE_ID_READ_AKE_SEND_PAIRING_INFO] = 0x80,
   102          [HDCP_MESSAGE_ID_WRITE_LC_INIT] = 0x60,
   103          [HDCP_MESSAGE_ID_READ_LC_SEND_L_PRIME] = 0x80,
   104          [HDCP_MESSAGE_ID_WRITE_SKE_SEND_EKS] = 0x60,
   105          [HDCP_MESSAGE_ID_READ_REPEATER_AUTH_SEND_RECEIVERID_LIST] = 0x80,
   106          [HDCP_MESSAGE_ID_WRITE_REPEATER_AUTH_SEND_ACK] = 0x60,
   107          [HDCP_MESSAGE_ID_WRITE_REPEATER_AUTH_STREAM_MANAGE] = 0x60,
   108          [HDCP_MESSAGE_ID_READ_REPEATER_AUTH_STREAM_READY] = 0x80,
   109          [HDCP_MESSAGE_ID_READ_RXSTATUS] = 0x70

HDCP_MESSAGE_ID_WRITE_CONTENT_STREAM_TYPE is missing.  This array should
have HDCP_MESSAGE_ID_MAX elements.

   110  };
   111  
   112  struct protection_properties {
   113          bool supported;
   114          bool (*process_transaction)(
   115                  struct dc_link *link,
   116                  struct hdcp_protection_message *message_info);
   117  };
   118  
   119  static const struct protection_properties non_supported_protection = {
   120          .supported = false
   121  };
   122  
   123  static bool hdmi_14_process_transaction(
   124          struct dc_link *link,
   125          struct hdcp_protection_message *message_info)
   126  {
   127          uint8_t *buff = NULL;
   128          bool result;
   129          const uint8_t hdcp_i2c_addr_link_primary = 0x3a; /* 0x74 >> 1*/
   130          const uint8_t hdcp_i2c_addr_link_secondary = 0x3b; /* 0x76 >> 1*/
   131          struct i2c_command i2c_command;
   132          uint8_t offset = hdcp_i2c_offsets[message_info->msg_id];
                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Potential out of bounds access.

   133          struct i2c_payload i2c_payloads[] = {
   134                  { true, 0, 1, &offset },
   135                  /* actual hdcp payload, will be filled later, zeroed for now*/
   136                  { 0 }
   137          };
   138  

regards,
dan carpenter
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
